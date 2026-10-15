import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key, required this.profile});

  final Map<String, String> profile;

  @override
  Widget build(BuildContext context) {
    final name = profile['name'] ?? 'Profile';
    final age = profile['age'] ?? '';
    final distance = profile['distance'] ?? 'Nearby';
    final bio = profile['bio'] ?? 'Say hello and learn more about $name.';
    final interests = (profile['interests'] ?? 'Coffee, Travel, Music')
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
    final imageUrl = profile['image'];
    final isVerified = profile['verified'] == 'true';

    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 420,
            pinned: true,
            backgroundColor: const Color(0xFF09070D),
            leading: IconButton(
              tooltip: 'Back',
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => _imageFallback(name),
                    )
                  else
                    _imageFallback(name),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xE6000000)],
                        stops: [.42, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    right: 22,
                    bottom: 24,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$name${age.isEmpty ? '' : ', $age'}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 3),
                              Text('$distance · approximate',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70, fontSize: 13)),
                            ],
                          ),
                        ),
                        if (isVerified)
                          const Tooltip(
                            message: 'Verified',
                            child: Icon(Icons.verified_rounded,
                                color: Color(0xFF8C6DFF), size: 28),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                iconColor: Colors.white,
                color: const Color(0xFF1A1620),
                onSelected: (value) {
                  if (value == 'report' || value == 'block') {
                    context.push('/safety?profile=${Uri.encodeComponent(name)}');
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'report', child: Text('Report')),
                  PopupMenuItem(value: 'block', child: Text('Block')),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About $name',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text(bio,
                          style: GoogleFonts.poppins(
                              color: Colors.white70,
                              height: 1.55,
                              fontSize: 14)),
                      const SizedBox(height: 22),
                      Text('Interests',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: interests
                            .map((item) => Chip(
                                  label: Text(item),
                                  side: BorderSide.none,
                                  backgroundColor:
                                      const Color(0xFF6C3FC8).withValues(alpha: .25),
                                  labelStyle: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context, false),
                              icon: const Icon(Icons.close_rounded),
                              label: const Text('Pass'),
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context, true),
                              icon: const Icon(Icons.favorite_rounded),
                              label: const Text('Like'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6C3FC8),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFallback(String name) => Container(
        color: const Color(0xFF21192B),
        alignment: Alignment.center,
        child: Text(name.isEmpty ? '?' : name.substring(0, 1).toUpperCase(),
            style: GoogleFonts.poppins(
                color: Colors.white38, fontSize: 72, fontWeight: FontWeight.w700)),
      );
}
