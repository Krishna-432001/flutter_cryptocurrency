import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // App Description
            Text(
              "About Crypto Miner",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Crypto Miner is an innovative application that allows you to mine and track various cryptocurrencies in real-time. With advanced features for monitoring your mining performance and managing your wallet, it provides a seamless experience for cryptocurrency enthusiasts.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Features
            Text(
              "Features",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Real-time cryptocurrency tracking"),
            BulletPoint(text: "Mining performance analytics"),
            BulletPoint(text: "Secure wallet management"),
            BulletPoint(text: "Customizable notifications"),
            SizedBox(height: 16),

            // Team
            Text(
              "Team",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Our team is dedicated to bringing you the best cryptocurrency mining experience. Our developers, designers, and support staff work tirelessly to ensure a seamless and user-friendly application.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Contact Information
            Text(
              "Contact Us",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "For support or inquiries, please contact us at:\n"
                  "Email: support@cryptominerapp.com\n"
                  "Phone: +123-456-7890",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Version Information
            Text(
              "Version Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Version 1.0.0\n"
                  "©2024 Crypto Miner. All rights reserved.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Legal Information
            Text(
              "Legal Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "By using this app, you agree to our Terms of Service and Privacy Policy. Please review them for more information.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 8, color: Colors.black),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
