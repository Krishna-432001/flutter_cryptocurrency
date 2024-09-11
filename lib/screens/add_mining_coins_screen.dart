import 'package:flutter/material.dart';

import '../helpers/database_helper.dart';


class AddMiningCoinsScreen extends StatefulWidget {
  @override
  _AddMiningCoinsScreenState createState() => _AddMiningCoinsScreenState();
}

class _AddMiningCoinsScreenState extends State<AddMiningCoinsScreen> {
  final _amountController = TextEditingController();
  String _selectedCoin = 'BTC';

  void _addMinedCoin() async {
    final dbHelper = DatabaseHelper.instance;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    Map<String, dynamic> row = {
      DatabaseHelper.columnCoin: _selectedCoin,
      DatabaseHelper.columnAmount: amount,
    };
    await dbHelper.insert(row);
    // Optionally, update the UI or show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mined coin added to database')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Mined Coins")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            DropdownButton<String>(
              value: _selectedCoin,
              items: ['BTC', 'ETH'].map((coin) {
                return DropdownMenuItem<String>(
                  value: coin,
                  child: Text(coin),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCoin = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMinedCoin,
              child: Text("Add to Database"),
            ),
          ],
        ),
      ),
    );
  }
}
