import 'package:flutter/material.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:grademehard_app/screens/group_analysis_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupBuilderScreen extends StatefulWidget {
  const GroupBuilderScreen({super.key});

  @override
  State<GroupBuilderScreen> createState() => _GroupBuilderScreenState();
}

class _GroupBuilderScreenState extends State<GroupBuilderScreen> {
  List<Student?> _group = List.filled(5, null);

  void _addToGroup(Student student) {
    if (_group.contains(student)) return;
    final index = _group.indexWhere((s) => s == null);
    if (index != -1) {
      setState(() {
        _group[index] = student;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O grupo está cheio! Adicione mais vagas.'), duration: Duration(seconds: 1)),
      );
    }
  }

  void _removeFromGroup(int index) {
    setState(() {
      _group[index] = null;
    });
  }

  void _addSlot() {
    setState(() {
      _group.add(null);
    });
  }

  void _removeSlot() {
    final lastEmpty = _group.lastIndexWhere((s) => s == null);
    if (lastEmpty != -1) {
      setState(() {
        _group.removeAt(lastEmpty);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Remova um membro antes de diminuir o tamanho do grupo.'), duration: Duration(seconds: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupStudents = _group.whereType<Student>().toList();
    final isGroupFull = !_group.contains(null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- Grupo Section ---
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seu Grupo',
                style: GoogleFonts.cinzel(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _removeSlot,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove, color: Colors.white, size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${groupStudents.length}/${_group.length}',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _addSlot,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _group.length,
            itemBuilder: (context, index) {
              final student = _group[index];
              if (student == null) {
                return const _EmptySlotCard();
              }
              return _GroupMemberCard(
                student: student,
                onRemove: () => _removeFromGroup(index),
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Divider(),
        ),

        // --- Alunos Disponíveis ---
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text(
            'Alunos Disponíveis',
            style: GoogleFonts.cinzel(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              mainAxisExtent: 300,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: mockStudents.length,
            itemBuilder: (context, index) {
              final student = mockStudents[index];
              final isSelected = _group.contains(student);
              return _AvailableStudentCard(
                student: student,
                isSelected: isSelected,
                onTap: () => _addToGroup(student),
              );
            },
          ),
        ),

        // Botão Analisar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: theme.colorScheme.onSecondary,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            onPressed: groupStudents.isNotEmpty
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupAnalysisScreen(group: groupStudents),
                      ),
                    );
                  }
                : null,
            child: Text(
              'Analisar Grupo',
              style: GoogleFonts.cinzel(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _GroupMemberCard extends StatelessWidget {
  final Student student;
  final VoidCallback onRemove;

  const _GroupMemberCard({
    required this.student,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.colorScheme.secondary.withOpacity(0.5), width: 1.5),
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
                    student.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.person, size: 50, color: Colors.white54),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: SvgPicture.asset(
                      'assets/images/ranks/${student.rank}.svg',
                      width: 36,
                      height: 36,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.remove, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: theme.colorScheme.surface,
              child: Text(
                student.name,
                style: GoogleFonts.cinzel(fontSize: 13, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailableStudentCard extends StatelessWidget {
  final Student student;
  final bool isSelected;
  final VoidCallback onTap;

  const _AvailableStudentCard({
    required this.student,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: isSelected ? 0.4 : 1.0,
      child: GestureDetector(
        onTap: isSelected ? null : onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? theme.colorScheme.error.withOpacity(0.5)
                  : theme.colorScheme.secondary.withOpacity(0.3),
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
                      student.imageUrl,
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
                        'assets/images/ranks/${student.rank}.svg',
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
                            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                          ),
                        ),
                      ),
                    ),
                    if (!isSelected)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                      ),
                    if (isSelected)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 20),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                color: theme.colorScheme.surface,
                child: Text(
                  student.name,
                  style: GoogleFonts.cinzel(fontSize: 13, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySlotCard extends StatelessWidget {
  const _EmptySlotCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: theme.colorScheme.secondary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: const Radius.circular(20),
            color: theme.colorScheme.secondary.withOpacity(0.4),
            strokeWidth: 2,
            dashPattern: const [8, 4],
          ),
          child: const Center(
            child: Icon(Icons.add, color: Colors.white38, size: 40),
          ),
        ),
      ),
    );
  }
}
