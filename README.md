# MatchUP

> Find Your Person

MatchUP is a modern, dark-mode dating application built with Flutter. It helps users discover compatible profiles, express interest, create mutual matches, and start meaningful conversations in a visually polished and safety-focused environment.

The app uses a premium visual style with deep purple and pink gradients, glassmorphism cards, rounded UI components, smooth animations, and Poppins typography.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screens](#screens)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Team Structure](#team-structure)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Environment Configuration](#environment-configuration)
- [Firebase Setup](#firebase-setup)
- [Running the Project](#running-the-project)
- [Testing](#testing)
- [Code Standards](#code-standards)
- [Git Workflow](#git-workflow)
- [Database Structure](#database-structure)
- [Security and Privacy](#security-and-privacy)
- [Design System](#design-system)
- [Development Roadmap](#development-roadmap)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

MatchUP is designed for adults who want to discover new people based on location, interests, preferences, and relationship intentions.

The primary user journey is:

```text
Open App
   ↓
Complete Onboarding
   ↓
Create Account
   ↓
Set Up Profile
   ↓
Discover Profiles
   ↓
Like or Pass
   ↓
Create Mutual Match
   ↓
Start Chatting
```

MatchUP focuses on:

- Simple onboarding.
- High-quality user profiles.
- Smooth swipe interactions.
- Mutual matching.
- Real-time messaging.
- Privacy controls.
- Blocking and reporting.
- Scalable Flutter architecture.

---

## Features

### Authentication

- Email and password registration.
- Email and password login.
- Password reset.
- Optional Google Sign-In.
- Optional Apple Sign-In.
- Email verification.
- Age confirmation.
- Terms and privacy policy consent.
- Secure logout.

### Onboarding

- Three-screen onboarding flow.
- Full-screen aesthetic images.
- Dark overlays for readability.
- Smooth page transitions.
- Skip functionality.
- Persistent onboarding completion state.

### Profile Setup

- Upload up to six photos.
- Set a primary profile photo.
- Reorder and remove photos.
- Add name and age.
- Add bio.
- Select interests.
- Choose dating preferences.
- Select relationship intention.
- Set preferred distance.
- Preview profile before publishing.
- Profile completion indicator.

### Discovery

- Tinder-style swipe cards.
- Swipe right to like.
- Swipe left to pass.
- Swipe up to super-like.
- Like, pass, and super-like buttons.
- Profile photo carousel.
- Name, age, and approximate distance.
- Bio and interests.
- Verification badge support.
- Empty state when no profiles remain.
- Discovery filters.

### Matching

- Mutual like creates a match.
- Match celebration screen.
- Confetti animation.
- Both profile photos displayed.
- Send Message action.
- Continue Discovering action.
- Match list.
- Unmatch functionality.

### Chat

- Real-time one-to-one chat.
- Text messages.
- Message timestamps.
- Message delivery states.
- Emoji reactions.
- Unread message count.
- Push notifications.
- Retry failed messages.
- Report and block actions inside chat.

### Safety

- 18+ registration requirement.
- Report user.
- Block user.
- Unmatch user.
- Approximate location only.
- Profile visibility control.
- Safety Center.
- Account deletion.
- Basic moderation workflow.
- Admin action audit logs.

### Settings

- Edit profile.
- Edit interests.
- Edit preferences.
- Notification settings.
- Privacy controls.
- Blocked users.
- Safety Center.
- Help and support.
- Terms of service.
- Privacy policy.
- Logout.
- Delete account.

---

## Screens

The application includes the following primary screens:

```text
Splash Screen
Onboarding Screen 1
Onboarding Screen 2
Onboarding Screen 3
Login Screen
Create Account Screen
Forgot Password Screen
Age Confirmation Screen
Profile Setup - Photos
Profile Setup - Basic Information
Profile Setup - Bio
Profile Setup - Interests
Profile Setup - Preferences
Profile Preview Screen
Discover / Swipe Screen
Detailed Profile Screen
Match Celebration Screen
Matches Screen
Chat Screen
Profile Screen
Edit Profile Screen
Settings Screen
Safety Center Screen
Report User Screen
Blocked Users Screen
Account Deletion Screen
```

---

## Technology Stack

### Frontend

- Flutter
- Dart
- Material 3
- Riverpod or Bloc
- GoRouter
- Poppins font
- Cached network images
- Custom animations

### Backend

- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase Cloud Functions
- Firebase Cloud Messaging
- Firebase Crashlytics
- Firebase Analytics
- Firebase App Check

### Development Tools

- Android Studio or Visual Studio Code
- Xcode for iOS development
- Figma
- Git and GitHub
- Firebase Console
- Flutter DevTools
- GitHub Actions, optional

---

## Architecture

MatchUP follows a feature-first, layered architecture.

```text
Presentation Layer
    ↓
Domain Layer
    ↓
Data Layer
    ↓
Firebase and External Services
```

### Presentation Layer

Responsible for:

- Screens.
- Widgets.
- Controllers.
- User input.
- Loading, success, empty, and error states.
- UI state management.

### Domain Layer

Responsible for:

- Entities.
- Use cases.
- Business rules.
- Repository interfaces.
- Validation logic.

### Data Layer

Responsible for:

- Repository implementations.
- Firebase data sources.
- DTOs.
- Data mapping.
- Storage and caching.
- Remote data handling.

### Core Layer

Responsible for:

- Theme.
- Routing.
- Error handling.
- Logging.
- Analytics.
- Permissions.
- Shared widgets.
- Utilities.
- Constants.

### Architecture Principles

- Keep business logic outside widgets.
- Use typed models.
- Keep Firebase implementation behind repository interfaces.
- Avoid direct database calls from UI components.
- Validate important business rules on the server.
- Use immutable state wherever practical.
- Write tests for important use cases.
- Keep features independently maintainable.

---

## Project Structure

```text
matchup/
├── android/
├── ios/
├── web/
├── assets/
│   ├── images/
│   ├── icons/
│   ├── animations/
│   └── fonts/
│       └── Poppins/
│
├── lib/
│   ├── main.dart
│   │
│   ├── app/
│   │   ├── app.dart
│   │   ├── router.dart
│   │   ├── theme/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_theme.dart
│   │   │   ├── app_typography.dart
│   │   │   └── app_spacing.dart
│   │   └── config/
│   │       ├── environment.dart
│   │       └── feature_flags.dart
│   │
│   ├── core/
│   │   ├── analytics/
│   │   ├── errors/
│   │   ├── extensions/
│   │   ├── network/
│   │   ├── permissions/
│   │   ├── storage/
│   │   ├── utils/
│   │   └── widgets/
│   │
│   └── features/
│       ├── splash/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── onboarding/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── auth/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── profile_setup/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── discovery/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── matches/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── chat/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── safety/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       └── settings/
│           ├── data/
│           ├── domain/
│           └── presentation/
│
├── test/
│   ├── core/
│   ├── features/
│   └── fixtures/
│
├── integration_test/
│   ├── auth_flow_test.dart
│   ├── profile_setup_test.dart
│   ├── matching_flow_test.dart
│   └── chat_flow_test.dart
│
├── functions/
│   ├── src/
│   ├── package.json
│   └── tsconfig.json
│
├── firestore.rules
├── firestore.indexes.json
├── storage.rules
├── firebase.json
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
└── CHANGELOG.md
```

---

## Team Structure

MatchUP is designed for a three-person development team.

### Developer 1: Flutter UI and Design System

Responsibilities:

- Theme and color system.
- Typography.
- Reusable widgets.
- Splash screen.
- Onboarding.
- Authentication UI.
- Profile setup UI.
- Profile preview.
- Responsive layouts.
- Animations.
- Accessibility implementation.

Primary ownership:

```text
lib/app/theme/
lib/core/widgets/
lib/features/splash/
lib/features/onboarding/
lib/features/auth/presentation/
lib/features/profile_setup/presentation/
```

### Developer 2: Backend and Data

Responsibilities:

- Firebase project setup.
- Authentication services.
- Firestore schema.
- Storage configuration.
- Security rules.
- User and profile repositories.
- Photo upload system.
- Like and match logic.
- Cloud Functions.
- Push notification backend.
- Environment configuration.

Primary ownership:

```text
lib/features/auth/data/
lib/features/profile_setup/data/
lib/features/discovery/data/
lib/features/matches/data/
lib/core/network/
functions/
firestore.rules
storage.rules
```

### Developer 3: Discovery, Chat, Safety, and QA

Responsibilities:

- Swipe interaction.
- Discovery feed.
- Match celebration.
- Matches list.
- Real-time chat.
- Emoji reactions.
- Push notification handling.
- Report and block flows.
- Safety Center.
- Integration testing.
- Regression testing.
- Release validation.

Primary ownership:

```text
lib/features/discovery/presentation/
lib/features/matches/presentation/
lib/features/chat/
lib/features/safety/
lib/features/settings/
test/
integration_test/
```

### Shared Responsibilities

All team members are responsible for:

- Code reviews.
- Architecture decisions.
- Testing.
- Documentation.
- Bug fixing.
- Security reviews.
- Sprint planning.
- Pull request quality.
- Release readiness.

---

## Requirements

### Software Requirements

Install the following:

- Flutter SDK.
- Dart SDK included with Flutter.
- Android Studio or Visual Studio Code.
- Android SDK.
- Xcode for iOS development.
- CocoaPods for iOS dependencies.
- Node.js for Firebase Functions.
- Firebase CLI.
- Git.
- A Firebase project.
- A GitHub account.

### Recommended Versions

Use the versions defined by the project configuration.

```bash
flutter --version
dart --version
node --version
firebase --version
```

Do not update major Flutter or Dart versions during active feature development without a team discussion and a dedicated migration branch.

---

## Getting Started

### 1. Clone the repository

```bash
git clone [https://github.com/your-organization/matchup.git](https://github.com/your-organization/matchup.git)
cd matchup
```

Replace the repository URL with the actual project URL.

### 2. Install Flutter dependencies

```bash
flutter pub get
```

### 3. Install Firebase Functions dependencies

```bash
cd functions
npm install
cd ..
```

### 4. Verify Flutter installation

```bash
flutter doctor
```

Resolve all required issues before starting development.

### 5. Check available devices

```bash
flutter devices
```

### 6. Run static analysis

```bash
flutter analyze
```

### 7. Run tests

```bash
flutter test
```

---

## Environment Configuration

Do not commit production secrets to the repository.

Create environment files according to the project setup:

```text
.env.development
.env.staging
.env.production
```

Example configuration:

```env
APP_ENV=development
FIREBASE_PROJECT_ID=matchup-development
API_BASE_URL=[https://example-development-api.com](https://example-development-api.com)
ENABLE_ANALYTICS=false
ENABLE_CRASHLYTICS=false
ENABLE_DEBUG_LOGS=true
```

Production configuration example:

```env
APP_ENV=production
FIREBASE_PROJECT_ID=matchup-production
API_BASE_URL=[https://example-production-api.com](https://example-production-api.com)
ENABLE_ANALYTICS=true
ENABLE_CRASHLYTICS=true
ENABLE_DEBUG_LOGS=false
```

Add environment files to `.gitignore`:

```gitignore
.env*
!.env.example
```

Create a safe example file:

```env
APP_ENV=development
FIREBASE_PROJECT_ID=
API_BASE_URL=
ENABLE_ANALYTICS=false
ENABLE_CRASHLYTICS=false
ENABLE_DEBUG_LOGS=true
```

---

## Firebase Setup

### 1. Create Firebase projects

Create separate Firebase projects for:

```text
matchup-development
matchup-staging
matchup-production
```

Do not use the production Firebase project for local development.

### 2. Install Firebase CLI

```bash
npm install -g firebase-tools
```

### 3. Login

```bash
firebase login
```

### 4. Configure FlutterFire

Install FlutterFire CLI if required:

```bash
dart pub global activate flutterfire_cli
```

Configure the application:

```bash
flutterfire configure
```

Select the correct Firebase project for the current environment.

### 5. Enable Firebase services

Enable:

- Authentication.
- Email/password provider.
- Google provider, if implemented.
- Apple provider, if implemented.
- Cloud Firestore.
- Firebase Storage.
- Cloud Functions.
- Firebase Cloud Messaging.
- Firebase Crashlytics.
- Firebase Analytics.
- Firebase App Check.

### 6. Configure Firebase rules

Deploy Firestore rules:

```bash
firebase deploy --only firestore:rules
```

Deploy Storage rules:

```bash
firebase deploy --only storage
```

Deploy indexes:

```bash
firebase deploy --only firestore:indexes
```

Deploy Cloud Functions:

```bash
firebase deploy --only functions
```

### 7. Local Firebase Emulator Suite

For local development, use Firebase emulators where possible:

```bash
firebase emulators:start
```

Recommended emulators:

- Authentication.
- Firestore.
- Storage.
- Functions.

Do not test destructive operations against production data.

---

## Running the Project

### Development mode

```bash
flutter run --dart-define=APP_ENV=development
```

### Run on a specific device

```bash
flutter devices
flutter run -d DEVICE_ID
```

### Run in release mode

```bash
flutter run --release --dart-define=APP_ENV=production
```

Do not use production configuration for regular development.

### Build Android APK

```bash
flutter build apk --release
```

### Build Android App Bundle

```bash
flutter build appbundle --release
```

### Build iOS

```bash
flutter build ios --release
```

For App Store distribution, use Xcode to configure signing, provisioning, and archive submission.

---

## App Configuration

### Application identifiers

Use separate identifiers for each environment if possible:

```text
Development:
com.example.matchup.dev

Staging:
com.example.matchup.staging

Production:
com.example.matchup
```

### Supported platforms

Initial target:

- Android.
- iOS.

Future target:

- Web.
- Desktop, if required.

### Minimum platform versions

Set minimum supported versions according to the selected Flutter SDK and required Firebase packages. Confirm these values before release testing.

---

## Database Structure

The main Firestore collections are:

```text
users/{userId}
profiles/{userId}
profiles/{userId}/photos/{photoId}
likes/{likeId}
matches/{matchId}
matches/{matchId}/messages/{messageId}
reports/{reportId}
blocks/{blockId}
notifications/{notificationId}
adminActions/{actionId}
```

### User document

```json
{
  "id": "user_id",
  "email": "user@example.com",
  "authProvider": "password",
  "accountStatus": "active",
  "onboardingCompleted": true,
  "profileCompleted": true,
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "lastActiveAt": "timestamp"
}
```

### Profile document

```json
{
  "userId": "user_id",
  "firstName": "Alex",
  "bio": "Coffee, travel, music, and good conversations.",
  "age": 28,
  "gender": "prefer_not_to_say",
  "interests": [
    "Music",
    "Travel",
    "Food"
  ],
  "relationshipIntent": "long_term",
  "city": "Kathmandu",
  "approximateLocation": {
    "geohash": "example_geohash"
  },
  "distancePreference": 25,
  "isVisible": true,
  "isVerified": false,
  "profileCompletionScore": 85,
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Match document

```json
{
  "id": "match_id",
  "userIds": [
    "user_a",
    "user_b"
  ],
  "status": "active",
  "createdAt": "timestamp",
  "lastActivityAt": "timestamp"
}
```

### Message document

```json
{
  "id": "message_id",
  "matchId": "match_id",
  "senderId": "user_id",
  "type": "text",
  "text": "Hey! How is your day going?",
  "createdAt": "timestamp",
  "deliveryStatus": "sent",
  "reactions": {
    "heart": [
      "other_user_id"
    ]
  }
}
```

---

## Security and Privacy

MatchUP must follow secure-by-default practices.

### Authentication

- Never store passwords directly.
- Use Firebase Authentication.
- Store tokens securely.
- Require authentication for private routes.
- Sign users out after account deletion.
- Prevent duplicate authentication requests.

### Database security

- Users can read and update only permitted data.
- Users can access messages only in their matches.
- Users cannot create matches directly from the client.
- Reports are not publicly readable.
- Admin data is restricted by role.
- Blocked users must be filtered on the backend.
- Suspended users must not appear in discovery.

### Location privacy

- Store approximate location or geohash.
- Do not expose exact coordinates.
- Display approximate distance only.
- Do not display home address.
- Allow users to disable location-based discovery.

### User safety

Users must be able to:

- Report profiles.
- Report messages.
- Block users.
- Unmatch users.
- Hide their profile.
- Delete their account.
- Access safety guidance.

### Sensitive data

Do not log or send the following to analytics:

- Passwords.
- Full message content.
- Exact location.
- Government identification documents.
- Report details.
- Private media.
- Authentication tokens.

---

## Design System

### Brand Colors

```dart
const primaryPurple = Color(0xFF6C3FC8);
const primaryPink = Color(0xFFFF4D8D);
const backgroundBlack = Color(0xFF08060D);
const backgroundPurple = Color(0xFF140D24);
const surfaceDark = Color(0xFF1B1528);
const white = Color(0xFFFFFFFF);
const secondaryText = Color(0xFFB9B1C8);
const mutedText = Color(0xFF817891);
const success = Color(0xFF38D39F);
const warning = Color(0xFFFFB547);
const error = Color(0xFFFF5C70);
```

### Gradients

Primary gradient:

```text
#6C3FC8 → #FF4D8D
```

Background gradient:

```text
#241040 → #08060D
```

### Typography

Font:

```text
Poppins
```

Suggested styles:

```text
Display Large: 32px / Bold
Heading Large: 26px / Bold
Heading Medium: 20px / SemiBold
Body Large: 16px / Regular
Body Medium: 14px / Regular
Caption: 12px / Medium
Button: 15px / SemiBold
```

### Component Guidelines

- Use rounded cards.
- Use 20–28px card radius.
- Use glass surfaces selectively.
- Use gradient primary buttons.
- Keep text contrast high.
- Provide visible pressed states.
- Use a minimum 44x44 logical pixel touch target.
- Avoid gesture-only interactions for important features.
- Provide accessible labels for icon buttons.

---

## Development Roadmap

### Phase 1: Foundation

- Flutter project setup.
- Theme system.
- Navigation.
- Splash screen.
- Onboarding.
- Firebase configuration.

### Phase 2: Authentication

- Login.
- Registration.
- Password reset.
- Age confirmation.
- Terms and privacy consent.
- Authentication state handling.

### Phase 3: Profile Setup

- Photo upload.
- Profile fields.
- Bio.
- Interests.
- Preferences.
- Profile preview.
- Profile completion.

### Phase 4: Discovery

- Recommendation feed.
- Swipe card.
- Like.
- Pass.
- Super-like.
- Filters.
- Empty state.

### Phase 5: Matching

- Mutual match logic.
- Match celebration.
- Matches list.
- Unmatch.

### Phase 6: Chat

- Real-time messages.
- Message pagination.
- Emoji reactions.
- Notifications.
- Failed message retry.

### Phase 7: Safety

- Report.
- Block.
- Safety Center.
- Profile visibility.
- Account deletion.
- Admin moderation workflow.

### Phase 8: QA and Release

- Unit tests.
- Widget tests.
- Integration tests.
- Security review.
- Performance review.
- Crash monitoring.
- Beta testing.
- Store submission.

---

## Testing

### Run all tests

```bash
flutter test
```

### Run a specific test file

```bash
flutter test test/features/auth/auth_repository_test.dart
```

### Run with coverage

```bash
flutter test --coverage
```

### Run integration tests

```bash
flutter test integration_test
```

### Analyze code

```bash
flutter analyze
```

### Format code

```bash
dart format lib test
```

### Test categories

#### Unit tests

Test:

- Validation.
- Use cases.
- Match logic.
- Profile completion calculation.
- Date and age rules.
- Filtering.
- Repository behavior.

#### Widget tests

Test:

- Login form.
- Profile setup steps.
- Interest selection.
- Swipe card actions.
- Match screen.
- Chat composer.
- Report dialog.

#### Integration tests

Test:

- New user registration.
- Onboarding completion.
- Profile creation.
- Like and match flow.
- Message sending.
- Block and report flow.
- Account deletion flow.

#### Manual testing

Test on:

- Small Android phone.
- Large Android phone.
- Small iPhone.
- Large iPhone.
- Slow network.
- Offline mode.
- Dark mode.
- Different text sizes.
- Screen readers.
- Low-memory devices.

---

## Code Standards

### Formatting

Run:

```bash
dart format .
```

### Static analysis

Run:

```bash
flutter analyze
```

### Naming

Use:

```text
PascalCase for classes
camelCase for variables and methods
snake_case for file names
SCREAMING_SNAKE_CASE only for constants when appropriate
```

Examples:

```dart
class ProfileCard extends StatelessWidget {}

final selectedInterests = <String>[];

Future<void> loadRecommendations() async {}
```

### Widget guidelines

- Keep widgets focused.
- Extract large sections into separate widgets.
- Avoid deeply nested widget trees where possible.
- Do not place database calls directly inside build methods.
- Avoid unnecessary rebuilds.
- Use const constructors where possible.

### State guidelines

- Keep state close to the feature that owns it.
- Use immutable state objects.
- Represent loading, success, empty, and error states explicitly.
- Do not silently swallow exceptions.
- Show user-friendly errors.

### Pull request requirements

Every pull request must include:

- Summary of changes.
- Related issue.
- Screenshots or screen recording for UI work.
- Testing steps.
- Known limitations.
- Notes about database or security changes.

---

## Git Workflow

### Branch naming

```text
feature/onboarding-flow
feature/profile-photo-upload
feature/swipe-discovery
feature/realtime-chat
fix/login-validation
fix/message-retry
chore/update-dependencies
```

### Commit message format

Use conventional commits:

```text
feat: add profile setup flow
fix: handle failed chat messages
refactor: separate discovery repository
test: add match creation tests
docs: update Firebase setup
chore: update Flutter dependencies
```

### Recommended workflow

```bash
git checkout main
git pull origin main
git checkout -b feature/your-feature
```

After development:

```bash
dart format .
flutter analyze
flutter test
git add .
git commit -m "feat: implement profile setup"
git push origin feature/your-feature
```

Create a pull request and wait for review before merging.

### Protected branches

The following branches should be protected:

```text
main
staging
```

Recommended rules:

- Require pull requests.
- Require at least one approval.
- Require successful CI.
- Prevent force pushes.
- Prevent direct commits to production branches.

---

## Troubleshooting

### Flutter dependencies are failing

Run:

```bash
flutter clean
flutter pub get
```

If the issue continues:

```bash
rm -rf .dart_tool
flutter pub get
```

### iOS dependencies are failing

Run:

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

### Firebase is not initialized

Check:

- `google-services.json` exists for Android.
- `GoogleService-Info.plist` exists for iOS.
- FlutterFire configuration is correct.
- The selected Firebase project is correct.
- Firebase initialization runs before the app starts.

### Images are not uploading

Check:

- Storage rules.
- User authentication state.
- File size.
- File format.
- Storage bucket configuration.
- Network connectivity.
- Upload permissions.

### Messages are not appearing

Check:

- User belongs to the match.
- Firestore rules.
- Match ID.
- Listener subscription.
- Firestore indexes.
- Network connection.
- Message document structure.

### Push notifications are not working

Check:

- FCM configuration.
- APNs setup for iOS.
- Notification permissions.
- Device token.
- Background capabilities.
- Firebase Functions deployment.
- Notification payload.
- App state.

### App crashes on startup

Run:

```bash
flutter logs
```

Also check:

- Firebase initialization.
- Missing environment variables.
- Invalid asset paths.
- Incorrect route configuration.
- Native platform configuration.
- Crashlytics logs.

---

## Release Checklist

### Product

- [ ] Splash screen works.
- [ ] Onboarding works.
- [ ] Login works.
- [ ] Registration works.
- [ ] Age restriction works.
- [ ] Profile setup works.
- [ ] Photo upload works.
- [ ] Discovery works.
- [ ] Like works.
- [ ] Pass works.
- [ ] Super-like works.
- [ ] Match creation works.
- [ ] Match celebration works.
- [ ] Chat works.
- [ ] Emoji reactions work.
- [ ] Notifications work.
- [ ] Report works.
- [ ] Block works.
- [ ] Unmatch works.
- [ ] Account deletion works.

### Technical

- [ ] Production Firebase project is configured.
- [ ] Firestore rules are reviewed.
- [ ] Storage rules are reviewed.
- [ ] Admin access is protected.
- [ ] Crashlytics is enabled.
- [ ] Analytics does not contain sensitive data.
- [ ] Production secrets are protected.
- [ ] Release signing is configured.
- [ ] Push notifications are configured.
- [ ] Database indexes are deployed.
- [ ] Backups and recovery procedures are documented.

### Design

- [ ] Dark mode is consistent.
- [ ] Poppins is applied correctly.
- [ ] Purple and pink branding is consistent.
- [ ] Loading states exist.
- [ ] Empty states exist.
- [ ] Error states exist.
- [ ] Animations are smooth.
- [ ] Reduced motion is supported.
- [ ] Small screens are tested.
- [ ] Accessibility labels are present.

### Legal and Safety

- [ ] Terms of service are published.
- [ ] Privacy policy is published.
- [ ] Community guidelines are published.
- [ ] Safety Center is available.
- [ ] Report process is operational.
- [ ] Moderation owner is assigned.
- [ ] Support contact is configured.
- [ ] Account deletion is available.

---

## Definition of Done

A feature is considered complete only when:

- The UI matches the approved design.
- The feature works on Android and iOS.
- Loading, empty, success, and error states are implemented.
- Important business rules are validated server-side.
- Accessibility labels are included.
- Unit tests are added where necessary.
- Widget or integration tests are added for critical flows.
- Static analysis passes.
- A teammate has reviewed the pull request.
- The feature works on a slow network.
- Security implications have been reviewed.
- Documentation is updated.

---

## Contributing

1. Read the project README.
2. Create a feature branch.
3. Keep changes focused.
4. Follow the architecture and naming standards.
5. Add tests for new logic.
6. Run formatting, analysis, and tests.
7. Open a pull request.
8. Address review comments.
9. Merge only after approval and CI success.

---

## License

This project is proprietary software.

Copyright © 2026 MatchUP.

Unauthorized copying, distribution, modification, or commercial use is prohibited unless explicitly permitted by the project owner.

---

## Product Motto

```text
Find Your Person.
Match with intention.
Connect with confidence.
```
