import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBasicInfoScreen extends StatefulWidget {
  const ProfileBasicInfoScreen({super.key});

  @override
  State<ProfileBasicInfoScreen> createState() =>
      _ProfileBasicInfoScreenState();
}

class _ProfileBasicInfoScreenState
    extends State<ProfileBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();

  DateTime? _dateOfBirth;
  String? _gender;
  String? _datingPreference;

  final List<String> _genderOptions = [
    'Man',
    'Woman',
    'Non-binary',
    'Prefer not to say',
  ];

  final List<String> _preferenceOptions = [
    'Men',
    'Women',
    'Everyone',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  int? get _age {
    if (_dateOfBirth == null) {
      return null;
    }

    final today = DateTime.now();

    int age = today.year - _dateOfBirth!.year;

    final birthdayThisYear = DateTime(
      today.year,
      _dateOfBirth!.month,
      _dateOfBirth!.day,
    );

    if (today.isBefore(birthdayThisYear)) {
      age--;
    }

    return age;
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();

    final initialDate = DateTime(
      now.year - 18,
      now.month,
      now.day,
    );

    final firstDate = DateTime(
      now.year - 100,
      now.month,
      now.day,
    );

    final lastDate = DateTime(
      now.year - 18,
      now.month,
      now.day,
    );

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C3FC8),
              secondary: Color(0xFFFF4D8D),
              surface: Color(0xFF15111B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _dateOfBirth = selectedDate;
      });
    }
  }

  void _continue() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_dateOfBirth == null) {
      _showMessage('Please select your date of birth.');
      return;
    }

    if ((_age ?? 0) < 18) {
      _showMessage('You must be 18 or older.');
      return;
    }

    if (_gender == null) {
      _showMessage('Please select your gender.');
      return;
    }

    if (_datingPreference == null) {
      _showMessage('Please select who you are interested in.');
      return;
    }

    context.push('/profile-bio');
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _topBar(),
                        const SizedBox(height: 32),

                        Text(
                          'Tell us about\nyourself',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            height: 1.18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'These details help us personalize your MatchUP experience.',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 30),

                        _label('First Name'),
                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          style: _inputTextStyle(),
                          decoration: _inputDecoration(
                            hint: 'Enter your first name',
                            icon: Icons.person_outline_rounded,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your first name';
                            }

                            if (value.trim().length < 2) {
                              return 'Name must be at least 2 characters';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        _label('Date of Birth'),
                        const SizedBox(height: 8),

                        GestureDetector(
                          onTap: _selectDateOfBirth,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: _boxDecoration(),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.cake_outlined,
                                  color: Colors.white54,
                                  size: 21,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _dateOfBirth == null
                                        ? 'Select your date of birth'
                                        : '${_dateOfBirth!.day.toString().padLeft(2, '0')}/'
                                            '${_dateOfBirth!.month.toString().padLeft(2, '0')}/'
                                            '${_dateOfBirth!.year}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: _dateOfBirth == null
                                          ? Colors.white38
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                if (_age != null)
                                  Text(
                                    '$_age years',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFF4D8D),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        _label('Gender'),
                        const SizedBox(height: 8),

                        _dropdown(
                          value: _gender,
                          hint: 'Select your gender',
                          icon: Icons.wc_outlined,
                          items: _genderOptions,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),

                        const SizedBox(height: 22),

                        _label('Who are you interested in?'),
                        const SizedBox(height: 8),

                        _dropdown(
                          value: _datingPreference,
                          hint: 'Select your preference',
                          icon: Icons.favorite_border_rounded,
                          items: _preferenceOptions,
                          onChanged: (value) {
                            setState(() {
                              _datingPreference = value;
                            });
                          },
                        ),

                        const SizedBox(height: 22),

                        _label('City'),
                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _cityController,
                          textInputAction: TextInputAction.done,
                          style: _inputTextStyle(),
                          decoration: _inputDecoration(
                            hint: 'e.g. Kathmandu',
                            icon: Icons.location_on_outlined,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your city';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Only your city or approximate location is needed. Do not enter your home address.',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            height: 1.45,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            _bottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        _backButton(),
        const Spacer(),
        Text(
          '2 of 4',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _backButton() {
    return Container(
      width: 42,
      height: 42,
      decoration: _boxDecoration(),
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

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  TextStyle _inputTextStyle() {
    return GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 14,
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        color: Colors.white38,
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white54,
        size: 21,
      ),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFFF4D8D),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFFF4D8D),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white10,
      ),
    );
  }

  Widget _dropdown({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: _boxDecoration(),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        dropdownColor: const Color(0xFF18131F),
        iconEnabledColor: Colors.white54,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white38,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white54,
            size: 21,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
    );
  }
}