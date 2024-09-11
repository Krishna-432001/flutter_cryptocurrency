import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import profile screen
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    Navigator.pushReplacementNamed(context, '/login'); // Navigate to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Account Settings"),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text("Notification Settings"),
            leading: Icon(Icons.notifications),
            trailing: Switch(
              value: true, // You can change this value based on actual notification settings
              onChanged: (value) {
                // Handle switch toggle
              },
            ),
          ),
          ListTile(
            title: Text("Theme Settings"),
            leading: Icon(Icons.brightness_6),
            trailing: Switch(
              value: false, // You can change this value based on actual theme settings
              onChanged: (value) {
                // Handle theme change
              },
            ),
          ),
          ListTile(
            title: Text("Security Settings"),
            leading: Icon(Icons.lock),
            onTap: () {
              // Navigate to security settings screen
            },
          ),
          ListTile(
            title: Text("App Info"),
            leading: Icon(Icons.info),
            onTap: () {
              // Show app version and legal info
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("App Info"),
                  content: Text("Version 1.0.0\n©2024 CryptoApp"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
