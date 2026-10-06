import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final AnimationController _heartController;
  late final AnimationController _confettiController;

  final List<_ConfettiPiece> _confetti = _createConfetti();

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _scaleController.forward();
    _heartController.repeat(reverse: true);
    _confettiController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _heartController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    context.push('/chat');
  }

  void _keepDiscovering() {
    context.go('/discover');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF24103F),
                    Color(0xFF09070D),
                    Color(0xFF30101F),
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _confettiController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _ConfettiPainter(
                      pieces: _confetti,
                      progress: _confettiController.value,
                    ),
                  );
                },
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                24,
                24,
                28,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white12,
                        ),
                      ),
                      child: IconButton(
                        onPressed: _keepDiscovering,
                        tooltip: 'Close',
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: _scaleController,
                          curve: Curves.elasticOut,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "It's a Match!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'You both liked each other.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 34),

                            AnimatedBuilder(
                              animation: _heartController,
                              builder: (context, child) {
                                final pulse =
                                    1.0 +
                                    (_heartController.value * 0.06);

                                return Transform.scale(
                                  scale: pulse,
                                  child: child,
                                );
                              },
                              child: _ProfileConnection(
                                firstName: 'You',
                                secondName: 'Aarav',
                              ),
                            ),

                            const SizedBox(height: 30),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF4D8D)
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFFFF4D8D)
                                      .withValues(alpha: 0.22),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.favorite_rounded,
                                    color: Color(0xFFFF4D8D),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    'A new connection begins here',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: _sendMessage,
                          icon: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 20,
                          ),
                          label: Text(
                            'Send Message',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF4D8D),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: OutlinedButton(
                          onPressed: _keepDiscovering,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.16),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Keep Discovering',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileConnection extends StatelessWidget {
  const _ProfileConnection({
    required this.firstName,
    required this.secondName,
  });

  final String firstName;
  final String secondName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 310,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 10,
            child: _ProfileAvatar(
              imageUrl: 'https://i.pravatar.cc/500?img=11',
              name: firstName,
              angle: -0.10,
            ),
          ),
          Positioned(
            right: 10,
            child: _ProfileAvatar(
              imageUrl: 'https://i.pravatar.cc/500?img=12',
              name: secondName,
              angle: 0.10,
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFF4D8D),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4D8D).withValues(alpha: 0.45),
                  blurRadius: 25,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.imageUrl,
    required this.name,
    required this.angle,
  });

  final String imageUrl;
  final String name;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 145,
        height: 170,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFF17121D),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white12,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Image.network(
            imageUrl,
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
                    name.substring(0, 1),
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ConfettiPiece {
  const _ConfettiPiece({
    required this.x,
    required this.speed,
    required this.size,
    required this.rotation,
    required this.offset,
  });

  final double x;
  final double speed;
  final double size;
  final double rotation;
  final double offset;
}

List<_ConfettiPiece> _createConfetti() {
  final random = math.Random(17);

  return List.generate(
    55,
    (index) {
      return _ConfettiPiece(
        x: random.nextDouble(),
        speed: 0.35 + random.nextDouble() * 0.75,
        size: 4 + random.nextDouble() * 6,
        rotation: random.nextDouble() * math.pi,
        offset: random.nextDouble(),
      );
    },
  );
}

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter({
    required this.pieces,
    required this.progress,
  });

  final List<_ConfettiPiece> pieces;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    const colors = [
      Color(0xFFFF4D8D),
      Color(0xFF6C3FC8),
      Color(0xFFFFFFFF),
      Color(0xFFFFB6D0),
    ];

    for (var i = 0; i < pieces.length; i++) {
      final piece = pieces[i];

      final yProgress =
          ((progress * piece.speed) + piece.offset) % 1.15;

      final x = size.width * piece.x +
          math.sin(
                (progress * math.pi * 2) + piece.offset * 10,
              ) *
              22;

      final y = -20 + size.height * yProgress;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(
        piece.rotation + progress * math.pi * 4,
      );

      paint.color = colors[i % colors.length];

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: piece.size,
            height: piece.size * 1.8,
          ),
          Radius.circular(piece.size),
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}