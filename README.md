# IBM AI Chat

IBM AI Chat is a simple Flutter chat application that leverages IBM Granite-3.3-8b-instruct (via Replicate API) to provide real-time, streaming AI chat experiences. The app features Material Design, persistent chat history, and a user-friendly interface.

Download the application [here](https://github.com/Ariyalex/IBM-AI-chat/releases/tag/V1.0)

## Features

- Real-time AI chat with streaming/polling updates
- Material 2 UI with left/right chat bubble alignment
- Copy-to-clipboard for AI responses
- Persistent chat history using Hive
- Secure API key management with `.env`

## Technology Stack

- **Flutter** — UI toolkit for building natively compiled applications
- **Dart** — Programming language for Flutter
- **GetX** — State management and dependency injection
- **Hive** — Lightweight & fast key-value database for local storage
- **Replicate API** — For accessing IBM Granite-3.3-8b-instruct AI model
- **flutter_dotenv** — For environment variable management
- **flutter_svg** — For SVG asset rendering


## Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/ibm_ai_chat.git
   cd ibm_ai_chat
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Set up environment variables:**
   - Copy `.env.example` to `.env` and add your Replicate API key:
     ```env
     REPLICATE_API_TOKEN=your_replicate_api_token
     ```
4. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/` — Main Flutter source code
  - `src/controllers/` — GetX controllers (chat logic)
  - `src/models/` — Data models (chat message)
  - `src/screens/` — UI screens
  - `src/services/` — API and backend services
  - `src/widgets/` — Reusable widgets (chat box, text field)
- `assets/` — SVG and other static assets
- `android/`, `ios/` — Platform-specific code

## API & AI Model

This app uses the [Replicate API](https://replicate.com/) to access IBM Granite-3.3-8b-instruct models for chat completion. All requests are securely handled and streamed for real-time UI updates.


## License

MIT License. See [LICENSE](LICENSE) for details.
