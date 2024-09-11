import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiningHistoryScreen extends StatefulWidget {
  @override
  _MiningHistoryScreenState createState() => _MiningHistoryScreenState();
}

class _MiningHistoryScreenState extends State<MiningHistoryScreen> {
  Map<String, double> minedData = {};

  @override
  void initState() {
    super.initState();
    _loadMiningData();
  }

  Future<void> _loadMiningData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      minedData = {
        'BTC': prefs.getDouble('BTC_mined') ?? 0.0,
        'ETH': prefs.getDouble('ETH_mined') ?? 0.0,
        // Add more cryptocurrencies as needed
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mining History"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: minedData.keys.length,
        itemBuilder: (context, index) {
          final key = minedData.keys.elementAt(index);
          final value = minedData[key];
          return ListTile(
            title: Text('$key'),
            subtitle: Text('Mined Amount: ${value?.toStringAsFixed(4)}'),
          );
        },
      ),
    );
  }
}
