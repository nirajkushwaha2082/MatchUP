class LikeResult {
  const LikeResult({
    required this.isMatch,
    this.matchId,
  });

  final bool isMatch;
  final String? matchId;
}

class MockMatchingService {
  MockMatchingService._();

  static final MockMatchingService instance =
      MockMatchingService._();

  // Demo current user.
  static const String currentUserId = 'user_1';

  // Profiles already liked by the current user.
  final Set<String> _myLikes = <String>{};

  // Profiles that have already liked the current user.
  //
  // Aarav is pre-seeded so we can test:
  //
  // You → Like Aarav
  // Aarav → Already liked You
  // = Match
  final Set<String> _incomingLikes = <String>{
    'aarav_1',
  };

  // Created matches.
  final Map<String, String> _matchIds = <String, String>{};

  /// Like another user.
  ///
  /// If the other user has already liked us,
  /// a match is created.
  Future<LikeResult> likeUser(String targetUserId) async {
    // User cannot like themselves.
    if (targetUserId == currentUserId) {
      return const LikeResult(
        isMatch: false,
      );
    }

    // Prevent duplicate actions.
    if (_myLikes.contains(targetUserId)) {
      final existingMatchId = _matchIds[targetUserId];

      return LikeResult(
        isMatch: existingMatchId != null,
        matchId: existingMatchId,
      );
    }

    // Record our like.
    _myLikes.add(targetUserId);

    // Simulate backend/network delay.
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    // Check reciprocal like.
    final hasMutualLike =
        _incomingLikes.contains(targetUserId);

    if (!hasMutualLike) {
      return const LikeResult(
        isMatch: false,
      );
    }

    // Create match.
    final matchId = _createMatchId(targetUserId);

    _matchIds[targetUserId] = matchId;

    return LikeResult(
      isMatch: true,
      matchId: matchId,
    );
  }

  /// Pass/dislike another user.
  Future<void> passUser(String targetUserId) async {
    _myLikes.remove(targetUserId);

    await Future<void>.delayed(
      const Duration(milliseconds: 120),
    );
  }

  /// Super Like.
  ///
  /// For the current mock system it follows the
  /// same mutual-like matching rule.
  Future<LikeResult> superLikeUser(
    String targetUserId,
  ) async {
    return likeUser(targetUserId);
  }

  /// Check if current user has liked someone.
  bool hasLiked(String targetUserId) {
    return _myLikes.contains(targetUserId);
  }

  /// Check if someone has already liked current user.
  bool hasIncomingLike(String targetUserId) {
    return _incomingLikes.contains(targetUserId);
  }

  /// Get existing match ID.
  String? getMatchId(String targetUserId) {
    return _matchIds[targetUserId];
  }

  /// Reset demo data.
  ///
  /// Useful for testing the flow again.
  void resetDemoState() {
    _myLikes.clear();
    _matchIds.clear();

    _incomingLikes
      ..clear()
      ..add('aarav_1');
  }

  String _createMatchId(String targetUserId) {
    final ids = <String>[
      currentUserId,
      targetUserId,
    ]..sort();

    return 'match_${ids.join('_')}';
  }
}
