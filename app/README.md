# Installation Guide

## Prerequisites

### Operating System
- **Windows**: Windows 10 or later
- **macOS**: macOS 10.15 (Catalina) or later (required for iOS development)
- **Linux**: Ubuntu 18.04 or later (for Android development)

### Required Software

1. **Flutter SDK** (version 3.6.1 or later)
   - Download from: https://docs.flutter.dev/get-started/install
   - Verify installation:
     ```bash
     flutter --version
     ```
   - Ensure Flutter SDK is in your system PATH

2. **Dart SDK** (included with Flutter SDK)
   - Verify installation:
     ```bash
     dart --version
     ```

3. **Android Development Tools** (for Android builds)
   - **Android Studio**: Latest stable version
   - **Android SDK**: API level 26 (minimum), API level 35 (target)
   - **Java Development Kit (JDK)**: Version 8 or later
   - **Gradle**: Version 8.3.0 (managed by project)
   - **Kotlin**: Version 2.1.0 (managed by project)
   - Set `ANDROID_HOME` environment variable:
     ```bash
     # Windows (PowerShell)
     $env:ANDROID_HOME = "C:\Users\<YourUsername>\AppData\Local\Android\Sdk"
     
     # macOS/Linux
     export ANDROID_HOME=$HOME/Library/Android/sdk
     ```

4. **iOS Development Tools** (for iOS builds, macOS only)
   - **Xcode**: Version 14.0 or later
   - **CocoaPods**: Install via:
     ```bash
     sudo gem install cocoapods
     ```
   - **Xcode Command Line Tools**:
     ```bash
     xcode-select --install
     ```

5. **Git**: Latest version
   - Verify installation:
     ```bash
     git --version
     ```

6. **Firebase Account**: Required for push notifications and cloud messaging
   - Create a Firebase project at: https://console.firebase.google.com/

7. **Zego Account**: Required for video calling functionality
   - Sign up at: https://www.zegocloud.com/
   - Obtain App ID and App Sign from Zego Console

## Repository Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd telemedicene
   ```

2. Navigate to the Flutter project directory:
   ```bash
   cd tele
   ```

## Environment Setup

1. Verify Flutter installation and check for required dependencies:
   ```bash
   flutter doctor
   ```
   Resolve any issues reported by `flutter doctor` before proceeding.

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the `tele` directory:
   ```bash
   # Windows (PowerShell)
   New-Item -Path .env -ItemType File
   
   # macOS/Linux
   touch .env
   ```

4. Configure environment variables in `.env`:
   ```env
   # Backend API Base URL
   BASE_URL=https://your-api-server.com
   
   # Zego Video Calling Configuration
   APPID=your_zego_app_id
   APPSING=your_zego_app_sign
   
   # Firebase Configuration
   FIREBASE_API_KEY=your_firebase_api_key
   FIREBASE_APP_ID=your_firebase_app_id
   FIREBASE_MESSAGING_SENDER_ID=your_firebase_messaging_sender_id
   FIREBASE_PROJECT_ID=your_firebase_project_id
   
   # Payment Gateway Configuration (if applicable)
   MERCHANTUID=your_merchant_uid
   APIUSERID=your_api_user_id
   APIKEY=your_api_key
   ```

   **Note**: Replace placeholder values with actual credentials from your Firebase and Zego accounts.

## Configuration

### Android Configuration

1. Obtain `google-services.json` from Firebase Console:
   - Go to Firebase Console → Project Settings → Your Android App
   - Download `google-services.json`

2. Place `google-services.json` in `tele/android/app/` directory:
   ```bash
   # Copy the downloaded file to:
   tele/android/app/google-services.json
   ```

3. Verify Android build configuration:
   - Ensure `tele/android/app/build.gradle` includes the Google Services plugin
   - Minimum SDK version: 26
   - Target SDK version: 35
   - Compile SDK version: 35

### iOS Configuration

1. Obtain `GoogleService-Info.plist` from Firebase Console:
   - Go to Firebase Console → Project Settings → Your iOS App
   - Download `GoogleService-Info.plist`

2. Place `GoogleService-Info.plist` in `tele/ios/Runner/` directory:
   ```bash
   # Copy the downloaded file to:
   tele/ios/Runner/GoogleService-Info.plist
   ```

3. Install iOS dependencies:
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. Configure iOS capabilities in Xcode:
   - Open `tele/ios/Runner.xcworkspace` in Xcode
   - Enable Push Notifications capability
   - Enable Background Modes → Remote notifications

## Database Setup

This project uses `SharedPreferences` for local data storage. No database initialization or migration is required. Data persistence is handled automatically by the Flutter application.

## Running the Project

### Android

1. Connect an Android device or start an Android emulator:
   ```bash
   # List available devices
   flutter devices
   
   # Start an emulator (if using Android Studio)
   # Or connect a physical device via USB with USB debugging enabled
   ```

2. Run the application:
   ```bash
   flutter run
   ```

3. For release build:
   ```bash
   flutter build apk --release
   ```

### iOS (macOS only)

1. Open the project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Select a target device or simulator in Xcode

3. Run the application:
   ```bash
   flutter run
   ```

   Or build and run from Xcode (⌘R)

4. For release build:
   ```bash
   flutter build ios --release
   ```

## Verifying Installation

1. **Check Flutter setup**:
   ```bash
   flutter doctor -v
   ```
   Ensure all required components show as installed.

2. **Verify dependencies**:
   ```bash
   flutter pub get
   ```
   Should complete without errors.

3. **Check environment variables**:
   - Ensure `.env` file exists in `tele` directory
   - Verify all required variables are set (no empty values)

4. **Test Android build**:
   ```bash
   flutter build apk --debug
   ```
   Should complete successfully.

5. **Test iOS build** (macOS only):
   ```bash
   flutter build ios --debug --no-codesign
   ```
   Should complete successfully.

6. **Run the application**:
   ```bash
   flutter run
   ```
   The application should launch on the connected device/emulator.

7. **Verify runtime behavior**:
   - Application launches without crashes
   - Login screen appears
   - No console errors related to missing configuration

## Troubleshooting

### Common Issues

1. **Flutter doctor shows issues**:
   - Follow the specific instructions provided by `flutter doctor`
   - Install missing components (Android SDK, Xcode, etc.)

2. **`.env` file not found**:
   - Ensure `.env` file is in `tele` directory (not root directory)
   - Verify file is not in `.gitignore` exclusion list

3. **Firebase initialization errors**:
   - Verify `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in correct location
   - Check environment variables match Firebase project settings

4. **Zego video calling not working**:
   - Verify `APPID` and `APPSING` in `.env` are correct
   - Ensure Zego account is active and credentials are valid

5. **Build failures**:
   - Run `flutter clean` and then `flutter pub get`
   - For Android: `cd android && ./gradlew clean && cd ..`
   - For iOS: `cd ios && pod deintegrate && pod install && cd ..`

6. **iOS pod install fails**:
   - Update CocoaPods: `sudo gem install cocoapods`
   - Clear pod cache: `pod cache clean --all`
   - Delete `Podfile.lock` and `Pods` directory, then run `pod install` again

