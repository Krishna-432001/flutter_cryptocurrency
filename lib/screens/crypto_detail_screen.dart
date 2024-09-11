import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Use for local storage

class CryptoDetailScreen extends StatefulWidget {
  final Map<String, dynamic> cryptoData;

  CryptoDetailScreen({required this.cryptoData});

  @override
  _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
  double minedAmount = 0.0;
  bool isMining = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadMiningData();
    startMining();
  }

  Future<void> _loadMiningData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      minedAmount = prefs.getDouble('${widget.cryptoData['symbol']}_mined') ?? 0.0;
    });
  }

  void startMining() {
    isMining = true;
    Future.delayed(Duration(seconds: 1), mineCrypto);
  }

  void mineCrypto() {
    if (isMining) {
      setState(() {
        minedAmount += 0.01; // Increment mined amount by 0.01 every second
      });
      prefs.setDouble('${widget.cryptoData['symbol']}_mined', minedAmount);
      Future.delayed(Duration(seconds: 1), mineCrypto); // Keep mining
    }
  }

  @override
  void dispose() {
    isMining = false; // Stop mining when screen is disposed
    prefs.setDouble('${widget.cryptoData['symbol']}_mined', minedAmount); // Save data
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crypto = widget.cryptoData;
    return Scaffold(
      appBar: AppBar(
        title: Text("${crypto['name']} Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crypto Name and Symbol
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(crypto['image']),
                  radius: 30,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto['name'],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${crypto['symbol'].toUpperCase()}",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Crypto Details
            DetailRow(title: "Current Price", value: "\$${crypto['current_price'].toStringAsFixed(2)}"),
            DetailRow(title: "Market Cap", value: "\$${crypto['market_cap']}"),
            DetailRow(title: "Total Supply", value: "${crypto['total_supply']}"),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            // Mining Animation and Control
            Center(
              child: Column(
                children: [
                  Text(
                    "Mined Amount: ${minedAmount.toStringAsFixed(4)} ${crypto['symbol'].toUpperCase()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  isMining
                      ? CircularProgressIndicator()
                      : Icon(Icons.dining_outlined, size: 50, color: Colors.green),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isMining ? Colors.red : Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        isMining = !isMining;
                        if (isMining) {
                          startMining();
                        } else {
                          prefs.setDouble('${widget.cryptoData['symbol']}_mined', minedAmount); // Save data
                        }
                      });
                    },
                    child: Text(isMining ? "Stop Mining" : "Start Mining"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  DetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
