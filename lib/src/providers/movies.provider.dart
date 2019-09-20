import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_catalog_flutter/src/model/actor.model.dart';
import 'package:movie_catalog_flutter/src/model/movie_model.dart';

class MoviesProvider {
  String _apiKey = '94b5e770a1ae509e295751de75292e39';
  String _url  = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  List<Movie> _populares = new List<Movie>();
  bool _loading = false;

  final _popularesStream = StreamController<List<Movie>>.broadcast();

  void disposeStreams() {
    _popularesStream?.close();
  }

  Function(List<Movie>) get popularesSink => _popularesStream.sink.add;

  Stream<List<Movie>> get popularesStream => _popularesStream.stream;

  Future<List<Movie>> _request(Uri uri) async {
    final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> nowPlaying () async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });
    return await _request(url);
  }

  Future<List<Movie>> getPopulares () async {
    if (_loading) return [];
    _loading = true;

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _request(url);
    _populares.addAll(resp);
    popularesSink(_populares);

    _loading = false;
    return resp;
  }

  Future<List<Actor>> getCast (int movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actors;

  }
}
