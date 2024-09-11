import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Example for local storage

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Get SharedPreferences instance to check if the email already exists
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? registeredEmail = prefs.getString('email');

      // Check if the email already exists in the database (here, shared preferences)
      if (registeredEmail != null && registeredEmail == _emailController.text) {
        setState(() {
          _isLoading = false;
        });

        // Show an error message if the email is already registered
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already registered. Please use a different email.')),
        );
      } else {
        // If email is not registered, save new user data
        await prefs.setString('email', _emailController.text);
        await prefs.setString('password', _passwordController.text);

        setState(() {
          _isLoading = false;
        });

        // Navigate to the login page after successful registration
        Navigator.pushReplacementNamed(context, '/login');

        // Optional: Show a registration success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Crypto Mining Image
          Image.asset(
            "assets/crypto1.webp", // Ensure this is the correct path to your image
            fit: BoxFit.cover,
          ),
          // Transparent overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey, // Wrap form with the validation key
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo or Title
                    Hero(
                      tag: "appLogo",
                      child: Text(
                        "Crypto Miner",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    // Email input field
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Add more robust email validation if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Password input field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    // Register Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () {
                        _registerUser(); // Call the registration logic
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
