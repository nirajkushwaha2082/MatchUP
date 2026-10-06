import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final List<_LikedProfile> _likes = [
    const _LikedProfile(
      id: 'aarav_1',
      name: 'Aarav',
      age: 25,
      distance: '2 km away',
      matchPercent: 94,
      isNew: true,
      isVerified: true,
    ),
    const _LikedProfile(
      id: 'maya_1',
      name: 'Maya',
      age: 23,
      distance: '4 km away',
      matchPercent: 89,
      isNew: true,
      isVerified: true,
    ),
    const _LikedProfile(
      id: 'riya_1',
      name: 'Riya',
      age: 27,
      distance: '5 km away',
      matchPercent: 86,
      isNew: false,
      isVerified: false,
    ),
    const _LikedProfile(
      id: 'kabir_1',
      name: 'Kabir',
      age: 29,
      distance: '6 km away',
      matchPercent: 81,
      isNew: false,
      isVerified: true,
    ),
  ];

  void _likeBack(_LikedProfile profile) {
    setState(() {
      _likes.removeWhere(
        (item) => item.id == profile.id,
      );
    });

    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'You liked ${profile.name} back ❤️',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF1A1620),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _pass(_LikedProfile profile) {
    setState(() {
      _likes.removeWhere(
        (item) => item.id == profile.id,
      );
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${profile.name} removed.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF1A1620),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showProfile(_LikedProfile profile) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF15111B),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 22),

                _ProfileAvatar(
                  name: profile.name,
                  large: true,
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${profile.name}, ${profile.age}',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    if (profile.isVerified) ...[
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.verified_rounded,
                        color: Color(0xFF60A5FA),
                        size: 20,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  '${profile.distance} · ${profile.matchPercent}% match',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _pass(profile);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 19,
                        ),
                        label: Text(
                          'Pass',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: BorderSide(
                            color: Colors.white.withValues(
                              alpha: 0.12,
                            ),
                          ),
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _likeBack(profile);
                        },
                        icon: const Icon(
                          Icons.favorite_rounded,
                          size: 19,
                        ),
                        label: Text(
                          'Like Back',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4D8D),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                8,
              ),
              child: Row(
                children: [
                  Text(
                    'Likes',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4D8D)
                          .withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFFF4D8D)
                            .withValues(alpha: 0.20),
                      ),
                    ),
                    child: Text(
                      '${_likes.length} likes',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF4D8D),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                4,
                20,
                18,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'People who are interested in you',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),

            Expanded(
              child: _likes.isEmpty
                  ? const _EmptyLikesState()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        24,
                      ),
                      itemCount: _likes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, index) {
                        final profile = _likes[index];

                        return _LikeCard(
                          profile: profile,
                          onTap: () {
                            _showProfile(profile);
                          },
                          onLike: () {
                            _likeBack(profile);
                          },
                          onPass: () {
                            _pass(profile);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeCard extends StatelessWidget {
  const _LikeCard({
    required this.profile,
    required this.onTap,
    required this.onLike,
    required this.onPass,
  });

  final _LikedProfile profile;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onPass;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.045),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: profile.isNew
                ? const Color(0xFFFF4D8D)
                    .withValues(alpha: 0.30)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ProfileAvatar(
                    name: profile.name,
                  ),

                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xD809070D),
                        ],
                      ),
                    ),
                  ),

                  if (profile.isNew)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4D8D),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.poppins(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${profile.name}, ${profile.age}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (profile.isVerified)
                          const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF60A5FA),
                            size: 17,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                10,
                12,
                12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white38,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.distance,
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          color: Colors.white54,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${profile.matchPercent}% match',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF4D8D),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: _SmallActionButton(
                          icon: Icons.close_rounded,
                          onTap: onPass,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: _SmallActionButton(
                          icon: Icons.favorite_rounded,
                          label: 'Like',
                          filled: true,
                          onTap: onLike,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  const _SmallActionButton({
    required this.icon,
    required this.onTap,
    this.label,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: filled
              ? const Color(0xFFFF4D8D)
              : Colors.white.withValues(alpha: 0.04),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
            side: BorderSide(
              color: filled
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: 0.10),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 17,
            ),
            if (label != null) ...[
              const SizedBox(width: 5),
              Text(
                label!,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.name,
    this.large = false,
  });

  final String name;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C3FC8),
            Color(0xFFFF4D8D),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        name.substring(0, 1),
        style: GoogleFonts.poppins(
          fontSize: large ? 42 : 58,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _EmptyLikesState extends StatelessWidget {
  const _EmptyLikesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF4D8D)
                    .withValues(alpha: 0.12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C3FC8)
                        .withValues(alpha: 0.18),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFFF4D8D),
                size: 40,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'No likes yet',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Keep discovering people and your likes will appear here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                height: 1.5,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikedProfile {
  const _LikedProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.distance,
    required this.matchPercent,
    required this.isNew,
    required this.isVerified,
  });

  final String id;
  final String name;
  final int age;
  final String distance;
  final int matchPercent;
  final bool isNew;
  final bool isVerified;
}