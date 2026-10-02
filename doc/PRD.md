# Product Requirements Document (PRD)
# MatchUP — Find Your Person

**Document version:** 1.0  
**Product:** MatchUP  
**Platform:** iOS and Android  
**Frontend:** Flutter  
**Backend:** Firebase-first architecture for MVP, with a clean abstraction layer for future migration  
**Design mode:** Dark mode only  
**Primary language:** English UI, with future localization support  
**Team size:** 3 people  
**Product type:** Relationship-focused dating and matchmaking application  
**Tagline:** Find Your Person

---

## 1. Product Overview

MatchUP is a modern, visually polished dating application that helps users discover compatible people, express interest through swipe interactions, form mutual matches, and start meaningful conversations.

The app will use a dark, premium visual identity based on:

- Deep purple: `#6C3FC8`
- Pink: `#FF4D8D`
- White primary text
- Dark black-purple backgrounds
- Glassmorphism cards
- Rounded corners
- Poppins typography
- Smooth transitions and micro-interactions

The initial version will focus on a complete core dating loop:

1. User opens the app.
2. User completes onboarding.
3. User creates a profile.
4. User discovers other profiles.
5. User likes or dislikes profiles.
6. A mutual like creates a match.
7. Users start chatting.
8. Users can report, block, unmatch, or manage privacy settings.

Safety must be considered a core product requirement, not a future enhancement. A dating MVP should include authentication, profiles, matching, messaging, notifications, blocking, reporting, moderation, and privacy controls. [2][3]

---

## 2. Product Goals

### 2.1 Primary goals

- Create a premium-feeling dating experience with simple navigation.
- Help users discover relevant profiles quickly.
- Make profile setup easy and visually engaging.
- Turn mutual interest into immediate conversation.
- Provide a safe and respectful environment.
- Build a maintainable Flutter codebase that three developers can work on independently.
- Create an architecture that can support future subscriptions, advanced recommendations, video calls, and events.

### 2.2 Success metrics

#### Activation metrics

- Percentage of users completing registration.
- Percentage of users completing profile setup.
- Percentage of users uploading at least three photos.
- Percentage of users selecting at least five interests.
- Percentage of users reaching the Home screen.

#### Engagement metrics

- Daily active users.
- Weekly active users.
- Average profiles viewed per user.
- Like-to-dislike ratio.
- Match rate.
- First-message rate.
- Conversation continuation rate.
- Average messages per match.

#### Safety metrics

- Number of reports per 1,000 active users.
- Average moderation response time.
- Number of blocked users.
- Percentage of profiles successfully verified.
- Number of accounts removed for policy violations.
- Abuse, spam, and scam detection rate.

#### Performance metrics

- App startup time.
- Home feed load time.
- Swipe response time.
- Chat message delivery latency.
- Crash-free sessions.
- Push notification delivery rate.

---

## 3. Target Users

### 3.1 Primary users

- Adults aged 18 and above looking for romantic relationships.
- Users who prefer a polished, less complicated dating experience.
- Users who value visual profiles and shared interests.
- Users who want to meet people within a selected distance.
- Users who want basic safety and privacy controls.

### 3.2 User personas

#### Persona A: The intentional dater

- Age: 24–35
- Wants a serious relationship.
- Values profile quality, interests, and meaningful conversation.
- Dislikes fake profiles and low-effort bios.
- Needs filters and clear safety controls.

#### Persona B: The social explorer

- Age: 21–30
- Wants to meet interesting people nearby.
- Enjoys quick discovery and swipe interactions.
- Likes music, food, travel, and social activities.
- Needs a fast and visually engaging experience.

#### Persona C: The privacy-conscious user

- Age: 25–40
- Is careful about location and personal data.
- Wants control over visibility, messages, and profile discovery.
- Needs block, report, unmatch, and account deletion tools.
- Prefers verification indicators and safety education.

---

## 4. Product Principles

### 4.1 Easy to use

The core actions should be understandable without a tutorial:

- Swipe right to like.
- Swipe left to pass.
- Tap the star to super-like.
- Tap the heart button to like.
- Tap the chat action to message a match.

### 4.2 Safety by default

The product must:

- Restrict registration to users aged 18+.
- Provide visible report and block actions.
- Never reveal exact user locations.
- Allow users to control profile visibility.
- Prevent messaging before a mutual match.
- Provide moderation tools.
- Make account deletion accessible.

### 4.3 Quality over quantity

MatchUP should discourage empty profiles by:

- Requiring at least one photo.
- Encouraging multiple photos.
- Encouraging a bio or profile prompt.
- Showing profile completion progress.
- Ranking complete and verified profiles higher.

### 4.4 Premium but approachable

The visual style should feel high-quality without making the app difficult to understand.

### 4.5 Scalable foundation

The codebase should separate:

- UI
- Business logic
- Data sources
- Authentication
- Matching
- Messaging
- Notifications
- Moderation
- Analytics

Flutter’s official architecture guidance recommends separating responsibilities into clear layers and classes to make applications scalable and maintainable. [1]

---

## 5. MVP Scope

### 5.1 Included in MVP

- Splash screen.
- Three-screen onboarding.
- Email/password authentication.
- Optional Google and Apple sign-in.
- Age confirmation.
- Profile setup.
- Six-photo profile grid.
- Name, age, gender, dating preference, bio, and interests.
- Location permission and approximate distance.
- Profile discovery feed.
- Swipe cards.
- Like, dislike, and super-like.
- Mutual match creation.
- Match celebration screen.
- Match list.
- Real-time one-to-one chat.
- Emoji reactions.
- Push notifications.
- Profile editing.
- Settings.
- Block and report.
- Unmatch.
- Account deletion.
- Basic admin moderation workflow.
- Analytics and crash reporting.

### 5.2 Version 1.1

- Photo verification.
- Profile prompts.
- Advanced filters.
- Read receipts.
- Typing indicators.
- Message delivery status.
- Video profile introduction.
- Subscription system.
- Premium likes.
- Boost profile feature.
- More detailed recommendation ranking.
- Better content moderation automation.

### 5.3 Version 2

- Video calling.
- Date planning.
- Events and group activities.
- AI-assisted conversation starters.
- Compatibility quiz.
- Safety check-in.
- Emergency contact flow.
- Travel mode.
- Identity verification.
- Multi-language support.

---

## 6. Information Architecture

### Main navigation

The main navigation will contain four tabs:

1. Discover
2. Matches
3. Likes
4. Profile

#### Discover

- Swipeable profile cards.
- Filter entry point.
- Location and preference summary.
- Empty-state handling.

#### Matches

- List of mutual matches.
- Recent conversation preview.
- Unread message badge.
- Search matches.

#### Likes

- Users who liked the current user.
- This can be partially restricted in the free MVP if monetization is introduced later.
- For the initial MVP, the Likes screen may show only mutual likes.

#### Profile

- User profile preview.
- Edit profile.
- Settings.
- Safety center.
- Help and support.
- Log out.
- Delete account.

---

## 7. Screen Requirements

# 7.1 Splash Screen

### Purpose

Introduce the MatchUP brand while the app initializes authentication, local configuration, and remote settings.

### Design

- Full-screen dark gradient background.
- Gradient direction: top-left to bottom-right.
- Deep purple blending into black.
- MatchUP logo centered vertically and horizontally.
- Tagline below logo: `Find Your Person`.
- Subtle animated glow behind the logo.
- Optional loading indicator near the bottom.

### Functional behavior

1. App opens.
2. App initializes Firebase and local storage.
3. App checks authentication state.
4. App checks whether onboarding has been completed.
5. App routes the user to:
   - Onboarding for a new user.
   - Login for an unauthenticated returning user.
   - Home for an authenticated completed user.
   - Profile setup if registration is incomplete.

### Acceptance criteria

- Splash screen displays for at least 800 milliseconds unless initialization takes longer.
- No blank white screen appears during app launch.
- The app handles initialization failure with a retry state.
- Logo and text remain centered on different device sizes.
- Animation does not block navigation.

---

# 7.2 Onboarding

### Overview

The onboarding experience contains three screens with full-screen aesthetic imagery, short copy, and a clear next action.

### Shared design rules

- Full-screen background image.
- Dark overlay for text readability.
- Large bold heading.
- One short description.
- Page indicator with three dots.
- Bottom-positioned primary button.
- Skip option at the top-right.
- Safe-area-aware layout.
- Text must not be placed over visually busy areas without an overlay.

### Screen 1: Discover

**Heading:**  
`Meet people who match your energy`

**Description:**  
`Discover real profiles based on your interests, preferences, and location.`

**Image direction:**  
A warm, social lifestyle photograph with two or more people in an urban environment.

### Screen 2: Connect

**Heading:**  
`Make every match meaningful`

**Description:**  
`When the interest is mutual, start a conversation and see where it goes.`

**Image direction:**  
A candid conversation or coffee-date image.

### Screen 3: Feel safe

**Heading:**  
`Date with confidence`

**Description:**  
`Your privacy and safety controls are always within reach.`

**Image direction:**  
A confident individual in a calm, positive environment.

### Button behavior

- Screen 1: `Next`
- Screen 2: `Next`
- Screen 3: `Get Started`

### Acceptance criteria

- User can swipe horizontally between onboarding screens.
- User can tap Next.
- User can skip onboarding.
- Onboarding completion is saved locally.
- The user does not see onboarding again after completion unless they reinstall or reset app data.
- The Get Started button opens authentication.
- Screen transitions are smooth and do not feel abrupt.

---

# 7.3 Authentication

### Required screens

- Welcome/Login screen.
- Create account screen.
- Forgot password screen.
- Email verification state.
- Terms and privacy consent state.
- Age confirmation state.

### Login methods

MVP:

- Email and password.

Recommended:

- Sign in with Apple.
- Google Sign-In.

### Registration fields

- Email.
- Password.
- Date of birth or age confirmation.
- Terms acceptance.
- Privacy policy acceptance.

### Business rules

- User must be 18 or older.
- Password must meet minimum security requirements.
- A user cannot continue without accepting terms and privacy policy.
- Email verification may be required before profile discovery.
- Duplicate emails must show a clear error.
- Authentication errors must use human-readable messages.

### Acceptance criteria

- Invalid email shows a validation error.
- Weak password shows requirements.
- Successful registration creates a user account.
- Failed authentication does not crash the app.
- Loading states prevent duplicate form submissions.
- Password reset sends a reset email.
- Logout invalidates the local authenticated session.

---

# 7.4 Profile Setup

### Purpose

Collect enough information to create a trustworthy and useful profile.

### Setup flow

The flow should be step-by-step rather than presenting every field on one screen.

#### Step 1: Add photos

- Six-photo grid.
- One primary photo.
- Add, replace, reorder, and remove actions.
- Drag-and-drop reorder if practical.
- First photo is used as the profile cover.
- Minimum one photo required.
- Recommended completion target: three or more photos.

#### Step 2: Basic information

Fields:

- First name.
- Age or date of birth.
- Gender.
- Dating preference.
- City or approximate location.

The app must not expose exact home location.

#### Step 3: Bio

- Multiline text field.
- Maximum length: 500 characters.
- Character counter.
- Placeholder examples.
- Basic prohibited-content validation.
- Encourage users to describe personality, lifestyle, or what they are looking for.

#### Step 4: Interests

Suggested interest tags:

- Music
- Travel
- Food
- Movies
- Fitness
- Art
- Books
- Gaming
- Photography
- Nature
- Coffee
- Pets
- Cooking
- Sports
- Fashion
- Dance
- Technology
- Volunteering

Rules:

- At least three interests required.
- Five to eight interests recommended.
- Users can search interests.
- Selected tags use pink or purple gradient styling.
- Maximum 15 interests.

#### Step 5: Dating preferences

Fields:

- Preferred age range.
- Preferred distance.
- Gender preference.
- Relationship intention:
  - Long-term relationship.
  - Short-term dating.
  - New connections.
  - Still figuring it out.

#### Step 6: Profile preview

- Show the final profile as other users will see it.
- Allow edit before submission.
- Completion percentage.
- Submit button: `Start Matching`.

### Photo requirements

- Accept JPG, PNG, and HEIC where supported.
- Compress images before upload.
- Generate thumbnail and full-size versions.
- Reject unsupported or corrupted files.
- Provide upload progress.
- Allow retry after failure.
- Run image moderation before publishing when available.

### Acceptance criteria

- User can move forward and backward between steps.
- Data is preserved when navigating backward.
- Required fields cannot be skipped.
- User cannot submit with zero photos.
- Profile setup can resume after app restart.
- Profile is marked complete only after required fields are valid.
- Profile changes are saved securely.

---

# 7.5 Discover / Swipe Screen

### Purpose

Allow users to discover profiles and express interest quickly.

### Layout

- Top app bar:
  - MatchUP logo or wordmark.
  - Filter icon.
  - Optional notification icon.
- Large profile card centered on screen.
- Bottom action area.
- Optional progress indicator.
- Background uses a dark purple gradient.

### Profile card

Show:

- Large profile photo.
- Photo pagination dots.
- Name.
- Age.
- Verification badge if verified.
- Distance, shown approximately.
- Short bio.
- Interest tags.
- Optional relationship intention.
- Tap card to open full profile.

### Distance privacy

Display approximate distance such as:

- `2 km away`
- `Within 5 km`
- `Nearby`

Never expose exact coordinates or precise address.

### Swipe gestures

- Swipe right: Like.
- Swipe left: Dislike/pass.
- Swipe up: Super-like, if enabled.
- Tap heart: Like.
- Tap X: Dislike.
- Tap star: Super-like.
- Tap photo: Next photo.
- Tap profile card: Detailed profile.

### Swipe animation

- Like: card moves right with pink overlay and heart icon.
- Dislike: card moves left with purple or gray overlay and X icon.
- Super-like: card moves upward with star overlay.
- Card rotation should be subtle.
- Animation must support reduced-motion settings.

### Action buttons

#### Dislike

- Circular dark glass button.
- White or muted X icon.
- Accessible label: `Pass`.

#### Like

- Circular pink button.
- White heart icon.
- Accessible label: `Like`.

#### Super-like

- Circular purple button.
- White star icon.
- Accessible label: `Super Like`.

### Feed rules

Do not show:

- The current user.
- Already passed profiles unless a reset feature exists.
- Already matched users.
- Blocked users.
- Reported profiles pending review, if policy requires hiding them.
- Profiles outside the user’s configured preferences.
- Incomplete profiles below the publishing threshold.

### Empty state

When no more profiles are available:

**Heading:**  
`You've seen everyone nearby`

**Description:**  
`Try expanding your distance or age preferences to discover more people.`

Buttons:

- `Adjust Preferences`
- `Refresh`

### Acceptance criteria

- Card responds immediately to swipe.
- Like/dislike is persisted to the backend.
- Duplicate actions are prevented.
- A new card loads without visible flicker.
- Network failures show retry behavior.
- Match creation is handled when two users like each other.
- The user cannot swipe on blocked or deleted profiles.
- Feed pagination or prefetching prevents unnecessary waiting.

---

# 7.6 Match Screen

### Purpose

Celebrate mutual interest and encourage the first message.

### Design

- Full-screen dark purple and pink gradient.
- Confetti animation.
- Large heading: `It's a Match!`
- Two circular or rounded profile photos.
- Optional connecting heart animation.
- User names.
- Primary button: `Send Message`
- Secondary button: `Keep Discovering`

### Functional behavior

- Open immediately after a mutual like.
- Can be dismissed.
- The new match appears in the Matches list.
- Send Message opens the chat screen.
- Keep Discovering returns to the swipe screen.

### Confetti requirements

- Use a lightweight Flutter animation package or custom animation.
- Animation must not block taps.
- Respect reduced-motion accessibility preference.
- Avoid excessive battery usage.

### Acceptance criteria

- Match screen displays only for a newly created match.
- The match record exists before the screen is shown.
- Send Message opens the correct conversation.
- Dismissal does not delete the match.
- The same match does not repeatedly trigger the celebration unless explicitly reopened.

---

# 7.7 Matches Screen

### Layout

- Header: `Matches`
- Optional segmented control:
  - New
  - Messages
- Match cards with:
  - Profile image.
  - Name.
  - Last message preview.
  - Timestamp.
  - Unread badge.
- Empty state for no matches.

### Empty state copy

`Your matches will appear here.`

Secondary text:

`Keep exploring and be open to a new connection.`

### Actions

- Tap match to open chat.
- Long press or overflow menu:
  - Unmatch.
  - Block.
  - Report.
- Swipe-to-delete should not be used for destructive actions without confirmation.

---

# 7.8 Chat Screen

### Purpose

Enable safe, real-time communication between mutual matches.

### Layout

- App bar with:
  - Profile photo.
  - Name.
  - Online status or last active state, if enabled.
  - More menu.
- Scrollable message list.
- Date separators.
- Message composer at bottom.
- Attachment button can be reserved for a later version.
- Emoji reaction interaction.

### Message types

MVP:

- Text.
- Emoji.

Version 1.1:

- Image.
- GIF.
- Voice note.
- Icebreaker prompts.

### Message bubbles

- Current user messages:
  - Pink-to-purple gradient.
  - White text.
  - Right-aligned.
- Other user messages:
  - Dark glass card.
  - White text.
  - Left-aligned.
- Rounded corners with a less-rounded tail side.

### Composer

- Text field.
- Emoji button.
- Send button.
- Maximum message length: 2,000 characters.
- Send button disabled for empty messages.
- Keyboard-aware layout.
- Draft text may be saved locally.

### Emoji reactions

- Long press a message to open reaction picker.
- Suggested reactions:
  - ❤️
  - 😂
  - 😍
  - 😮
  - 👍
  - 🙌
- User can add or remove one reaction per emoji type.
- Reaction changes are synchronized in real time.

### Chat rules

- Chat is available only after a mutual match.
- Blocked users cannot send new messages.
- Unmatched users cannot send new messages.
- Deleted users show as `Deleted account`.
- Report access must remain available from chat.
- Do not expose read receipts unless the user has enabled them.

### Safety tools in chat

More menu:

- Report user.
- Block user.
- Unmatch.
- Delete conversation locally.
- View safety tips.

### Acceptance criteria

- Messages appear in real time.
- Failed messages show retry status.
- Offline messages do not disappear silently.
- Message order is consistent.
- Pagination loads older messages.
- Keyboard does not cover the composer.
- Blocking prevents future messages.
- The chat remains usable on small screens.

---

# 7.9 Profile Screen

### Sections

- Profile preview.
- Edit profile.
- Profile completion score.
- Verification status.
- Preferences.
- Discovery settings.
- Notifications.
- Safety center.
- Privacy policy.
- Terms of service.
- Help and support.
- Log out.
- Delete account.

### Profile editing

Users can edit:

- Photos.
- Name, where policy allows.
- Bio.
- Interests.
- Dating preferences.
- Distance preference.
- Relationship intention.

Age should generally not be freely editable after verification or account creation. If age correction is needed, support or verification flow should be used.

---

# 7.10 Settings and Privacy

### Required controls

- Show/hide profile from discovery.
- Age preference.
- Distance preference.
- Gender preference.
- Notification settings.
- Online status visibility.
- Read receipts, if implemented.
- Location permission guidance.
- Blocked users list.
- Download data request, where legally applicable.
- Delete account.
- Log out.

### Account deletion

The account deletion flow must:

1. Clearly explain what will happen.
2. Ask for confirmation.
3. Optionally ask for a deletion reason.
4. Sign the user out.
5. Remove or anonymize profile data according to the retention policy.
6. Prevent the account from appearing in discovery.
7. Schedule permanent deletion if a grace period is used.

---

## 8. Trust and Safety

Trust and safety are mandatory MVP capabilities. Dating platforms should provide profile verification, reporting, blocking, moderation, secure authentication, encrypted transmission, and privacy controls. [2][3]

### 8.1 Age restriction

- Only users aged 18+ may register.
- Age must be confirmed during registration.
- The backend must enforce age-related access.
- The UI must not rely only on a client-side checkbox.

### 8.2 Reporting

Report access must be available from:

- Profile card.
- Full profile.
- Match list.
- Chat screen.
- User settings where applicable.

Report reasons:

- Fake profile.
- Harassment.
- Hate speech.
- Sexual content.
- Scam or financial request.
- Spam.
- Underage concern.
- Threatening behavior.
- Stolen photos.
- Other.

Report flow:

1. User selects a reason.
2. User can add optional details.
3. User can optionally block the profile.
4. Report is submitted.
5. User receives a confirmation.
6. Report enters the moderation queue.

### 8.3 Blocking

When a user blocks another user:

- Profiles are hidden from both users.
- Pending likes are removed.
- New messages are disabled.
- Existing chat is hidden or marked unavailable.
- The blocked user is not notified directly.
- The block is stored server-side.

### 8.4 Unmatching

When a user unmatches:

- The match is removed from the active match list.
- New messages are disabled.
- Both users may see a generic unavailable state.
- The other user should not receive unnecessary detail.
- Unmatch must require confirmation.

### 8.5 Profile verification

Recommended MVP-ready design:

- Optional selfie verification.
- Verification badge on approved profiles.
- Verification provider should support liveness detection.
- Verification results must not expose raw identity documents to general application users.
- Verification data must follow strict retention rules.

If verification is not implemented in the first release, the product must clearly avoid implying that all profiles are verified.

### 8.6 Content moderation

Moderation layers:

- Client-side basic validation.
- Server-side text filtering.
- Image moderation.
- User report system.
- Admin review queue.
- Account warning, suspension, and ban actions.

Do not automatically ban users solely based on a probabilistic classifier without an appeal or review policy.

### 8.7 Safety education

Create a Safety Center with:

- Never send money.
- Meet in public places.
- Tell a trusted person about first dates.
- Use in-app reporting.
- Do not share sensitive information too early.
- Contact local emergency services in an emergency.

### 8.8 Location privacy

- Store approximate location or geohash, not exact address.
- Show approximate distance.
- Do not expose real-time location.
- Allow users to disable location-based discovery and choose a manual city.
- Do not display distance if it may create a privacy risk.

---

## 9. Matching and Recommendation Logic

### 9.1 MVP matching logic

The first recommendation engine can use deterministic filtering plus a ranking score.

#### Hard filters

A profile is eligible only if:

- User is active.
- User is 18+.
- User is within the selected distance.
- User matches gender preference rules.
- User falls within age range.
- User has not been blocked.
- User has not already been passed or matched.
- User is not suspended.
- User has a publishable profile.

#### Ranking factors

Suggested ranking score:

- Distance compatibility.
- Shared interests.
- Profile completeness.
- Activity recency.
- Preference compatibility.
- Verification status.
- Diversity and freshness rules.

Do not rank only by attractiveness or engagement. The ranking system should include diversity and avoid showing the same small group repeatedly.

### 9.2 Match creation

A match is created when:

- User A likes User B.
- User B has already liked User A.
- Neither user has blocked the other.
- Both profiles are active.

The backend must create the match atomically to avoid duplicate matches.

### 9.3 Super-like

MVP option:

- Allow one free super-like per day.
- Prevent abuse through server-side rate limits.
- Show the recipient that the interaction is a super-like.
- Keep super-like implementation behind a feature flag if monetization is not ready.

---

## 10. Backend and Technical Architecture

### 10.1 Recommended MVP stack

#### Mobile

- Flutter.
- Dart.
- Material 3 as a base, heavily customized.
- Riverpod or Bloc for state management.
- GoRouter for navigation.
- Firebase Crashlytics.
- Firebase Cloud Messaging.
- Firebase Analytics.

#### Backend

Option A: Firebase-first MVP

- Firebase Authentication.
- Cloud Firestore.
- Cloud Functions.
- Firebase Storage.
- Firebase Cloud Messaging.
- Firebase App Check.
- Firebase Security Rules.

Option B: Custom backend for scale

- Node.js with NestJS or Fastify.
- PostgreSQL.
- Redis.
- Object storage such as S3-compatible storage.
- WebSocket or managed chat infrastructure.
- FCM and APNs for notifications.

For a three-person team, Firebase-first is recommended for the MVP because it reduces infrastructure work. However, repositories and service interfaces should avoid tightly coupling every feature directly to Firebase.

### 10.2 Architectural layers

```text
Presentation Layer
├── Screens
├── Widgets
├── Controllers
└── UI State

Domain Layer
├── Entities
├── Use Cases
├── Business Rules
└── Repository Interfaces

Data Layer
├── Repository Implementations
├── Remote Data Sources
├── Local Data Sources
├── DTOs
└── Mappers

Core Layer
├── Routing
├── Theme
├── Error Handling
├── Logging
├── Network
├── Permissions
└── Constants
```

### 10.3 Feature-first folder structure

```text
lib/
├── app/
│   ├── app.dart
│   ├── router.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   ├── app_typography.dart
│   │   └── app_spacing.dart
│   └── config/
│       ├── environment.dart
│       └── feature_flags.dart
│
├── core/
│   ├── errors/
│   ├── network/
│   ├── analytics/
│   ├── permissions/
│   ├── storage/
│   ├── widgets/
│   ├── extensions/
│   └── utils/
│
├── features/
│   ├── splash/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── onboarding/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── profile_setup/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── discovery/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── matches/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── chat/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── safety/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

### 10.4 Coding standards

- Use strict analysis rules.
- Avoid business logic inside widgets.
- Use immutable state where practical.
- Use typed models rather than dynamic maps in domain code.
- Add unit tests for use cases.
- Add widget tests for critical flows.
- Add integration tests for registration, profile setup, matching, and chat.
- Use pull requests for all main-branch changes.
- Require at least one code review.
- Use conventional commit messages.
- Keep feature branches small and focused.

---

## 11. Data Model

### 11.1 User

```text
User
├── id
├── email
├── authProvider
├── dateOfBirth
├── age
├── accountStatus
├── onboardingCompleted
├── profileCompleted
├── createdAt
├── updatedAt
├── lastActiveAt
└── deletedAt
```

### 11.2 Profile

```text
Profile
├── userId
├── firstName
├── bio
├── gender
├── datingPreferences
├── relationshipIntent
├── city
├── approximateLocation
├── ageRange
├── distancePreference
├── photos
├── interests
├── isVisible
├── isVerified
├── profileCompletionScore
├── createdAt
└── updatedAt
```

### 11.3 Photo

```text
Photo
├── id
├── userId
├── storagePath
├── thumbnailUrl
├── fullUrl
├── sortOrder
├── isPrimary
├── moderationStatus
├── createdAt
└── deletedAt
```

### 11.4 Like

```text
Like
├── id
├── senderId
├── receiverId
├── type
├── createdAt
└── status
```

`type` values:

- like
- superLike
- pass

### 11.5 Match

```text
Match
├── id
├── userIds
├── createdAt
├── lastActivityAt
├── status
└── unmatchedAt
```

### 11.6 Message

```text
Message
├── id
├── matchId
├── senderId
├── type
├── text
├── createdAt
├── editedAt
├── deletedAt
├── deliveryStatus
└── reactions
```

### 11.7 Report

```text
Report
├── id
├── reporterId
├── reportedUserId
├── matchId
├── reason
├── details
├── status
├── assignedTo
├── createdAt
├── reviewedAt
└── resolution
```

### 11.8 Block

```text
Block
├── id
├── blockerId
├── blockedUserId
└── createdAt
```

---

## 12. Firestore Collection Design

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

### Security rule principles

- Users can read and update only their own private data.
- Public profile fields must be explicitly whitelisted.
- Users can read a match only if they belong to it.
- Users can read messages only if they belong to the match.
- Users cannot create a match directly from the client.
- Likes must be validated by server logic.
- Reports are write-only for regular users.
- Admin data is inaccessible to normal users.
- Block rules must be enforced server-side.
- Deleted or suspended profiles must not appear in discovery.

---

## 13. API and Service Contracts

Even when Firebase is used, define service interfaces.

```dart
abstract class AuthRepository {
  Future<UserEntity> signInWithEmail(
    String email,
    String password,
  );

  Future<UserEntity> registerWithEmail(
    String email,
    String password,
  );

  Future<void> signOut();

  Future<void> sendPasswordReset(String email);

  Stream<UserEntity?> authStateChanges();
}
```

```dart
abstract class DiscoveryRepository {
  Future<List<ProfileEntity>> getRecommendations({
    required int limit,
    String? cursor,
  });

  Future<void> likeProfile(String profileId);

  Future<void> passProfile(String profileId);

  Future<void> superLikeProfile(String profileId);
}
```

```dart
abstract class ChatRepository {
  Stream<List<MessageEntity>> watchMessages(String matchId);

  Future<MessageEntity> sendMessage({
    required String matchId,
    required String text,
  });

  Future<void> addReaction({
    required String matchId,
    required String messageId,
    required String emoji,
  });
}
```

---

## 14. UI and Design System

### 14.1 Colors

```text
Primary Purple: #6C3FC8
Primary Pink: #FF4D8D
Background Black: #08060D
Background Purple: #140D24
Surface Dark: #1B1528
Surface Glass: rgba(255, 255, 255, 0.08)
White: #FFFFFF
Secondary Text: #B9B1C8
Muted Text: #817891
Success: #38D39F
Warning: #FFB547
Error: #FF5C70
```

### 14.2 Gradients

Primary gradient:

```text
#6C3FC8 → #FF4D8D
```

Background gradient:

```text
#241040 → #08060D
```

Success or match glow:

```text
#FF4D8D → #8A5CF6
```

### 14.3 Typography

Font family:

```text
Poppins
```

Suggested styles:

- Display large: 32px, weight 700.
- Heading large: 26px, weight 700.
- Heading medium: 20px, weight 600.
- Body large: 16px, weight 400.
- Body medium: 14px, weight 400.
- Caption: 12px, weight 500.
- Button: 15px, weight 600.

### 14.4 Spacing

Use an 8-point spacing system:

```text
4px
8px
12px
16px
20px
24px
32px
40px
48px
```

### 14.5 Component rules

- Primary buttons use a gradient fill.
- Secondary buttons use a glass or outlined style.
- Cards use 20–28px corner radius.
- Input fields use 14–18px corner radius.
- Bottom sheets use 28px top corners.
- Touch targets should be at least 44x44 logical pixels.
- Use consistent icon stroke widths.
- Use accessible labels for every icon-only button.

### 14.6 Glassmorphism

Glass components should include:

- Semi-transparent surface.
- Background blur.
- Thin low-opacity border.
- Subtle shadow.
- High-contrast text.
- Fallback styling for devices where blur is expensive.

Do not use glassmorphism on every element. Reserve it for cards, navigation surfaces, overlays, and action controls.

---

## 15. Animation Requirements

### Required animations

- Splash logo fade and scale.
- Onboarding page transitions.
- Button press feedback.
- Profile card swipe.
- Match confetti.
- Match heart pulse.
- Chat message appearance.
- Like and super-like feedback.
- Bottom-sheet entrance.
- Loading shimmer.

### Animation principles

- Keep transitions between 180ms and 400ms for common actions.
- Use spring animations for swipe cards.
- Do not delay core actions only for visual effects.
- Respect reduced-motion accessibility settings.
- Avoid continuous animations that drain battery.
- Keep confetti short and dismissible.

---

## 16. Notifications

### Push notification events

- New match.
- New message.
- Super-like received.
- Profile verification completed.
- Report status update where appropriate.
- Account or safety warning.
- Re-engagement notification, subject to consent.

### Notification privacy

Do not expose full message content on lock screens by default.

Example:

`You have a new message on MatchUP.`

Allow users to customize notifications.

---

## 17. Analytics Events

Use event names that are consistent and privacy-conscious.

### Authentication events

```text
app_opened
onboarding_started
onboarding_completed
login_started
login_completed
registration_started
registration_completed
password_reset_requested
```

### Profile events

```text
profile_setup_started
photo_uploaded
profile_completed
interest_selected
profile_updated
```

### Discovery events

```text
discovery_loaded
profile_opened
profile_liked
profile_passed
profile_super_liked
filter_updated
feed_empty
```

### Match events

```text
match_created
match_screen_viewed
send_message_tapped
keep_discovering_tapped
unmatched
```

### Chat events

```text
chat_opened
message_started
message_sent
message_failed
reaction_added
user_reported_from_chat
```

### Safety events

```text
block_created
report_submitted
safety_center_opened
account_deletion_started
account_deleted
```

Do not log message contents, passwords, raw location, or sensitive report details in analytics.

---

## 18. Team Division

The team has three members. Work should be divided by product ownership while maintaining shared standards.

# Team Member 1: Flutter UI and Design System Lead

### Responsibilities

- App theme and color system.
- Poppins typography.
- Reusable buttons, cards, inputs, bottom sheets, dialogs.
- Splash screen.
- Onboarding.
- Authentication UI.
- Profile setup UI.
- Profile preview.
- Responsive layout.
- Animations and visual polish.
- Accessibility labels and touch targets.

### Primary folders

```text
lib/app/theme/
lib/core/widgets/
lib/features/splash/presentation/
lib/features/onboarding/
lib/features/auth/presentation/
lib/features/profile_setup/presentation/
```

### Deliverables

- Figma-to-Flutter design implementation.
- Reusable UI components.
- Theme tokens.
- Splash and onboarding.
- Authentication screens.
- Profile setup screens.
- UI widget tests.
- Responsive device validation.

# Team Member 2: Backend, Authentication, and Data Lead

### Responsibilities

- Firebase project configuration.
- Authentication.
- Firestore collections.
- Storage uploads.
- Security rules.
- Profile APIs and repositories.
- Like/pass/super-like logic.
- Match creation.
- Notification backend.
- Cloud Functions.
- Environment configuration.
- Data validation and error handling.

### Primary folders

```text
lib/features/auth/data/
lib/features/profile_setup/data/
lib/features/discovery/data/
lib/features/matches/data/
lib/core/network/
```

### Deliverables

- Authentication flow.
- User and profile data models.
- Photo upload pipeline.
- Match creation logic.
- Recommendation query.
- Security rules.
- Cloud Functions.
- Backend tests.
- Seed data for development.

# Team Member 3: Discovery, Chat, Safety, and QA Lead

### Responsibilities

- Swipe interaction logic.
- Recommendation feed UI integration.
- Match screen.
- Matches list.
- Real-time chat.
- Emoji reactions.
- Push notification integration.
- Report and block flows.
- Safety Center.
- Automated tests.
- Regression testing.
- Release checklist.

### Primary folders

```text
lib/features/discovery/presentation/
lib/features/matches/presentation/
lib/features/chat/
lib/features/safety/
lib/features/settings/
test/
integration_test/
```

### Deliverables

- Swipe card behavior.
- Match celebration flow.
- Match list.
- Chat UI and real-time state.
- Report, block, and unmatch.
- Notification handling.
- End-to-end tests.
- QA test plan.
- Release candidate validation.

---

## 19. Shared Team Responsibilities

All three team members must participate in:

- Architecture decisions.
- Code reviews.
- Sprint planning.
- Definition of Done.
- Security review.
- Usability testing.
- Release testing.
- Documentation.
- Bug triage.

No feature should be considered complete if it works only on one device size or only with a successful network connection.

---

## 20. Suggested Development Timeline

### Phase 0: Planning and setup

Duration: 3–5 days

Tasks:

- Confirm product scope.
- Create Figma design file.
- Create Flutter repository.
- Configure environments.
- Set up Firebase projects:
  - Development.
  - Staging.
  - Production.
- Define Firestore schema.
- Define branch strategy.
- Create issue tracker.
- Add linting and formatting.
- Create theme tokens.
- Define analytics events.

### Phase 1: Foundation and authentication

Duration: 1–2 weeks

Tasks:

- Flutter project structure.
- Theme and navigation.
- Splash.
- Onboarding.
- Login.
- Registration.
- Password reset.
- Terms and privacy consent.
- Age validation.
- Authentication state management.

### Phase 2: Profile setup

Duration: 1–2 weeks

Tasks:

- Photo upload.
- Photo reorder.
- Profile fields.
- Bio.
- Interests.
- Dating preferences.
- Profile preview.
- Profile completion.
- Data persistence.

### Phase 3: Discovery and matching

Duration: 2 weeks

Tasks:

- Recommendation query.
- Swipe cards.
- Like.
- Dislike.
- Super-like.
- Mutual matching.
- Match celebration.
- Empty state.
- Filters.

### Phase 4: Chat and notifications

Duration: 2 weeks

Tasks:

- Matches list.
- Real-time messages.
- Message pagination.
- Emoji reactions.
- Push notifications.
- Unread counts.
- Chat safety menu.

### Phase 5: Safety, settings, and moderation

Duration: 1–2 weeks

Tasks:

- Block.
- Report.
- Unmatch.
- Safety Center.
- Profile visibility.
- Notification settings.
- Account deletion.
- Basic moderation dashboard or admin workflow.

### Phase 6: QA and release

Duration: 1–2 weeks

Tasks:

- Integration testing.
- Device testing.
- Performance testing.
- Security rules review.
- App Store metadata.
- Privacy policy.
- Terms of service.
- Crash monitoring.
- Production configuration.
- Beta release.
- Bug fixing.

---

## 21. Scrum Workflow

### Sprint length

Use one-week or two-week sprints.

### Sprint ceremonies

- Sprint planning.
- Daily stand-up.
- Mid-sprint design or technical review.
- Demo.
- Retrospective.

### Task format

Every task should include:

- User story.
- Acceptance criteria.
- Design reference.
- API or data dependency.
- Test requirements.
- Definition of Done.

### Example user story

```text
As a registered user,
I want to swipe right on a profile,
so that I can express interest and potentially create a match.
```

### Acceptance criteria

```text
Given a visible profile card,
When I swipe right,
Then a like is saved for my account and the next profile appears.

Given the other user has already liked me,
When I swipe right,
Then a match is created and the Match screen opens.

Given the request fails,
When the network returns an error,
Then the card remains available and I can retry.
```

---

## 22. Definition of Done

A feature is Done only when:

- UI matches the approved design.
- Loading, success, empty, and error states exist.
- Responsive layout works on supported devices.
- Business rules are enforced server-side.
- Analytics events are added where required.
- Accessibility labels exist.
- Unit tests exist for important logic.
- Widget or integration tests exist for critical flows.
- No critical lint errors remain.
- At least one teammate has reviewed the pull request.
- The feature works with slow and interrupted network conditions.
- Security implications have been reviewed.
- Documentation is updated.

---

## 23. Error and Empty States

### Common error messages

#### Network error

`We couldn't connect. Check your internet connection and try again.`

#### Profile load error

`We couldn't load this profile right now.`

Button: `Try Again`

#### Photo upload error

`This photo couldn't be uploaded. Please try again.`

#### Chat send error

`Message not sent.`

Button: `Retry`

#### Authentication error

`The email or password doesn't look right.`

### Empty states

- No discovery profiles.
- No matches.
- No messages.
- No notifications.
- No blocked users.
- No uploaded photos.

Every empty state should include:

- Simple illustration or subtle visual.
- Clear explanation.
- Useful action where applicable.

---

## 24. Performance Requirements

- App should remain responsive at 60 FPS on supported devices.
- First meaningful UI should appear quickly after launch.
- Discovery cards should be prefetched.
- Images should use thumbnails before full-size images.
- Images should be cached locally.
- Chat should paginate older messages.
- Do not load all profiles at once.
- Avoid unnecessary rebuilds in swipe and chat widgets.
- Use lazy lists for matches and messages.
- Compress photos before upload.
- Avoid large bundled assets.
- Monitor memory during image-heavy screens.

---

## 25. Accessibility Requirements

- Support dynamic text sizing where possible.
- Maintain sufficient color contrast.
- Provide semantic labels for icons.
- Do not use color as the only indicator.
- Make swipe actions available through buttons.
- Support reduced motion.
- Ensure keyboard navigation where platform-relevant.
- Do not make important safety actions gesture-only.
- Ensure dialogs can be dismissed with accessible controls.
- Test with VoiceOver and TalkBack.

---

## 26. Security and Privacy Requirements

- Use HTTPS/TLS for all network traffic.
- Never store passwords in the app.
- Use secure token storage.
- Protect Firebase resources with security rules.
- Do not trust client-provided user IDs for authorization.
- Validate all likes, matches, messages, and reports server-side.
- Restrict admin access with role-based permissions.
- Encrypt sensitive data at rest where supported.
- Keep private data separate from public profile data.
- Avoid collecting unnecessary personal information.
- Define retention rules for:
  - Deleted accounts.
  - Messages.
  - Reports.
  - Moderation evidence.
  - Location data.
  - Analytics.
- Provide a clear privacy policy.
- Provide account deletion.
- Provide support for applicable privacy rights.

Privacy design should separate personally identifiable data from behavioral events where possible, limit access to messages and private media, and keep audit logs for moderation actions. [3]

---

## 27. Admin and Moderation Requirements

A lightweight admin panel is strongly recommended for production.

### Admin features

- Admin authentication.
- Role-based access.
- Report queue.
- Search users.
- View profile and moderation history.
- Review reported photos and text.
- Warn user.
- Suspend user.
- Ban user.
- Restore user.
- Mark report resolved.
- Add internal notes.
- View audit trail.
- Manage banned words.
- View basic product analytics.

### Admin roles

- Moderator.
- Senior moderator.
- Support agent.
- Administrator.

### Admin security

- Separate admin application or protected route.
- Multi-factor authentication.
- Audit log for every action.
- No unrestricted access to private messages unless required for an approved safety investigation.
- Use least-privilege permissions.

---

## 28. Monetization Plan

Monetization should not damage trust or the basic user experience.

### Possible paid features

- Unlimited likes.
- Additional super-likes.
- Profile boost.
- See who liked you.
- Advanced filters.
- Travel mode.
- Read receipts.
- Incognito discovery.
- Premium profile themes.

### MVP monetization recommendation

Do not launch with too many paid features. Start with:

- Free core matching and chat.
- Optional premium subscription behind feature flags.
- One or two non-essential premium features.
- No paywall before the user understands the product.

Payment implementation must follow Apple App Store and Google Play billing rules for digital in-app purchases.

---

## 29. Future Features

### AI-assisted features

- Icebreaker suggestions.
- Profile writing suggestions.
- Conversation tone assistance.
- Scam-risk signals.
- Photo quality suggestions.

AI must never make final safety decisions without a human-review policy where consequences are significant.

### Video dating

- One-to-one video calls.
- Mutual consent before calling.
- Report and block during calls.
- Call safety reminders.
- No automatic recording.

### Date planning

- Suggested public venues.
- Share date plan with trusted contact.
- Safety check-in.
- Optional arrival confirmation.

### Events

- Group events.
- Interest-based meetups.
- RSVP.
- Event chat.
- Event moderation.

---

## 30. Release Checklist

### Product

- [ ] Splash works.
- [ ] Onboarding works.
- [ ] Registration works.
- [ ] Age restriction works.
- [ ] Profile setup works.
- [ ] Photo upload works.
- [ ] Discovery works.
- [ ] Like, pass, and super-like work.
- [ ] Match creation works.
- [ ] Chat works.
- [ ] Notifications work.
- [ ] Report works.
- [ ] Block works.
- [ ] Unmatch works.
- [ ] Account deletion works.

### Technical

- [ ] Production Firebase project configured.
- [ ] Security rules reviewed.
- [ ] Crash reporting enabled.
- [ ] Analytics enabled without sensitive data.
- [ ] API keys protected.
- [ ] Environment variables separated.
- [ ] App signing configured.
- [ ] Push certificates configured.
- [ ] Database indexes created.
- [ ] Backup and recovery plan documented.

### Design

- [ ] Dark mode is consistent.
- [ ] Poppins is correctly bundled.
- [ ] Purple and pink brand colors are consistent.
- [ ] Loading states exist.
- [ ] Empty states exist.
- [ ] Error states exist.
- [ ] Animations are smooth.
- [ ] Reduced motion is supported.
- [ ] Small screen layouts are tested.

### Legal and safety

- [ ] Terms of service published.
- [ ] Privacy policy published.
- [ ] Community guidelines published.
- [ ] Safety Center published.
- [ ] Account deletion documented.
- [ ] Reporting process operational.
- [ ] Moderation owner assigned.
- [ ] Support email configured.

---

## 31. Final MVP Acceptance Criteria

MatchUP is ready for MVP beta when a new user can:

1. Open the app and see the branded splash screen.
2. Complete onboarding.
3. Register or log in.
4. Confirm they are 18 or older.
5. Add at least one profile photo.
6. Add their name, bio, interests, and preferences.
7. View relevant profiles.
8. Like, pass, or super-like a profile.
9. Receive a match after mutual interest.
10. Open the Match screen.
11. Start a conversation.
12. Send and receive messages.
13. Add emoji reactions.
14. Report or block another user.
15. Unmatch safely.
16. Edit their profile.
17. Hide their profile.
18. Log out.
19. Delete their account.
20. Recover gracefully from network errors.

The product should feel fast, polished, private, and emotionally positive. MatchUP is not only a swipe interface; it is a complete discovery, matching, conversation, and safety system built around the promise: **Find Your Person**.
