import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/data/mock_data.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/screens/attribute_voting_screen.dart';
import 'package:grademehard_app/widgets/voting_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  final CardSwiperController _controller = CardSwiperController();
  String _currentUserName = 'Você';
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _students = List.from(mockStudents);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserNameAndPrompt();
    });
  }

  Future<void> _loadUserNameAndPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('userName');
    if (savedName != null && savedName.isNotEmpty) {
      setState(() {
        _currentUserName = savedName;
      });
    } else {
      _promptForUserName();
    }
  }

  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  void _promptForUserName() async {
    final String? name = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController();
        return AlertDialog(
          title: const Text('Qual é o seu nome?'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Seu nome'),
            autofocus: true,
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
      await _saveUserName(name);
    }
  }

  Future<void> _vote(int index) async {
    final student = _students[index];
    final votedStudentName = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => AttributeVotingScreen(
          student: student,
          voterName: _currentUserName,
        ),
      ),
    );

    if (votedStudentName != null) {
      setState(() {
        _students.removeWhere((s) => s.name == votedStudentName);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Voto para $votedStudentName registrado!'),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Votação da Turma', style: GoogleFonts.cinzel()),
        centerTitle: true,
      ),
      body: _students.isEmpty
          ? Center(
              child: Text(
                'Fim da Votação!',
                style: GoogleFonts.cinzel(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deslize para a direita para votar ou para a esquerda para pular.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: CardSwiper(
                      controller: _controller,
                      cardsCount: _students.length,
                      onSwipe: (prevIndex, currentIndex, direction) {
                        if (direction == CardSwiperDirection.right) {
                          _vote(prevIndex);
                        }
                        return true;
                      },
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        return VotingCard(student: _students[index]);
                      },
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () => _controller.swipe(CardSwiperDirection.left),
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.close),
                      ),
                      FloatingActionButton.large(
                        onPressed: () => _controller.swipe(CardSwiperDirection.right),
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.check, size: 40),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
