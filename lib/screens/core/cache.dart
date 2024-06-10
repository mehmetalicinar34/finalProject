import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';

class CacheSystem {
  Future<Map<String, dynamic>> getSplashConfig() async {
    Map<String, dynamic> data =
        await loadJsonFromAssets("assets/static/splash.json");
    return data;
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
