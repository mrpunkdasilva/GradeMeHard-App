import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/screens/attribute_voting_screen.dart';
import 'package:grademehard_app/screens/ranking_screen.dart';
import 'package:grademehard_app/screens/group_builder_screen.dart';
import 'package:grademehard_app/screens/attributes_screen.dart';
import 'package:grademehard_app/screens/ranks_explained_screen.dart';
import 'package:grademehard_app/services/auth_service.dart';
import 'package:grademehard_app/services/voting_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _students = List.from(mockStudents);
    _auth.init();
  }

  void _showLoginDialog(Student student) {
    final nameController = TextEditingController();
    final passController = TextEditingController();
    bool isSignup = false;
    bool obscurePass = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      isSignup ? 'Criar Conta' : 'Entrar para Votar',
                      style: GoogleFonts.cinzel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Faça login para votar em ${student.name}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(ctx).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Seu nome',
                        prefixIcon: const Icon(Icons.person_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passController,
                      obscureText: obscurePass,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(obscurePass ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setModalState(() => obscurePass = !obscurePass),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final name = nameController.text.trim();
                          final pass = passController.text.trim();
                          if (name.isEmpty || pass.isEmpty) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(content: Text('Preencha todos os campos'), backgroundColor: Colors.red),
                            );
                            return;
                          }

                          bool success;
                          if (isSignup) {
                            success = await _auth.signup(name, pass);
                            if (!success && mounted) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                const SnackBar(content: Text('Nome já cadastrado'), backgroundColor: Colors.red),
                              );
                              return;
                            }
                          } else {
                            success = await _auth.login(name, pass);
                            if (!success && mounted) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                const SnackBar(content: Text('Nome ou senha incorretos'), backgroundColor: Colors.red),
                              );
                              return;
                            }
                          }

                          if (mounted) {
                            Navigator.pop(ctx);
                            _vote(student);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(ctx).colorScheme.secondary,
                          foregroundColor: Theme.of(ctx).colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          isSignup ? 'Criar Conta e Votar' : 'Entrar e Votar',
                          style: GoogleFonts.cinzel(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => setModalState(() => isSignup = !isSignup),
                      child: Text(
                        isSignup ? 'Já tem conta? Entrar' : 'Não tem conta? Criar conta',
                        style: TextStyle(
                          color: Theme.of(ctx).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _vote(Student student) async {
    final voterName = _auth.currentUser ?? 'Votante';
    final votedStudentName = await Navigator.push<String>(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AttributeVotingScreen(
          student: student,
          voterName: voterName,
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
            _auth.isLoggedIn
                ? 'Olá, ${_auth.currentUser}! Toque para votar'
                : 'Toque em um aluno e faça login para votar',
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
                onTap: () {
                  if (_auth.isLoggedIn) {
                    _vote(student);
                  } else {
                    _showLoginDialog(student);
                  }
                },
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
          if (_auth.isLoggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    await _auth.logout();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 16, color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 6),
                        Text(
                          _auth.currentUser!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.logout, size: 14, color: Colors.white54),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Glossário',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AttributesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: 'Guia de Ranks',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RanksExplainedScreen()),
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              SvgPicture.asset(
                'assets/images/card.svg',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.student.name,
                        style: GoogleFonts.cinzel(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            const Shadow(blurRadius: 4, color: Colors.black),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/ranks/${widget.student.rank}.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Score: ${widget.student.totalScore}',
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...widget.student.effectiveAttributes.entries.take(5).map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (entry.value / 20).clamp(0.0, 1.0),
                                  backgroundColor: Colors.white24,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.secondary,
                                  ),
                                  minHeight: 4,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${entry.value}',
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
