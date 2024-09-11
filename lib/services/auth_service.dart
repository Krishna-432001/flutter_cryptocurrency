import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString(username);
    if (storedPassword == password) {
      return true; // Login successful
    }
    return false; // Login failed
  }

  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(username) == null) {
      await prefs.setString(username, password); // Register new user
      return true;
    }
    return false; // Username already exists
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
  }

  Future<void> setLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
  }
}
