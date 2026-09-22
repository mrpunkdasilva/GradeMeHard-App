import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _currentUser;
  String? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString('loggedInUser');
  }

  Future<bool> signup(String name, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];

    final alreadyExists = users.any((u) => u.split('|')[0].toLowerCase() == name.toLowerCase());
    if (alreadyExists) return false;

    users.add('$name|$password');
    await prefs.setStringList('users', users);
    await _loginUser(name);
    return true;
  }

  Future<bool> login(String name, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];

    final user = users.where((u) {
      final parts = u.split('|');
      return parts[0].toLowerCase() == name.toLowerCase() && parts[1] == password;
    });

    if (user.isEmpty) return false;

    await _loginUser(name);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
    _currentUser = null;
  }

  Future<void> _loginUser(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', name);
    _currentUser = name;
  }
}
