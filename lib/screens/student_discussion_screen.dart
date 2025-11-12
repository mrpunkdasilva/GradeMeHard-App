import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grademehard_app/domain/student.dart';
import 'package:grademehard_app/domain/discussion_post.dart';
import 'package:grademehard_app/services/discussion_service.dart';

class StudentDiscussionScreen extends StatefulWidget {
  final Student student;

  const StudentDiscussionScreen({super.key, required this.student});

  @override
  State<StudentDiscussionScreen> createState() => _StudentDiscussionScreenState();
}

class _StudentDiscussionScreenState extends State<StudentDiscussionScreen> {
  final DiscussionService _discussionService = DiscussionService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<DiscussionPost> _posts = [];
  String _currentUserName = 'Você'; // Default author name

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _promptForUserName();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadPosts() {
    setState(() {
      _posts = _discussionService.getPostsForStudent(widget.student.name);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
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

  void _addPost() {
    if (_messageController.text.trim().isEmpty) return;

    final newPost = DiscussionPost(
      authorName: _currentUserName,
      timestamp: DateTime.now(),
      message: _messageController.text.trim(),
    );

    _discussionService.addPost(widget.student.name, newPost);
    _messageController.clear();
    _loadPosts(); // Reload posts to show the new one and scroll
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final postDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (postDate.isAtSameMomentAs(today)) {
      return 'Hoje às ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (postDate.isAtSameMomentAs(today.subtract(const Duration(days: 1)))) {
      return 'Ontem às ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discussão sobre ${widget.student.name}',
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                final isMe = post.authorName == _currentUserName;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    color: isMe ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(0),
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isMe ? 'Você' : post.authorName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isMe ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            post.message,
                            style: TextStyle(
                              fontSize: 16,
                              color: isMe ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              _formatTimestamp(post.timestamp),
                              style: TextStyle(
                                fontSize: 10,
                                color: isMe ? theme.colorScheme.onPrimaryContainer.withOpacity(0.7) : theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Escreva sua mensagem...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _addPost,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}