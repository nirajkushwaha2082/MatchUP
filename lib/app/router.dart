import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/discover/presentation/discover_screen.dart';
import '../features/matches/presentation/likes_screen.dart';
import '../features/matches/presentation/match_screen.dart';
import '../features/matches/presentation/matches_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/profile_setup/presentation/profile_basic_info_screen.dart';
import '../features/profile_setup/presentation/profile_bio_screen.dart';
import '../features/profile_setup/presentation/profile_interests_screen.dart';
import '../features/profile_setup/presentation/profile_photos_screen.dart';
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

    // Main app
    GoRoute(
      path: '/discover',
      builder: (context, state) => const DiscoverScreen(),
    ),
    GoRoute(
      path: '/matches',
      builder: (context, state) => const MatchesScreen(),
    ),
    GoRoute(
      path: '/likes',
      builder: (context, state) => const LikesScreen(),
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

    // Settings
    GoRoute(
      path: '/settings',
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Settings',
      ),
    ),
  ],
);

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}