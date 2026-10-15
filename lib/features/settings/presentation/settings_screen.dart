import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../profile_setup/data/profile_draft.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _visible = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _showDistance = true;

  Future<void> _logout() async {
    final confirmed = await _confirm(
      'Log out?',
      'You will return to the sign-in screen. This prototype has no active authentication session.',
      'Log out',
    );
    if (confirmed && mounted) {
      ProfileDraft.reset();
      context.go('/login');
    }
  }

  Future<void> _showUnavailable(String feature) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1620),
        title: Text(feature,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
        content: Text(
            'This account service is not connected yet. No account changes were made.',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it')),
        ],
      ),
    );
  }

  Future<bool> _confirm(String title, String message, String action) async =>
      await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF1A1620),
              title: Text(title,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
              content: Text(message,
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
          ) ??
          false;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF09070D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF09070D),
          title: Text('Settings',
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
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              children: [
                _heading('Discovery'),
                _switch('Visible in Discover',
                    'Pause or resume showing your profile.', _visible,
                    (value) => setState(() => _visible = value)),
                _switch('Show approximate distance',
                    'Never show exact coordinates or address.', _showDistance,
                    (value) => setState(() => _showDistance = value)),
                _heading('Notifications'),
                _switch('Push notifications', 'Match and message alerts.',
                    _pushNotifications,
                    (value) => setState(() => _pushNotifications = value)),
                _switch('Email updates', 'Product news and account updates.',
                    _emailNotifications,
                    (value) => setState(() => _emailNotifications = value)),
                _heading('Your account'),
                _item(context, Icons.edit_outlined, 'Edit profile',
                    () => context.push('/profile-preview')),
                _item(context, Icons.tune_rounded, 'Dating preferences',
                    () => context.push('/profile-dating-preferences')),
                _item(context, Icons.shield_outlined, 'Safety Center',
                    () => context.push('/safety')),
                _item(context, Icons.help_outline_rounded, 'Help and support',
                    () => _showUnavailable('Help and support')),
                _item(context, Icons.description_outlined,
                    'Terms and Privacy Policy',
                    () => _showUnavailable('Terms and Privacy Policy')),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Log out'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _showUnavailable('Delete account'),
                  child: Text('Delete account',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFFF7A8F), fontSize: 13)),
                ),
                const SizedBox(height: 12),
                Text(
                  'Preference switches apply only in this session. Profile visibility, notifications, legal pages, logout and deletion need backend services.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.white38, fontSize: 11, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _heading(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
        child: Text(title.toUpperCase(),
            style: GoogleFonts.poppins(
                color: const Color(0xFFFF4D8D),
                fontSize: 11,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w700)),
      );

  Widget _switch(String title, String subtitle, bool value,
          ValueChanged<bool> onChanged) =>
      Card(
        color: const Color(0xFF15111B),
        child: SwitchListTile.adaptive(
          value: value,
          activeThumbColor: const Color(0xFFFF4D8D),
          title: Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle,
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
          onChanged: onChanged,
        ),
      );

  Widget _item(BuildContext context, IconData icon, String label,
          VoidCallback onTap) =>
      Card(
        color: const Color(0xFF15111B),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFFFF4D8D)),
          title: Text(label,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white54),
          onTap: onTap,
        ),
      );
}
