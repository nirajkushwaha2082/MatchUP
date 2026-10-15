import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SafetyCenterScreen extends StatelessWidget {
  const SafetyCenterScreen({super.key, this.profileName});

  final String? profileName;

  static const _reportReasons = [
    'Fake profile',
    'Harassment',
    'Hate speech',
    'Sexual content',
    'Scam or financial request',
    'Spam',
    'Underage concern',
    'Threatening behavior',
    'Stolen photos',
    'Other',
  ];

  Future<void> _report(BuildContext context) async {
    final reason = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF15111B),
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report a profile',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text('Choose the reason that best describes the issue.',
                  style: GoogleFonts.poppins(color: Colors.white60, fontSize: 13)),
              const SizedBox(height: 12),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: _reportReasons
                      .map((item) => ListTile(
                            title: Text(item,
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 14)),
                            trailing: const Icon(Icons.chevron_right_rounded,
                                color: Colors.white54),
                            onTap: () => Navigator.pop(context, item),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (reason == null || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Report noted for ${profileName ?? 'this profile'}: $reason. Backend submission is not connected yet.')),
    );
  }

  Future<void> _confirmPrototypeAction(
      BuildContext context, String action, String description) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1620),
        title: Text(action,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
        content: Text(description,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(action)),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$action is a prototype action; backend storage is not connected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF09070D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF09070D),
          title: Text('Safety Center',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          leading: IconButton(
              tooltip: 'Back',
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded)),
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
                    color: const Color(0xFF6C3FC8).withValues(alpha: .16),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF6C3FC8).withValues(alpha: .35)),
                  ),
                  child: Text(
                    'Your comfort matters. Meet in public places, tell someone you trust about your plans, and keep personal information private until you feel safe.',
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 13, height: 1.55),
                  ),
                ),
                const SizedBox(height: 18),
                _item(context, Icons.flag_outlined, 'Report a profile',
                    'Tell us about behavior that concerns you${profileName == null ? '' : ' (${profileName!})'}.',
                    () => _report(context)),
                _item(context, Icons.block_outlined, 'Block a user',
                    'Prevent a profile from contacting you.',
                    () => _confirmPrototypeAction(context, 'Block user',
                        'Block ${profileName ?? 'this profile'}? This prototype can show the confirmation flow, but it cannot persist a block until the backend is connected.')),
                _item(context, Icons.link_off_rounded, 'Unmatch',
                    'End a match and remove the conversation.',
                    () => _confirmPrototypeAction(context, 'Unmatch',
                        'Are you sure you want to unmatch ${profileName ?? 'this profile'}? This prototype cannot update the match service yet.')),
                const SizedBox(height: 20),
                Text('Privacy guidance',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                _tip('Keep your home address, financial details, and passwords private.'),
                _tip('Use in-app conversations and make your own plan for first meetings.'),
                _tip('If you feel in immediate danger, contact local emergency services or someone you trust.'),
                const SizedBox(height: 16),
                Text('Report and block requests are prototype-only until backend persistence is available.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
        ),
      );

  Widget _item(BuildContext context, IconData icon, String title, String subtitle,
          VoidCallback onTap) =>
      Card(
        color: const Color(0xFF15111B),
        child: ListTile(
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

  Widget _tip(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline_rounded,
                color: Color(0xFFFF4D8D), size: 18),
            const SizedBox(width: 10),
            Expanded(
                child: Text(text,
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 13, height: 1.45))),
          ],
        ),
      );
}
