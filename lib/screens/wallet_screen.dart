import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 0.0; // Example balance
  Map<String, double> _minedCoins = {}; // Map to store mined coins data

  @override
  void initState() {
    super.initState();
    _setSampleData(); // Optional: Remove if data is already set
    _loadMinedCoins();
  }

  Future<void> _setSampleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('mined_BTC', 0.5); // Example mined BTC
    await prefs.setDouble('mined_ETH', 1.0); // Example mined ETH
  }

  Future<void> _loadMinedCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _minedCoins = {
        'BTC': prefs.getDouble('mined_BTC') ?? 0.0,
        'ETH': prefs.getDouble('mined_ETH') ?? 0.0,
        // Add other coins as needed
      };
      print("Mined Coins: $_minedCoins"); // Debug print
    });
  }

  void _deposit(double amount) {
    setState(() {
      _balance += amount;
    });
  }

  void _withdraw(double amount) {
    if (_balance >= amount) {
      setState(() {
        _balance -= amount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wallet")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Balance
            Text(
              "Wallet Balance",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "\$${_balance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Deposit and Withdraw Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showTransactionDialog(context, 'Deposit');
                  },
                  child: Text("Deposit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showTransactionDialog(context, 'Withdraw');
                  },
                  child: Text("Withdraw"),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Mined Coins Header
            Text(
              "Mined Coins",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Mined Coins List
            Expanded(
              child: ListView.builder(
                itemCount: _minedCoins.length,
                itemBuilder: (context, index) {
                  final coin = _minedCoins.keys.elementAt(index);
                  final amount = _minedCoins[coin]!;
                  return ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: Colors.blue,
                    ),
                    title: Text(coin),
                    trailing: Text(
                      "${amount.toStringAsFixed(4)} coins",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDialog(BuildContext context, String type) {
    final _amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("$type Amount"),
        content: TextField(
          controller: _amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: "Amount",
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              if (amount > 0) {
                if (type == 'Deposit') {
                  _deposit(amount);
                } else if (type == 'Withdraw') {
                  _withdraw(amount);
                }
                Navigator.of(context).pop();
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
