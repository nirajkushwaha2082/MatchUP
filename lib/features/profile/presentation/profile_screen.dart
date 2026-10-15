import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../profile_setup/data/profile_draft.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final image = ProfileDraft.photos.isEmpty ? null : ProfileDraft.photos.first;
    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09070D),
        title: Text('Your profile',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .04),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: const Color(0xFF6C3FC8),
                      backgroundImage: image == null ? null : MemoryImage(image),
                      child: image == null
                          ? const Icon(Icons.person_rounded,
                              size: 36, color: Colors.white70)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            [
                              if (ProfileDraft.name.isEmpty) 'Your profile',
                              if (ProfileDraft.name.isNotEmpty) ProfileDraft.name,
                              if (ProfileDraft.age != null) '${ProfileDraft.age}',
                            ].join(', '),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w700),
                          ),
                          if (ProfileDraft.city.isNotEmpty)
                            Text(ProfileDraft.city,
                                style: GoogleFonts.poppins(
                                    color: Colors.white60, fontSize: 13)),
                          const SizedBox(height: 7),
                          Text('${ProfileDraft.completionPercent}% complete',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFFFF4D8D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _action(context, Icons.edit_outlined, 'Edit profile',
                  'Photos, about you and interests',
                  () => context.push('/profile-preview')),
              _action(context, Icons.tune_rounded, 'Dating preferences',
                  'Age, distance and relationship goals',
                  () => context.push('/profile-dating-preferences')),
              _action(context, Icons.shield_outlined, 'Safety Center',
                  'Manage safety and report concerns',
                  () => context.push('/safety')),
              _action(context, Icons.settings_outlined, 'Settings',
                  'Privacy, notifications and account',
                  () => context.push('/settings')),
              if (ProfileDraft.bio.isNotEmpty) ...[
                const SizedBox(height: 12),
                _section('About me', ProfileDraft.bio),
              ],
              if (ProfileDraft.interests.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .04),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Interests',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ProfileDraft.interests
                            .map((item) => Chip(
                                  label: Text(item),
                                  backgroundColor:
                                      const Color(0xFF6C3FC8).withValues(alpha: .25),
                                  side: BorderSide.none,
                                  labelStyle: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'This profile is a local prototype draft. Account persistence and verification need backend integration.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.white38, fontSize: 11, height: 1.45),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _action(BuildContext context, IconData icon, String title,
          String subtitle, VoidCallback onTap) =>
      Card(
        color: const Color(0xFF15111B),
        child: ListTile(
          minVerticalPadding: 10,
          leading: Icon(icon, color: const Color(0xFFFF4D8D)),
          title: Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle,
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
          trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white54),
          onTap: onTap,
        ),
      );

  Widget _section(String title, String value) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .04),
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(value,
                style: GoogleFonts.poppins(
                    color: Colors.white70, fontSize: 13, height: 1.5)),
          ],
        ),
      );
}
