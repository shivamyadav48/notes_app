# DriveNotes - A Google Drive Connected Notes App

DriveNotes is a Flutter app that allows users to sign in with Google OAuth 2.0 and manage text notes stored in Google Drive. Notes are synced in a folder named "DriveNotes". The app supports creating, reading, editing, and deleting notes with secure authentication, and follows a modular architecture with Riverpod for state management.

## Features

- Google OAuth 2.0 authentication
- Google Drive integration to manage notes
- Create, view, edit, and delete notes stored in Drive
- "DriveNotes" folder auto-creation
- Light/Dark theme support
- State management with Riverpod v2
- Secure token storage with flutter_secure_storage
- Responsive UI using Material 3

## Tech Stack

- Flutter
- Riverpod v2 (State Management)
- Dio (Networking)
- flutter_secure_storage (Token Storage)
- googleapis and googleapis_auth (Google Drive API)
- json_serializable (Model Generation)
- go_router (Routing)

## Setup & Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/drivenotes.git
   cd drivenotes
2. Install dependencies:

https://github.com/user-attachments/assets/47458303-f2e6-4541-b0ce-f9ffba933a4f


flutter pub get

3. Set up Google API credentials:

Enable Google Drive API and create OAuth credentials in the Google Cloud Console.

Configure the google-services.json or provide the necessary clientId for OAuth.

4. Run the app:
flutter run
