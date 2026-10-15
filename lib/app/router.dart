import 'package:go_router/go_router.dart';

import 'main_navigation_shell.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/discover/presentation/discover_screen.dart';
import '../features/discover/presentation/profile_detail_screen.dart';
import '../features/matches/presentation/likes_screen.dart';
import '../features/matches/presentation/match_screen.dart';
import '../features/matches/presentation/matches_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/profile_setup/presentation/profile_basic_info_screen.dart';
import '../features/profile_setup/presentation/profile_bio_screen.dart';
import '../features/profile_setup/presentation/profile_interests_screen.dart';
import '../features/profile_setup/presentation/profile_photos_screen.dart';
import '../features/profile_setup/presentation/dating_preferences_screen.dart';
import '../features/profile_setup/presentation/profile_preview_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/safety/presentation/safety_center_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Onboarding
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Authentication
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    // Profile setup
    GoRoute(
      path: '/profile-setup',
      builder: (context, state) => const ProfilePhotosScreen(),
    ),
    GoRoute(
      path: '/profile-basic-info',
      builder: (context, state) => const ProfileBasicInfoScreen(),
    ),
    GoRoute(
      path: '/profile-bio',
      builder: (context, state) => const ProfileBioScreen(),
    ),
    GoRoute(
      path: '/profile-interests',
      builder: (context, state) => const ProfileInterestsScreen(),
    ),

    GoRoute(
      path: '/profile-dating-preferences',
      builder: (context, state) => const DatingPreferencesScreen(),
    ),
    GoRoute(
      path: '/profile-preview',
      builder: (context, state) => const ProfilePreviewScreen(),
    ),
    GoRoute(
      path: '/profile-details',
      builder: (context, state) => ProfileDetailScreen(
        profile: state.uri.queryParameters,
      ),
    ),

    // Authenticated areas keep their branch state while switching tabs.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainNavigationShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/discover',
            builder: (context, state) => const DiscoverScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/matches',
            builder: (context, state) => const MatchesScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/likes',
            builder: (context, state) => const LikesScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
      ],
    ),

    // Match result
    GoRoute(
      path: '/match',
      builder: (context, state) => const MatchScreen(),
    ),

    // Chat
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatScreen(),
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/safety',
      builder: (context, state) => SafetyCenterScreen(
        profileName: state.uri.queryParameters['profile'],
      ),
    ),
  ],
);
