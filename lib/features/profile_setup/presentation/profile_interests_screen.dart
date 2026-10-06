import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInterestsScreen extends StatefulWidget {
  const ProfileInterestsScreen({super.key});

  @override
  State<ProfileInterestsScreen> createState() =>
      _ProfileInterestsScreenState();
}

class _ProfileInterestsScreenState
    extends State<ProfileInterestsScreen> {
  final _searchController = TextEditingController();

  final List<String> _allInterests = [
    'Music',
    'Movies',
    'Travel',
    'Photography',
    'Food',
    'Coffee',
    'Fitness',
    'Reading',
    'Gaming',
    'Hiking',
    'Cooking',
    'Dancing',
    'Art',
    'Fashion',
    'Football',
    'Cricket',
    'Basketball',
    'Tech',
    'Startups',
    'Nature',
    'Pets',
    'Yoga',
    'Writing',
    'Volunteering',
    'Books',
    'Podcasts',
    'Anime',
    'Coding',
    'Adventure',
    'Meditation',
  ];

  final Set<String> _selectedInterests = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _filteredInterests {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return _allInterests;
    }

    return _allInterests
        .where(
          (interest) =>
              interest.toLowerCase().contains(query),
        )
        .toList();
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        if (_selectedInterests.length >= 15) {
          _showMessage(
            'You can select up to 15 interests.',
          );
          return;
        }

        _selectedInterests.add(interest);
      }
    });
  }

  void _completeProfile() {
    if (_selectedInterests.length < 3) {
      _showMessage(
        'Please select at least 3 interests.',
      );
      return;
    }

    context.go('/discover');
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
    final selectedCount = _selectedInterests.length;

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
                            '4 of 4',
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
                        'What are you\ninto?',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          height: 1.18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Choose at least 3 interests. We recommend 5–8 to help personalize your matches.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _searchField(),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _filteredInterests.map(
                          (interest) {
                            final isSelected =
                                _selectedInterests
                                    .contains(interest);

                            return GestureDetector(
                              onTap: () =>
                                  _toggleInterest(interest),
                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 180,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF6C3FC8)
                                      : Colors.white
                                          .withValues(
                                          alpha: 0.05,
                                        ),
                                  borderRadius:
                                      BorderRadius.circular(24),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(
                                            0xFFFF4D8D,
                                          )
                                        : Colors.white10,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize:
                                      MainAxisSize.min,
                                  children: [
                                    if (isSelected) ...[
                                      const Icon(
                                        Icons.check_rounded,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                    Text(
                                      interest,
                                      style:
                                          GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight:
                                            FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        '$selectedCount / 15 selected',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: selectedCount >= 3
                              ? const Color(0xFFFF4D8D)
                              : Colors.white38,
                        ),
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
                  onPressed: _completeProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C3FC8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Complete Profile',
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

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: 'Search interests...',
        hintStyle: GoogleFonts.poppins(
          color: Colors.white38,
          fontSize: 14,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Colors.white54,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                onPressed: _searchController.clear,
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white54,
                  size: 19,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white10,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white10,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF6C3FC8),
            width: 1.2,
          ),
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