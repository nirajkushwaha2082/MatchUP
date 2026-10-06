import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:matchup/services/matching_service.dart';


class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final List<_DiscoverProfile> _profiles = const [
    _DiscoverProfile(
      id: 'aarav_1',
      name: 'Aarav',
      age: 25,
      distance: '2 km away',
      matchPercent: 94,
      bio:
          'Coffee lover, weekend explorer and always up for discovering a new place.',
      intention: 'Looking for something meaningful',
      interests: [
        'Travel',
        'Coffee',
        'Photography',
        'Music',
      ],
      photos: [
        'https://i.pravatar.cc/900?img=12',
        'https://i.pravatar.cc/900?img=13',
        'https://i.pravatar.cc/900?img=14',
      ],
      isVerified: true,
    ),
    _DiscoverProfile(
      id: 'maya_1',
      name: 'Maya',
      age: 23,
      distance: '4 km away',
      matchPercent: 89,
      bio:
          'Foodie, music enthusiast and someone who believes good conversations matter.',
      intention: 'Open to new connections',
      interests: [
        'Food',
        'Music',
        'Movies',
        'Dance',
      ],
      photos: [
        'https://i.pravatar.cc/900?img=47',
        'https://i.pravatar.cc/900?img=48',
        'https://i.pravatar.cc/900?img=49',
      ],
      isVerified: true,
    ),
    _DiscoverProfile(
      id: 'riya_1',
      name: 'Riya',
      age: 27,
      distance: '5 km away',
      matchPercent: 86,
      bio:
          'Nature, books and meaningful conversations. Looking for someone genuine.',
      intention: 'Long-term relationship',
      interests: [
        'Nature',
        'Books',
        'Travel',
        'Cooking',
      ],
      photos: [
        'https://i.pravatar.cc/900?img=44',
        'https://i.pravatar.cc/900?img=45',
        'https://i.pravatar.cc/900?img=46',
      ],
      isVerified: false,
    ),
    _DiscoverProfile(
      id: 'kabir_1',
      name: 'Kabir',
      age: 29,
      distance: '6 km away',
      matchPercent: 81,
      bio:
          'Fitness, movies and spontaneous plans. Life is better with the right company.',
      intention: 'Still figuring it out',
      interests: [
        'Fitness',
        'Movies',
        'Sports',
        'Gaming',
      ],
      photos: [
        'https://i.pravatar.cc/900?img=8',
        'https://i.pravatar.cc/900?img=9',
        'https://i.pravatar.cc/900?img=10',
      ],
      isVerified: true,
    ),
  ];

  late final AnimationController _swipeController;

  final MockMatchingService _matchingService =
      MockMatchingService.instance;

  int _currentIndex = 0;
  int _currentPhotoIndex = 0;

  Offset _dragOffset = Offset.zero;
  double _dragRotation = 0;

  bool _isSwiping = false;
  String _swipeType = '';

  String? _pendingMatchId;
  String? _pendingMatchUserId;

  @override
  void initState() {
    super.initState();

    _swipeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    _swipeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) {
          return;
        }

        final matchId = _pendingMatchId;
        final matchedUserId = _pendingMatchUserId;

        setState(() {
          _currentIndex++;
          _currentPhotoIndex = 0;
          _dragOffset = Offset.zero;
          _dragRotation = 0;
          _isSwiping = false;
          _swipeType = '';
          _pendingMatchId = null;
          _pendingMatchUserId = null;
        });

        _swipeController.reset();

        if (matchId != null && matchedUserId != null) {
          context.push(
            '/match'
            '?matchId=${Uri.encodeComponent(matchId)}'
            '&userId=${Uri.encodeComponent(matchedUserId)}',
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isSwiping || _currentIndex >= _profiles.length) {
      return;
    }

    setState(() {
      _dragOffset += details.delta;
      _dragRotation = _dragOffset.dx / 850;
    });
  }

  Future<void> _onPanEnd(DragEndDetails details) async {
    if (_isSwiping || _currentIndex >= _profiles.length) {
      return;
    }

    final dx = _dragOffset.dx;
    final dy = _dragOffset.dy;

    if (dx > 110) {
      await _handleLike();
      return;
    }

    if (dx < -110) {
      await _handlePass();
      return;
    }

    if (dy < -120) {
      await _handleSuperLike();
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _dragOffset = Offset.zero;
      _dragRotation = 0;
    });
  }

  Future<void> _handleLike() async {
    if (_isSwiping || _currentIndex >= _profiles.length) {
      return;
    }

    final profile = _profiles[_currentIndex];

    final result = await _matchingService.likeUser(
      profile.id,
    );

    if (!mounted) {
      return;
    }

    if (result.isMatch && result.matchId != null) {
      _pendingMatchId = result.matchId;
      _pendingMatchUserId = profile.id;
    }

    _triggerSwipe(
      result.isMatch ? 'like' : 'like',
    );
  }

  Future<void> _handleSuperLike() async {
    if (_isSwiping || _currentIndex >= _profiles.length) {
      return;
    }

    final profile = _profiles[_currentIndex];

    final result = await _matchingService.superLikeUser(
      profile.id,
    );

    if (!mounted) {
      return;
    }

    if (result.isMatch && result.matchId != null) {
      _pendingMatchId = result.matchId;
      _pendingMatchUserId = profile.id;
    }

    _triggerSwipe('superlike');
  }

  Future<void> _handlePass() async {
    if (_isSwiping || _currentIndex >= _profiles.length) {
      return;
    }

    final profile = _profiles[_currentIndex];

    await _matchingService.passUser(
      profile.id,
    );

    if (!mounted) {
      return;
    }

    _triggerSwipe('pass');
  }

  void _triggerSwipe(String type) {
    if (_isSwiping || _currentIndex >= _profiles.length) {
      return;
    }

    setState(() {
      _isSwiping = true;
      _swipeType = type;
    });

    _swipeController.forward(from: 0);
  }

  void _showNextPhoto() {
    if (_currentIndex >= _profiles.length) {
      return;
    }

    final profile = _profiles[_currentIndex];

    if (profile.photos.length <= 1) {
      return;
    }

    setState(() {
      _currentPhotoIndex =
          (_currentPhotoIndex + 1) % profile.photos.length;
    });
  }

  void _showFilters() {
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
              24,
              20,
              24,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Discovery Preferences',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Adjust who you want to discover.',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 26),
                _FilterRow(
                  icon: Icons.cake_outlined,
                  title: 'Age range',
                  value: '21 - 32',
                ),
                const SizedBox(height: 14),
                _FilterRow(
                  icon: Icons.location_on_outlined,
                  title: 'Distance',
                  value: 'Within 10 km',
                ),
                const SizedBox(height: 14),
                _FilterRow(
                  icon: Icons.favorite_border_rounded,
                  title: 'Interested in',
                  value: 'Everyone',
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C3FC8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardStack() {
    if (_currentIndex >= _profiles.length) {
      return _buildEmptyState();
    }

    final currentProfile = _profiles[_currentIndex];

    final nextProfile = _currentIndex + 1 < _profiles.length
        ? _profiles[_currentIndex + 1]
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = constraints.maxHeight;

        return Stack(
          alignment: Alignment.center,
          children: [
            if (nextProfile != null)
              Positioned(
                top: 10,
                left: 12,
                right: 12,
                bottom: 10,
                child: Transform.scale(
                  scale: 0.97,
                  child: _ProfileCard(
                    profile: nextProfile,
                    photoIndex: 0,
                    isBehind: true,
                    onPhotoTap: () {},
                  ),
                ),
              ),
            AnimatedBuilder(
              animation: _swipeController,
              builder: (context, child) {
                Offset displayOffset = _dragOffset;
                double displayRotation = _dragRotation;

                if (_isSwiping) {
                  final progress = Curves.easeOut.transform(
                    _swipeController.value,
                  );

                  final Offset targetOffset;

                  if (_swipeType == 'like') {
                    targetOffset = Offset(cardWidth * 1.3, 40);
                  } else if (_swipeType == 'pass') {
                    targetOffset = Offset(
                      -cardWidth * 1.3,
                      40,
                    );
                  } else {
                    targetOffset = Offset(
                      0,
                      -cardHeight * 1.25,
                    );
                  }

                  displayOffset = Offset.lerp(
                    _dragOffset,
                    targetOffset,
                    progress,
                  )!;

                  displayRotation = Tween<double>(
                    begin: _dragRotation,
                    end: _swipeType == 'pass' ? -0.20 : 0.20,
                  ).transform(progress);
                }

                return Transform.translate(
                  offset: displayOffset,
                  child: Transform.rotate(
                    angle: displayRotation,
                    child: _ProfileCard(
                      profile: currentProfile,
                      photoIndex: _currentPhotoIndex,
                      onPhotoTap: _showNextPhoto,
                    ),
                  ),
                );
              },
            ),
            if (_dragOffset.dx.abs() > 35 || _isSwiping)
              _buildSwipeFeedback(),
          ],
        );
      },
    );
  }

  Widget _buildSwipeFeedback() {
    String label = '';
    IconData icon = Icons.favorite_rounded;
    Color color = const Color(0xFFFF4D8D);

    if (_swipeType == 'like' || _dragOffset.dx > 35) {
      label = 'LIKE';
      icon = Icons.favorite_rounded;
      color = const Color(0xFFFF4D8D);
    } else if (_swipeType == 'pass' || _dragOffset.dx < -35) {
      label = 'PASS';
      icon = Icons.close_rounded;
      color = Colors.white70;
    } else if (_swipeType == 'superlike' || _dragOffset.dy < -35) {
      label = 'SUPER LIKE';
      icon = Icons.star_rounded;
      color = const Color(0xFF6C3FC8);
    }

    return Positioned(
      top: 30,
      left: 24,
      child: Transform.rotate(
        angle: label == 'PASS' ? -0.12 : 0.12,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color,
              width: 2,
            ),
            color: const Color(0xFF09070D).withValues(alpha: 0.55),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6C3FC8).withValues(alpha: 0.16),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color(0xFFFF4D8D).withValues(alpha: 0.14),
                  blurRadius: 50,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: const Icon(
              Icons.explore_outlined,
              size: 42,
              color: Color(0xFFFF4D8D),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "You've seen everyone nearby",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Try expanding your distance or age preferences to discover more people.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              height: 1.5,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _showFilters,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Adjust Preferences',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                      _currentPhotoIndex = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C3FC8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Refresh',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
                16,
                20,
                10,
              ),
              child: Row(
                children: [
                  Text(
                    'MatchUP',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white10,
                      ),
                    ),
                    child: IconButton(
                      onPressed: _showFilters,
                      tooltip: 'Filters',
                      icon: const Icon(
                        Icons.tune_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                2,
                20,
                12,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFFFF4D8D),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Kathmandu · Within 10 km',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: Colors.white54,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'For You',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  8,
                ),
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: _buildCardStack(),
                ),
              ),
            ),
            if (_currentIndex < _profiles.length)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ActionButton(
                      icon: Icons.close_rounded,
                      backgroundColor: const Color(0xFF18141E),
                      iconColor: Colors.white70,
                      size: 56,
                      onTap: _handlePass,
                      tooltip: 'Pass',
                    ),
                    const SizedBox(width: 20),
                    _ActionButton(
                      icon: Icons.star_rounded,
                      backgroundColor: const Color(0xFF6C3FC8),
                      iconColor: Colors.white,
                      size: 52,
                      onTap: _handleSuperLike,
                      tooltip: 'Super Like',
                    ),
                    const SizedBox(width: 20),
                    _ActionButton(
                      icon: Icons.favorite_rounded,
                      backgroundColor: const Color(0xFFFF4D8D),
                      iconColor: Colors.white,
                      size: 60,
                      onTap: _handleLike,
                      tooltip: 'Like',
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

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.profile,
    required this.photoIndex,
    required this.onPhotoTap,
    this.isBehind = false,
  });

  final _DiscoverProfile profile;
  final int photoIndex;
  final VoidCallback onPhotoTap;
  final bool isBehind;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            profile.photos[photoIndex],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
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
                child: Center(
                  child: Text(
                    profile.name.substring(0, 1),
                    style: GoogleFonts.poppins(
                      fontSize: 92,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.48,
                  1.0,
                ],
                colors: [
                  Colors.transparent,
                  Color(0x1809070D),
                  Color(0xEA09070D),
                ],
              ),
            ),
          ),
          if (!isBehind)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.42),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: Color(0xFFFF4D8D),
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${profile.matchPercent}% match',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (profile.photos.length > 1)
                    Row(
                      children: List.generate(
                        profile.photos.length,
                        (index) => Container(
                          width: 24,
                          height: 3,
                          margin: const EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: index == photoIndex
                                ? Colors.white
                                : Colors.white30,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (!isBehind)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPhotoTap,
                  splashColor: Colors.white10,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          if (!isBehind)
            Positioned(
              left: 20,
              right: 20,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          '${profile.name}, ${profile.age}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                      if (profile.isVerified) ...[
                        const SizedBox(width: 8),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF60A5FA),
                            size: 21,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        profile.distance,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.bio,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      height: 1.45,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: profile.interests.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 7);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C3FC8)
                                .withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color(0xFFFF4D8D)
                                  .withValues(alpha: 0.22),
                            ),
                          ),
                          child: Text(
                            profile.interests[index],
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.intention,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF4D8D),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.size,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: Border.all(
              color: Colors.white10,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.28),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: size * 0.42,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6C3FC8).withValues(alpha: 0.15),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF4D8D),
              size: 19,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscoverProfile {
  const _DiscoverProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.distance,
    required this.matchPercent,
    required this.bio,
    required this.intention,
    required this.interests,
    required this.photos,
    required this.isVerified,
  });

  final String id;
  final String name;
  final int age;
  final String distance;
  final int matchPercent;
  final String bio;
  final String intention;
  final List<String> interests;
  final List<String> photos;
  final bool isVerified;
}