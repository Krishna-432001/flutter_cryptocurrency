import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // For local database
import 'package:path/path.dart'; // For database path

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 0.0;
  List<Map<String, dynamic>> _transactions = [];
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _fetchData();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'wallet_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, amount REAL, date TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _fetchData() async {
    // Fetch balance and transaction history from database
    final List<Map<String, dynamic>> transactions = await _database!.query('transactions');
    setState(() {
      _transactions = transactions;
      _balance = transactions.fold(0.0, (sum, transaction) {
        return transaction['type'] == 'Deposit' ? sum + transaction['amount'] : sum - transaction['amount'];
      });
    });
  }

  Future<void> _deposit(double amount) async {
    // Insert deposit transaction into the database
    await _database!.insert(
      'transactions',
      {'type': 'Deposit', 'amount': amount, 'date': DateTime.now().toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _fetchData(); // Refresh data
  }

  Future<void> _withdraw(double amount) async {
    // Insert withdrawal transaction into the database
    await _database!.insert(
      'transactions',
      {'type': 'Withdraw', 'amount': amount, 'date': DateTime.now().toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _fetchData(); // Refresh data
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
                  onPressed: () => _showTransactionDialog(context, 'Deposit'),
                  child: Text("Deposit"),
                ),
                ElevatedButton(
                  onPressed: () => _showTransactionDialog(context, 'Withdraw'),
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

  void _showTransactionDialog(BuildContext context, String type) {
    final _amountController = TextEditingController();
    showDialog(
      context: context,  // Ensure this is BuildContext
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
