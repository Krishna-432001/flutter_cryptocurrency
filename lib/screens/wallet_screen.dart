import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 0.0; // Example balance
  List<Map<String, String>> _transactions = [
    {"type": "Deposit", "amount": "100.00", "date": "2024-09-01"},
    {"type": "Withdraw", "amount": "50.00", "date": "2024-09-02"},
    // Add more transactions as needed
  ];

  void _deposit() {
    // Implement deposit logic
  }

  void _withdraw() {
    // Implement withdraw logic
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
                  onPressed: _deposit,
                  child: Text("Deposit"),
                ),
                ElevatedButton(
                  onPressed: _withdraw,
                  child: Text("Withdraw"),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Transaction History
            Text(
              "Transaction History",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return ListTile(
                    leading: Icon(
                      transaction["type"] == "Deposit"
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction["type"] == "Deposit"
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(transaction["type"]!),
                    subtitle: Text(transaction["date"]!),
                    trailing: Text(
                      "\$${transaction["amount"]!}",
                      style: TextStyle(
                        color: transaction["type"] == "Deposit"
                            ? Colors.green
                            : Colors.red,
                      ),
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
}
