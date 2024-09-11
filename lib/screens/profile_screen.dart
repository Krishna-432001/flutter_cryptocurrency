import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _extraDetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text("Phone Number", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter your phone number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text("Gender", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                hintText: "Enter your gender",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text("Extra Detail", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _extraDetailController,
              decoration: InputDecoration(
                hintText: "Enter extra profile detail",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    // Validate and save profile details
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final gender = _genderController.text;
    final extraDetail = _extraDetailController.text;

    // Add your save logic here (e.g., update profile in a database or state management)

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Profile Saved"),
        content: Text("Name: $name\nPhone: $phone\nEmail: $email\nGender: $gender\nExtra Detail: $extraDetail"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
