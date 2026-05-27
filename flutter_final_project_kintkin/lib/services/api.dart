import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "";

  static addEvent(Map data) async {
    try {
      final res = await http.post(Uri.parse("uri"), body: data);

      if(res.statusCode == 200) {

      } else {

      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
