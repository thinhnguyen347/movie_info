import 'dart:convert' as convert;

import 'package:movie_slide/models/cast_model.dart';
import 'package:http/http.dart' as http;

Future<List<Cast>> getCastList({required id}) async {
  List<Cast> castList = [];
  var urlCast =
      'https://api.themoviedb.org/3/movie/$id/credits?api_key=9bb89316d8693b06d7a84980b29c011f&language=vi-VN';

  var response = await http.get(Uri.parse(urlCast));

  if (response.statusCode == 200) {
    var body = convert.jsonDecode(response.body) as Map;
    for (int i = 0; i < body["cast"].length; i++) {
      var cast = Cast.fromJson(body["cast"][i]);
      castList.add(cast);
    }
  }

  return castList;
}
