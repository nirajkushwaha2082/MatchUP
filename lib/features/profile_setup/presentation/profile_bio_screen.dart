import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBioScreen extends StatefulWidget {
  const ProfileBioScreen({super.key});

  @override
  State<ProfileBioScreen> createState() => _ProfileBioScreenState();
}

class _ProfileBioScreenState extends State<ProfileBioScreen> {
  static const int _maxCharacters = 500;

  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _bioController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void _continue() {
    final bio = _bioController.text.trim();

    if (bio.isEmpty) {
      _showMessage('Please write something about yourself.');
      return;
    }

    if (bio.length > _maxCharacters) {
      _showMessage('Your bio cannot exceed 500 characters.');
      return;
    }

    context.push('/profile-interests');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
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

  @override
  Widget build(BuildContext context) {
    final characterCount = _bioController.text.length;

    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _backButton(),
                          const Spacer(),
                          Text(
                            '3 of 4',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Let your personality\nshine',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          height: 1.18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Write a short bio that helps people get to know you.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white10,
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: TextField(
                          controller: _bioController,
                          minLines: 9,
                          maxLines: 12,
                          maxLength: _maxCharacters,
                          textCapitalization:
                              TextCapitalization.sentences,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'Tell people something interesting about you...',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.white38,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding:
                                const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit_note_rounded,
                            size: 18,
                            color: Colors.white38,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Keep it authentic and positive.',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: Colors.white38,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$characterCount / $_maxCharacters',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: characterCount >
                                      _maxCharacters
                                  ? const Color(0xFFFF4D8D)
                                  : Colors.white.withValues(
                                      alpha: 0.45,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                12,
                24,
                24,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C3FC8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}