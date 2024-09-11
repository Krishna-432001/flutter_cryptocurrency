import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // To pick images
import 'package:shared_preferences/shared_preferences.dart'; // To store email
import 'dart:io'; // For File operations

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

  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    // Set the email in the controller
    _emailController.text = email;

    // Optionally load other profile data if saved in SharedPreferences or a database
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final gender = _genderController.text;
    final extraDetail = _extraDetailController.text;

    // Add your database save logic here (e.g., update profile in a database or state management)
    // Example placeholder code
    print("Saving profile to database...");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar section
            Center(
              child: Stack(
                children: [
                  _avatarImage == null
                      ? CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  )
                      : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_avatarImage!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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
}
