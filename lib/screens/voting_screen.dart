import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/screens/attribute_voting_screen.dart';
import 'package:grademehard_app/screens/ranking_screen.dart';
import 'package:grademehard_app/screens/group_builder_screen.dart';
import 'package:grademehard_app/screens/attributes_screen.dart';
import 'package:grademehard_app/screens/ranks_explained_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  int _currentIndex = 0;
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _students = List.from(mockStudents);
  }

  Future<void> _vote(Student student) async {
    final votedStudentName = await Navigator.push<String>(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AttributeVotingScreen(
          student: student,
          voterName: 'Votante',
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );

    if (votedStudentName != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Voto para $votedStudentName registrado!'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    }
  }

  Widget _buildVotacaoTab() {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Toque em um aluno para votar',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              mainAxisExtent: 320,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: _students.length,
            itemBuilder: (context, index) {
              final student = _students[index];
              return _AnimatedVoteCard(
                index: index,
                student: student,
                onTap: () => _vote(student),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildVotacaoTab(),
      const RankingBody(),
      const GroupBuilderScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Grade Me Hard', style: GoogleFonts.cinzel()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Glossário',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AttributesScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: 'Guia de Ranks',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RanksExplainedScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.how_to_vote_outlined),
            selectedIcon: Icon(Icons.how_to_vote),
            label: 'Votar',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_add_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Grupo',
          ),
        ],
      ),
    );
  }
}

class _AnimatedVoteCard extends StatefulWidget {
  final int index;
  final Student student;
  final VoidCallback onTap;

  const _AnimatedVoteCard({
    required this.index,
    required this.student,
    required this.onTap,
  });

  @override
  State<_AnimatedVoteCard> createState() => _AnimatedVoteCardState();
}

class _AnimatedVoteCardState extends State<_AnimatedVoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Staggered entrance based on index
    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: theme.colorScheme.secondary.withOpacity(0.4),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.student.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.person, size: 60, color: Colors.white54),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        'assets/images/ranks/${widget.student.rank}.svg',
                        width: 44,
                        height: 44,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                color: theme.colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.student.name,
                      style: GoogleFonts.cinzel(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/ranks/${widget.student.rank}.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Score: ${widget.student.totalScore}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
