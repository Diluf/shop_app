import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id, title, description, imageUrl;
  final double price;
  bool isFav;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFav = false,
  });

  void _setStatus(bool newValue) {
    isFav = newValue;
    notifyListeners();
  }

  void toggleFav(String token, String userId) async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    final url =
        'https://flutterdemo-28d11.firebaseio.com/userFavs/$userId/$id.json?auth=$token';

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFav,
        ),
      );

      if (response.statusCode >= 400) {
        _setStatus(oldStatus);
      }
    } catch (error) {
      _setStatus(oldStatus);
    }
  }
}
