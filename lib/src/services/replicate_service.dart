import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReplicateService {
  final String _apiToken = dotenv.env['REPLICATE_API_TOKEN'] ?? '';

  Future<String> generateRespose(
    String prompt, {
    Function(String partial)? onPartial,
  }) async {
    final url = Uri.parse(
      "https://api.replicate.com/v1/models/ibm-granite/granite-3.3-8b-instruct/predictions",
    );

    final requestBody = {
      "input": {
        "prompt": prompt,
        "system_prompt": "You are a helpful assistant.",
        "temperature": 0.7,
        "top_p": 0.9,
        "top_k": 50,
        "max_tokens": 512,
        "min_tokens": 0,
        "presence_penalty": 0,
        "frequency_penalty": 0,
      },
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_apiToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    print('[Replicate] First response: ${response.body}');

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final output = json['output'];
      final predictionId = json['id'];
      if (output != null) {
        if (output is List) {
          final filtered = output.where(
            (e) => (e?.toString().trim().isNotEmpty ?? false),
          );
          return _cleanOutput(filtered.join(""));
        } else {
          return _cleanOutput(output?.toString() ?? "Tidak ada output.");
        }
      } else {
        // polling jika output masih null
        return _poolResult(predictionId, onPartial: onPartial);
      }
    } else {
      throw Exception("Gagal membuat prediksi: \\${response.body}");
    }
  }

  Future<String> _poolResult(
    String predictionId, {
    Function(String partial)? onPartial,
  }) async {
    final poolUrl = Uri.parse(
      "https://api.replicate.com/v1/predictions/$predictionId",
    );

    int counter = 0;
    String lastPartial = '';
    while (true) {
      final poolRespnse = await http.get(
        poolUrl,
        headers: {'Authorization': 'Bearer $_apiToken'},
      );

      print('[Replicate] Pool #$counter response: ${poolRespnse.body}');
      counter++;

      final json = jsonDecode(poolRespnse.body);
      final status = json['status'];
      final output = json['output'];

      // Call onPartial with latest output if available
      if (onPartial != null && output != null) {
        String partial = '';
        if (output is List) {
          final filtered = output.where(
            (e) => (e?.toString().trim().isNotEmpty ?? false),
          );
          partial = _cleanOutput(filtered.join(""));
        } else {
          partial = _cleanOutput(output?.toString() ?? "");
        }
        if (partial != lastPartial && partial.isNotEmpty) {
          lastPartial = partial;
          onPartial(partial);
        }
      }

      if (status == 'succeeded' && output != null) {
        if (output is List) {
          final filtered = output.where(
            (e) => (e?.toString().trim().isNotEmpty ?? false),
          );
          return _cleanOutput(filtered.join(""));
        } else {
          return _cleanOutput(output?.toString() ?? "Tidak ada output.");
        }
      } else if (status == 'failed') {
        throw Exception("Prediksi gagal diproses.");
      }

      await Future.delayed(Duration(seconds: 1));
    }
  }

  String _cleanOutput(String output) {
    // Implementasi pembersihan output jika diperlukan
    return output;
  }
}
