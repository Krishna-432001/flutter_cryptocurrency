import 'package:flutter/material.dart';
import '../services/crypto_service.dart'; // Import the CryptoService
import '../screens/home_screen.dart';

class CryptoProvider with ChangeNotifier {
  List<dynamic> _cryptoList = [];
  bool _isLoading = false;

  List<dynamic> get cryptoList => _cryptoList;
  bool get isLoading => _isLoading;

  Future<void> fetchCryptoData() async {
    _isLoading = true;
    notifyListeners();
    try {
      CryptoService cryptoService = CryptoService();
      _cryptoList = await cryptoService.getCryptoData();
    } catch (e) {
      print(e);
    }
    _isLoading = false;
    notifyListeners();
  }
}
