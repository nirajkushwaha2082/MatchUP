import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/profile_draft.dart';

class DatingPreferencesScreen extends StatefulWidget {
  const DatingPreferencesScreen({super.key});

  @override
  State<DatingPreferencesScreen> createState() =>
      _DatingPreferencesScreenState();
}

class _DatingPreferencesScreenState extends State<DatingPreferencesScreen> {
  static const List<String> _genderOptions = ['Men', 'Women', 'Everyone'];

  static const List<String> _intentions = [
    'Long-term relationship',
    'Short-term dating',
    'New connections',
    'Still figuring it out',
  ];

  late RangeValues _ageRange;
  late double _distance;
  late String _intention;

  @override
  void initState() {
    super.initState();

    final minimumAge = ProfileDraft.minimumAge.clamp(18, 59).toDouble();

    final maximumAge = ProfileDraft.maximumAge
        .clamp(minimumAge.round() + 1, 60)
        .toDouble();

    _ageRange = RangeValues(minimumAge, maximumAge);

    _distance = ProfileDraft.maximumDistanceKm.clamp(5, 300).toDouble();

    _intention = _intentions.contains(ProfileDraft.relationshipIntention)
        ? ProfileDraft.relationshipIntention
        : '';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.poppins(fontSize: 12)),
          backgroundColor: const Color(0xFF21182B),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _continue() {
    if (ProfileDraft.datingPreference.isEmpty) {
      _showMessage('Please choose who you want to meet.');
      return;
    }

    if (_intention.isEmpty) {
      _showMessage('Please select your relationship intention.');
      return;
    }

    ProfileDraft.minimumAge = _ageRange.start.round();
    ProfileDraft.maximumAge = _ageRange.end.round();
    ProfileDraft.maximumDistanceKm = _distance;
    ProfileDraft.relationshipIntention = _intention;

    context.go('/profile-preview');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressIndicator(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                children: [
                  Text(
                    'What are you looking for?',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your preferences to help MatchUP '
                    'find people who match your energy.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      height: 1.6,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 28),

                  const _SectionHeading(
                    icon: Icons.cake_rounded,
                    title: 'Preferred age',
                  ),
                  const SizedBox(height: 12),
                  _buildAgeCard(),

                  const SizedBox(height: 24),

                  const _SectionHeading(
                    icon: Icons.location_on_rounded,
                    title: 'Preferred distance',
                  ),
                  const SizedBox(height: 12),
                  _buildDistanceCard(),

                  const SizedBox(height: 24),

                  const _SectionHeading(
                    icon: Icons.people_alt_rounded,
                    title: 'Who would you like to meet?',
                  ),
                  const SizedBox(height: 12),
                  _buildGenderCard(),

                  const SizedBox(height: 24),

                  const _SectionHeading(
                    icon: Icons.favorite_rounded,
                    title: 'Relationship intention',
                  ),
                  const SizedBox(height: 12),
                  _buildIntentions(),

                  const SizedBox(height: 18),
                  _buildPrivacyNote(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4D8D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 19),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 19,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Dating Preferences',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '5 of 6',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: 5 / 6,
          minHeight: 5,
          backgroundColor: Colors.white.withValues(alpha: 0.09),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF4D8D)),
        ),
      ),
    );
  }

  Widget _buildAgeCard() {
    return _GlassCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_ageRange.start.round()}',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4D8D).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFFF4D8D).withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  '${_ageRange.start.round()} – '
                  '${_ageRange.end.round()} years',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFF4D8D),
                  ),
                ),
              ),
              Text(
                '${_ageRange.end.round()}',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RangeSlider(
            values: _ageRange,
            min: 18,
            max: 60,
            divisions: 42,
            activeColor: const Color(0xFFFF4D8D),
            inactiveColor: Colors.white.withValues(alpha: 0.12),
            labels: RangeLabels(
              _ageRange.start.round().toString(),
              _ageRange.end.round().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _ageRange = values;
              });

              ProfileDraft.minimumAge = values.start.round();
              ProfileDraft.maximumAge = values.end.round();
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_MutedLabel('18 years'), _MutedLabel('60 years')],
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceCard() {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C3FC8).withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.near_me_rounded,
                  color: Color(0xFFB99AF5),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Within ${_distance.round()} km',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '${_distance.round()} km',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Slider(
            value: _distance,
            min: 5,
            max: 300,
            divisions: 59,
            activeColor: const Color(0xFFFF4D8D),
            inactiveColor: Colors.white.withValues(alpha: 0.12),
            label: '${_distance.round()} km',
            onChanged: (value) {
              setState(() {
                _distance = value;
              });

              ProfileDraft.maximumDistanceKm = value;
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_MutedLabel('5 km'), _MutedLabel('300 km')],
          ),
          const SizedBox(height: 12),
          Text(
            'Distance is approximate. Your exact location '
            'will not be displayed to other users.',
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              height: 1.55,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard() {
    return _GlassCard(
      padding: EdgeInsets.zero,
      child: RadioGroup<String>(
        groupValue: ProfileDraft.datingPreference,
        onChanged: (value) {
          if (value == null) return;

          setState(() {
            ProfileDraft.datingPreference = value;
          });
        },
        child: Column(
          children: _genderOptions.map((option) {
            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: RadioListTile<String>(
                value: option,
                activeColor: const Color(0xFFFF4D8D),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  option,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildIntentions() {
    return Column(
      children: _intentions.map((option) {
        final selected = _intention == option;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _IntentionTile(
            title: option,
            selected: selected,
            onTap: () {
              setState(() {
                _intention = option;
                ProfileDraft.relationshipIntention = option;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrivacyNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF6C3FC8).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6C3FC8).withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            color: Color(0xFFB99AF5),
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your preferences personalize discovery. MatchUP '
              'uses approximate distance instead of displaying '
              'your exact location.',
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                height: 1.55,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFFF4D8D).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 17, color: const Color(0xFFFF4D8D)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _MutedLabel extends StatelessWidget {
  const _MutedLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 10, color: Colors.white54),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
      ),
      child: child,
    );
  }
}

class _IntentionTile extends StatelessWidget {
  const _IntentionTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF6C3FC8).withValues(alpha: 0.17)
                : Colors.white.withValues(alpha: 0.035),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected
                  ? const Color(0xFF6C3FC8).withValues(alpha: 0.55)
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? const Color(0xFFFF4D8D)
                      : Colors.transparent,
                  border: Border.all(
                    color: selected ? const Color(0xFFFF4D8D) : Colors.white38,
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
