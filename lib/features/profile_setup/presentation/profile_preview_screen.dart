import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/profile_draft.dart';

class ProfilePreviewScreen extends StatelessWidget {
  const ProfilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final missing = ProfileDraft.missingRequiredFields;
    final complete = missing.isEmpty;
    final photo = ProfileDraft.photos.isEmpty ? null : ProfileDraft.photos.first;

    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09070D),
        title: Text('Profile preview',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 370,
                    color: const Color(0xFF1A1620),
                    child: photo == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_a_photo_outlined,
                                  color: Colors.white38, size: 40),
                              const SizedBox(height: 12),
                              Text('Add a photo to preview your profile',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white60, fontSize: 13)),
                            ],
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.memory(photo, fit: BoxFit.cover),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.black87],
                                    stops: [0.48, 1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                right: 16,
                                bottom: 20,
                                child: Text(
                                  [
                                    if (ProfileDraft.name.trim().isNotEmpty)
                                      ProfileDraft.name.trim(),
                                    if (ProfileDraft.age != null)
                                      '${ProfileDraft.age}',
                                  ].join(', ').isEmpty
                                      ? 'Your name and age'
                                      : [
                                          if (ProfileDraft.name.trim().isNotEmpty)
                                            ProfileDraft.name.trim(),
                                          if (ProfileDraft.age != null)
                                            '${ProfileDraft.age}',
                                        ].join(', '),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 18),
                _card(
                  context,
                  title: 'Your details',
                  onEdit: () => context.push('/profile-basic-info'),
                  child: Text(
                    [
                      if (ProfileDraft.gender.isNotEmpty) ProfileDraft.gender,
                      if (ProfileDraft.city.trim().isNotEmpty)
                        ProfileDraft.city.trim(),
                      if (ProfileDraft.datingPreference.isNotEmpty)
                        'Interested in ${ProfileDraft.datingPreference.toLowerCase()}',
                    ].isEmpty
                        ? 'Add your name, age, city and who you want to meet.'
                        : [
                            if (ProfileDraft.gender.isNotEmpty)
                              ProfileDraft.gender,
                            if (ProfileDraft.city.trim().isNotEmpty)
                              ProfileDraft.city.trim(),
                            if (ProfileDraft.datingPreference.isNotEmpty)
                              'Interested in ${ProfileDraft.datingPreference.toLowerCase()}',
                          ].join(' · '),
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 14, height: 1.5),
                  ),
                ),
                const SizedBox(height: 12),
                _card(
                  context,
                  title: 'Photos',
                  onEdit: () => context.push('/profile-setup'),
                  child: Text(
                    '${ProfileDraft.photos.length} photo${ProfileDraft.photos.length == 1 ? '' : 's'} added. You can add up to 6.',
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 12),
                _card(
                  context,
                  title: 'About me',
                  onEdit: () => context.push('/profile-bio'),
                  child: Text(
                    ProfileDraft.bio.isEmpty
                        ? 'Add a short bio so people can get to know you.'
                        : ProfileDraft.bio,
                    style: GoogleFonts.poppins(
                        color: ProfileDraft.bio.isEmpty
                            ? Colors.white38
                            : Colors.white70,
                        fontSize: 14,
                        height: 1.55),
                  ),
                ),
                const SizedBox(height: 12),
                _card(
                  context,
                  title: 'Interests',
                  onEdit: () => context.push('/profile-interests'),
                  child: ProfileDraft.interests.isEmpty
                      ? Text('Choose a few interests.',
                          style: GoogleFonts.poppins(color: Colors.white38))
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ProfileDraft.interests
                              .map((interest) => Chip(
                                    label: Text(interest),
                                    backgroundColor: const Color(0xFF6C3FC8)
                                        .withValues(alpha: .25),
                                    side: BorderSide.none,
                                    labelStyle: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12),
                                  ))
                              .toList(),
                        ),
                ),
                const SizedBox(height: 12),
                _card(
                  context,
                  title: 'Looking for',
                  onEdit: () => context.push('/profile-dating-preferences'),
                  child: Text(
                    ProfileDraft.relationshipIntention.isEmpty
                        ? 'Choose your relationship intention.'
                        : '${ProfileDraft.relationshipIntention} · ${ProfileDraft.minimumAge}–${ProfileDraft.maximumAge} · up to ${ProfileDraft.maximumDistanceKm.round()} km',
                    style: GoogleFonts.poppins(
                        color: ProfileDraft.relationshipIntention.isEmpty
                            ? Colors.white38
                            : Colors.white70,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .04),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text('Profile completion',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))),
                          Text('${ProfileDraft.completionPercent}%',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFFFF4D8D),
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: ProfileDraft.completionPercent / 100,
                        color: const Color(0xFFFF4D8D),
                        backgroundColor: Colors.white12,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      if (!complete) ...[
                        const SizedBox(height: 12),
                        Text('Still needed: ${missing.join(' · ')}',
                            style: GoogleFonts.poppins(
                                color: Colors.white60, fontSize: 12)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: complete
                        ? () => context.go('/discover')
                        : () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Complete the required profile details before discovering people.')),
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C3FC8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text('Start matching',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your profile draft is held in this app session until backend profile storage is connected.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.white38, fontSize: 11, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context,
          {required String title,
          required VoidCallback onEdit,
          required Widget child}) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(title,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
                TextButton(onPressed: onEdit, child: const Text('Edit')),
              ],
            ),
            const SizedBox(height: 4),
            child,
          ],
        ),
      );
}
