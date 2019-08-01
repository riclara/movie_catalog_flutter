import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_catalog_flutter/src/model/pelicula_model.dart';

class MoviesProvider {
  String _apiKey = '94b5e770a1ae509e295751de75292e39';
  String _url  = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> nowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}