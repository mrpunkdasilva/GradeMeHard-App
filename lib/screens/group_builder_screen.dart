import 'package:flutter/material.dart';
import 'package:grademehard_app/mock_data.dart';
import 'package:grademehard_app/student.dart';
import 'package:grademehard_app/widgets/student_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupBuilderScreen extends StatefulWidget {
  const GroupBuilderScreen({super.key});

  @override
  State<GroupBuilderScreen> createState() => _GroupBuilderScreenState();
}

class _GroupBuilderScreenState extends State<GroupBuilderScreen> {
  // Using a list of nullable Students to represent the 5 slots in the group
  final List<Student?> _group = List.filled(5, null);

  void _onStudentTapped(Student student) {
    setState(() {
      // Check if the student is already in the group
      if (_group.contains(student)) {
        // Optional: show a snackbar or message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${student.name} já está no grupo.'),
            duration: const Duration(seconds: 1),
          ),
        );
        return;
      }

      // Find the first empty slot
      final index = _group.indexWhere((s) => s == null);
      if (index != -1) {
        _group[index] = student;
      } else {
        // Optional: show a message that the group is full
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('O grupo está cheio!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  void _onGroupStudentTapped(int index) {
    setState(() {
      _group[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Montar Grupo', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Panel: The selected group
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Seu Grupo',
              style: GoogleFonts.cinzel(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 150, // Adjusted height for the group panel
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.65,
              ),
              itemCount: _group.length,
              itemBuilder: (context, index) {
                final student = _group[index];
                if (student == null) {
                  return const _EmptySlotCard();
                }
                return StudentCard(
                  student: student,
                  onTap: () => _onGroupStudentTapped(index),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(),
          ),

          // Bottom Panel: The available students gallery
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Alunos Disponíveis',
              style: GoogleFonts.cinzel(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // More cards, smaller
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.65,
              ),
              itemCount: mockStudents.length,
              itemBuilder: (context, index) {
                final student = mockStudents[index];
                final isSelected = _group.contains(student);
                return Opacity(
                  opacity: isSelected ? 0.5 : 1.0,
                  child: StudentCard(
                    student: student,
                    onTap: () => _onStudentTapped(student),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySlotCard extends StatelessWidget {
  const _EmptySlotCard();

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(15),
        color: Colors.white.withOpacity(0.4),
        strokeWidth: 2,
        dashPattern: const [8, 4],
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.white54,
          size: 40,
        ),
      ),
    );
  }
}
