import 'package:cryptocurrency/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/crypto_provider.dart';
import 'crypto_detail_screen.dart';
import 'profile_screen.dart';
import 'wallet_screen.dart';
import 'about_screen.dart';
import 'login_screen.dart'; // Import your LoginScreen here

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CryptoProvider>(context, listen: false).fetchCryptoData();
  }

  Future<void> _logout() async {
    // Clear authentication tokens or user data
    // Assuming you are using SharedPreferences for storing user tokens
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken'); // Replace 'authToken' with your token key

    // Navigate to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cryptocurrency Prices"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Wallet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen()),
                );
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Consumer<CryptoProvider>(
        builder: (context, cryptoProvider, child) {
          if (cryptoProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: cryptoProvider.cryptoList.length,
            itemBuilder: (context, index) {
              final crypto = cryptoProvider.cryptoList[index];
              return ListTile(
                leading: Image.network(crypto['image'], height: 40),
                title: Text(crypto['name']),
                subtitle: Text(crypto['symbol'].toUpperCase()),
                trailing: Text("\$${crypto['current_price'].toStringAsFixed(2)}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CryptoDetailScreen(cryptoData: crypto),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
