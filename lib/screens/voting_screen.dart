import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/domain/vote.dart';
import 'package:grademehard_app/services/voting_service.dart';

import 'package:grademehard_app/screens/attribute_voting_screen.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String _currentUserName = 'Você'; // Default author name

  @override
  void initState() {
    super.initState();
    _promptForUserName();
  }

  void _promptForUserName() async {
    // Only prompt if the name is still the default
    if (_currentUserName == 'Você') {
      final String? name = await showDialog<String>(
        context: context,
        barrierDismissible: false, // User must enter a name
        builder: (BuildContext context) {
          final TextEditingController nameController = TextEditingController();
          return AlertDialog(
            title: const Text('Qual é o seu nome?'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Seu nome'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  Navigator.of(context).pop(nameController.text.trim());
                },
              ),
            ],
          );
        },
      );

      if (name != null && name.isNotEmpty) {
        setState(() {
          _currentUserName = name;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final students = mockStudents;

    return Scaffold(
      appBar: AppBar(
        title: Text('Votação da Turma', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(student.imageUrl),
              ),
              title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Score: ${student.totalScore}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttributeVotingScreen(
                        student: student,
                        voterName: _currentUserName,
                      ),
                    ),
                  );
                },
                child: const Text('Votar'),
              ),
            ),
          );
        },
      ),
    );
  }
}
