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
    context.push('/chat');
  }

  void _showMatchOptions(
    BuildContext context,
    _MatchItem match,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF15111B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  match.name,
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                _OptionTile(
                  icon: Icons.person_outline_rounded,
                  title: 'View Profile',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _OptionTile(
                  icon: Icons.link_off_rounded,
                  title: 'Unmatch',
                  color: const Color(0xFFFF4D8D),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _OptionTile(
                  icon: Icons.block_outlined,
                  title: 'Block',
                  color: const Color(0xFFFF4D8D),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _OptionTile(
                  icon: Icons.flag_outlined,
                  title: 'Report',
                  color: const Color(0xFFFF4D8D),
                  onTap: () {
                    Navigator.pop(context);
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
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                14,
              ),
              child: Row(
                children: [
                  Text(
                    'Matches',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(
                        color: Colors.white10,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      tooltip: 'Search',
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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  _SegmentChip(
                    label: 'New',
                    isSelected: true,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  _SegmentChip(
                    label: 'Messages',
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: _matches.isEmpty
                  ? const _EmptyMatchesState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        24,
                      ),
                      itemCount: _matches.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        final match = _matches[index];

                        return _MatchCard(
                          match: match,
                          onTap: () => _openChat(
                            context,
                            match,
                          ),
                          onMore: () => _showMatchOptions(
                            context,
                            match,
                          ),
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
    required this.onMore,
  });

  final _MatchItem match;
  final VoidCallback onTap;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.045),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white10,
            ),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF4D8D)
                            .withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: ClipOval(
                      child: Image.network(
                        match.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF6C3FC8),
                                  Color(0xFFFF4D8D),
                                ],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              match.name.substring(0, 1),
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
                      right: 1,
                      bottom: 2,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF09070D),
                          border: Border.all(
                            color: const Color(0xFFFF4D8D),
                            width: 2,
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF4D8D),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${match.name}, ${match.age}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (match.isOnline) ...[
                          const SizedBox(width: 7),
                          Text(
                            'Online',
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFF4D8D),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      match.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    match.time,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (match.unreadCount > 0)
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 22,
                        minHeight: 22,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF4D8D),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${match.unreadCount}',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 4),

              IconButton(
                onPressed: onMore,
                tooltip: 'More',
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C3FC8)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C3FC8)
                : Colors.white10,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _EmptyMatchesState extends StatelessWidget {
  const _EmptyMatchesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6C3FC8)
                    .withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF4D8D)
                        .withValues(alpha: 0.12),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFFF4D8D),
                size: 38,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Your matches will appear here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Keep exploring and be open to a new connection.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                height: 1.5,
                color: Colors.white54,
              ),
            ),
          ],
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