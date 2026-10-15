import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  static const List<_MatchItem> _matches = [
    _MatchItem(
      name: 'Aarav',
      age: 25,
      lastMessage: 'I noticed you like coffee and travel.',
      time: '10:44 PM',
      unreadCount: 2,
      isOnline: true,
      imageUrl: 'https://i.pravatar.cc/300?img=12',
    ),
    _MatchItem(
      name: 'Maya',
      age: 23,
      lastMessage: 'Coffee this weekend? ☕',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
      imageUrl: 'https://i.pravatar.cc/300?img=47',
    ),
    _MatchItem(
      name: 'Riya',
      age: 27,
      lastMessage: 'That travel story was interesting 😊',
      time: 'Yesterday',
      unreadCount: 1,
      isOnline: true,
      imageUrl: 'https://i.pravatar.cc/300?img=44',
    ),
    _MatchItem(
      name: 'Kabir',
      age: 29,
      lastMessage: 'Nice meeting you here!',
      time: '2 days ago',
      unreadCount: 0,
      isOnline: false,
      imageUrl: 'https://i.pravatar.cc/300?img=8',
    ),
  ];

  void _openChat(BuildContext context, _MatchItem match) {
    debugPrint('MATCH_MESSAGE_TAP: ${match.name}');
    context.push('/chat');
  }

  Future<void> _openSearch(BuildContext context) async {
    final match = await showSearch<_MatchItem?>(
      context: context,
      delegate: _MatchesSearchDelegate(_matches),
    );

    if (match != null && context.mounted) {
      _openChat(context, match);
    }
  }

  void _showMatchOptions(BuildContext context, _MatchItem match) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF15111D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${match.name}, ${match.age}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _OptionTile(
                  icon: Icons.person_outline_rounded,
                  title: 'View Profile',
                  onTap: () {
                    Navigator.pop(sheetContext);

                    context.push(
                      Uri(
                        path: '/profile-details',
                        queryParameters: {
                          'name': match.name,
                          'age': '${match.age}',
                          'distance': 'Nearby',
                          'image': match.imageUrl,
                        },
                      ).toString(),
                    );
                  },
                ),
                _OptionTile(
                  icon: Icons.link_off_rounded,
                  title: 'Unmatch',
                  color: const Color(0xFFFF4D8D),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Unmatch for ${match.name} '
                          'will be connected to the backend later.',
                        ),
                        backgroundColor: const Color(0xFF21182B),
                      ),
                    );
                  },
                ),
                _OptionTile(
                  icon: Icons.flag_outlined,
                  title: 'Report',
                  color: const Color(0xFFFF4D8D),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    context.push(
                      '/safety?profile='
                      '${Uri.encodeComponent(match.name)}',
                    );
                  },
                ),
                _OptionTile(
                  icon: Icons.block_outlined,
                  title: 'Block',
                  color: const Color(0xFFFF4D8D),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    context.push(
                      '/safety?profile='
                      '${Uri.encodeComponent(match.name)}',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09070D),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Matches',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Keep the conversation going',
                          style: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: IconButton(
                      onPressed: () => _openSearch(context),
                      tooltip: 'Search matches',
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _SegmentChip(
                    label: 'New',
                    isSelected: true,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Showing your matches.')),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  _SegmentChip(
                    label: 'Messages',
                    isSelected: false,
                    onTap: () {
                      context.push('/chat');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: _matches.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final match = _matches[index];

                  return _MatchCard(
                    match: match,
                    onTap: () => _openChat(context, match),
                    onMessage: () => _openChat(context, match),
                    onMore: () => _showMatchOptions(context, match),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({
    required this.match,
    required this.onTap,
    required this.onMessage,
    required this.onMore,
  });

  final _MatchItem match;
  final VoidCallback onTap;
  final VoidCallback onMessage;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.045),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFFF4D8D)
                                      .withValues(alpha: 0.45),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  match.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF6C3FC8),
                                            Color(0xFFFF4D8D),
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        match.name.isNotEmpty
                                            ? match.name[0]
                                            : '?',
                                        style: GoogleFonts.poppins(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (match.isOnline)
                              Positioned(
                                right: 0,
                                bottom: 1,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFFF4D8D),
                                    border: Border.all(
                                      color: const Color(0xFF09070D),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${match.name}, ${match.age}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (match.isOnline) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF4D8D),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                match.lastMessage,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              match.time,
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                color: Colors.white38,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (match.unreadCount > 0)
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFF4D8D),
                                ),
                                child: Text(
                                  '${match.unreadCount}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
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
              IconButton(
                onPressed: onMessage,
                tooltip: 'Message ${match.name}',
                icon: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Color(0xFFFF4D8D),
                  size: 21,
                ),
              ),
              IconButton(
                onPressed: onMore,
                tooltip: 'More options',
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white38,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.white,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _MatchItem {
  const _MatchItem({
    required this.name,
    required this.age,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.imageUrl,
  });

  final String name;
  final int age;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String imageUrl;
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6C3FC8).withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.035),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6C3FC8)
                  : Colors.white.withValues(alpha: 0.10),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchesSearchDelegate extends SearchDelegate<_MatchItem?> {
  _MatchesSearchDelegate(this.matches);

  final List<_MatchItem> matches;

  @override
  String get searchFieldLabel => 'Search matches or messages...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final baseTheme = Theme.of(context);

    return baseTheme.copyWith(
      scaffoldBackgroundColor: const Color(0xFF09070D),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF09070D),
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
      textTheme: baseTheme.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          tooltip: 'Clear search',
          icon: const Icon(Icons.clear_rounded, color: Colors.white),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    final searchText = query.trim().toLowerCase();

    final results = matches.where((match) {
      if (searchText.isEmpty) {
        return true;
      }

      return match.name.toLowerCase().contains(searchText) ||
          match.lastMessage.toLowerCase().contains(searchText);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No matches found',
          style: GoogleFonts.poppins(color: Colors.white60, fontSize: 13),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: results.length,
      separatorBuilder: (context, index) {
        return const Divider(color: Colors.white12, height: 1);
      },
      itemBuilder: (context, index) {
        final match = results[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF6C3FC8),
            child: Text(
              match.name.isNotEmpty ? match.name[0].toUpperCase() : '?',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          title: Text(
            '${match.name}, ${match.age}',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            match.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
          ),
          trailing: const Icon(
            Icons.chat_bubble_outline_rounded,
            color: Color(0xFFFF4D8D),
          ),
          onTap: () => close(context, match),
        );
      },
    );
  }
}
