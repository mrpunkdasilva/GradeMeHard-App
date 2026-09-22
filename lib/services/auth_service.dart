import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _currentUser;
  String? _currentEmail;
  String? get currentUser => _currentUser;
  String? get currentEmail => _currentEmail;
  bool get isLoggedIn => _currentUser != null;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString('loggedInUser');
    _currentEmail = prefs.getString('loggedInEmail');
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> signup(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];

    final alreadyExists = users.any((u) {
      final parts = u.split('|');
      return parts[0].toLowerCase() == name.toLowerCase() ||
          parts[1].toLowerCase() == email.toLowerCase();
    });
    if (alreadyExists) return false;

    final hashedPassword = _hashPassword(password);
    users.add('$name|$email|$hashedPassword');
    await prefs.setStringList('users', users);
    await _loginUser(name, email);
    return true;
  }

  Future<bool> login(String nameOrEmail, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];

    final hashedPassword = _hashPassword(password);

    final user = users.where((u) {
      final parts = u.split('|');
      final matchName = parts[0].toLowerCase() == nameOrEmail.toLowerCase();
      final matchEmail = parts[1].toLowerCase() == nameOrEmail.toLowerCase();
      final matchPass = parts[2] == hashedPassword;
      return (matchName || matchEmail) && matchPass;
    });

    if (user.isEmpty) return false;

    final parts = user.first.split('|');
    await _loginUser(parts[0], parts[1]);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
    await prefs.remove('loggedInEmail');
    _currentUser = null;
    _currentEmail = null;
  }

  Future<void> _loginUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', name);
    await prefs.setString('loggedInEmail', email);
    _currentUser = name;
    _currentEmail = email;
  }
}
