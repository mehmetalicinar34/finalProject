import 'package:dio/dio.dart';

import '../models/translation.dart';
class API {
  final dio = Dio();


  Future<List<Translation>> cevir(String word) async {
    Response response =
        await dio.get('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

    List<Translation> ceviriler = [];

    (response.data as List).forEach((element) {
      ceviriler.add(Translation.fromJson(element));
    });

    return ceviriler;
  }

}
