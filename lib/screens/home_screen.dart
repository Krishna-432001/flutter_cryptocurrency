import 'package:cryptocurrency/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/crypto_provider.dart';
import 'crypto_detail_screen.dart';
import 'profile_screen.dart';

import 'wallet_screen.dart';
import 'about_screen.dart';

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
              onTap: () {
                // Add logout logic here
              },
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
                  // Navigate to the detail screen when clicked
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
