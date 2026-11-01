import 'dart:typed_data';

/// In-memory frontend draft until the authenticated profile API is available.
/// This is intentionally not presented as persisted account data.
class ProfileDraft {
  ProfileDraft._();

  static final List<Uint8List> photos = [];
  static String name = '';
  static DateTime? dateOfBirth;
  static String gender = '';
  static String datingPreference = '';
  static String city = '';
  static String bio = '';
  static final Set<String> interests = {};
  static int minimumAge = 21;
  static int maximumAge = 35;
  static double maximumDistanceKm = 50;
  static String relationshipIntention = '';

  static int? get age {
    final dob = dateOfBirth;
    if (dob == null) return null;
    final today = DateTime.now();
    var result = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      result--;
    }
    return result;
  }

  static List<String> get missingRequiredFields => [
        if (photos.isEmpty) 'Add at least one photo',
        if (name.trim().isEmpty) 'Add your name',
        if (age == null || age! < 18) 'Confirm your age (18+)',
        if (gender.isEmpty) 'Choose your gender',
        if (datingPreference.isEmpty) 'Choose who you want to meet',
        if (city.trim().isEmpty) 'Add your city',
        if (bio.trim().isEmpty) 'Write a short bio',
        if (interests.length < 3) 'Choose at least 3 interests',
        if (relationshipIntention.isEmpty) 'Choose your relationship intention',
      ];

  static int get completionPercent {
    final completed = 9 - missingRequiredFields.length;
    return ((completed.clamp(0, 9) / 9) * 100).round();
  }

  static void reset() {
    photos.clear();
    name = '';
    dateOfBirth = null;
    gender = '';
    datingPreference = '';
    city = '';
    bio = '';
    interests.clear();
    minimumAge = 21;
    maximumAge = 35;
    maximumDistanceKm = 50;
    relationshipIntention = '';
  }
}
