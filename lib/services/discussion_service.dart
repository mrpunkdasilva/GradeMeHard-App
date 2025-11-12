import 'package:grademehard_app/domain/discussion_post.dart';

class DiscussionService {
  // In-memory storage for discussion posts, keyed by student name
  final Map<String, List<DiscussionPost>> _posts = {};

  DiscussionService() {
    _populateMockData();
  }

  void _populateMockData() {
    // Mock data for Zaladria
    _posts['Zaladria'] = [
      DiscussionPost(
        authorName: 'Colega Curioso',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
        message: 'Alguém sabe como a Zaladria consegue ter tanta Magia do Excel? É impressionante!',
      ),
      DiscussionPost(
        authorName: 'Professor X',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
        message: 'A dedicação dela aos estudos arcanos é notável. Um exemplo a ser seguido.',
      ),
      DiscussionPost(
        authorName: 'Colega Anônimo',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        message: 'Verdade! Ela sempre tem a solução para os problemas mais complexos.',
      ),
      DiscussionPost(
        authorName: 'Você',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        message: 'Acho que o Deadline Drive dela é o segredo!',
      ),
    ];

    // Mock data for Jonas "O Coder Fantasma"
    _posts['Jonas "O Coder Fantasma"'] = [
      DiscussionPost(
        authorName: 'Colega Observador',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
        message: 'O Jonas é tão Saída à Francesa que às vezes esqueço que ele está no grupo. Mas o código dele aparece do nada e funciona!',
      ),
      DiscussionPost(
        authorName: 'Colega A',
        timestamp: DateTime.now().subtract(const Duration(hours: 10)),
        message: 'Sim! Ele é tipo um ninja do código. Nunca vejo ele trabalhando, mas as entregas são impecáveis.',
      ),
      DiscussionPost(
        authorName: 'Você',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        message: 'A Velocidade Alt+Tab dele deve ser absurda!',
      ),
    ];

    // Mock data for Beatriz "A Rainha do Debug"
    _posts['Beatriz "A Rainha do Debug"'] = [
      DiscussionPost(
        authorName: 'Colega Desesperado',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        message: 'A Beatriz salvou meu projeto ontem! Ela achou um bug que eu estava procurando há dias. Rainha mesmo!',
      ),
      DiscussionPost(
        authorName: 'Colega B',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        message: 'O QI de Debug dela é insano. Sempre que algo dá errado, é só chamar a Bia.',
      ),
      DiscussionPost(
        authorName: 'Colega C',
        timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
        message: 'E o Sangue de Café dela? Deve ser 100%!',
      ),
    ];

    // Mock data for Lucas "O Mago do CSS"
    _posts['Lucas "O Mago do CSS"'] = [
      DiscussionPost(
        authorName: 'Colega D',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        message: 'O Lucas é um mago do CSS, mas a Palestrinha dele às vezes me cansa.',
      ),
      DiscussionPost(
        authorName: 'Você',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        message: 'Acho que ele tem um Chute Certeiro para cores!',
      ),
    ];

    // Mock data for Mariana "A Lenda do Git"
    _posts['Mariana "A Lenda do Git"'] = [
      DiscussionPost(
        authorName: 'Colega E',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        message: 'A Mariana é a lenda do Git. Nunca vi ninguém com tanta Sorte no Merge!',
      ),
      DiscussionPost(
        authorName: 'Você',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        message: 'Ela tem uma Resistência à Prova incrível também!',
      ),
    ];
  }

  List<DiscussionPost> getPostsForStudent(String studentName) {
    return _posts[studentName] ?? [];
  }

  void addPost(String studentName, DiscussionPost post) {
    _posts.putIfAbsent(studentName, () => []).add(post);
  }
}