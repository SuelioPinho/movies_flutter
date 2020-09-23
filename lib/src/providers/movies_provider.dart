import 'dart:async';
import 'dart:convert';

import 'package:movies_flutter/src/models/actor_model.dart';
import 'package:movies_flutter/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = '25552f96112da43fcd2cbecae967626b';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  bool _loading = false;

  List<Movie> _popularMovies = new List();

  int _popularPage = 0;

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _fetchMovies(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getMoviesNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await _fetchMovies(url);
  }

  Future<List<Movie>> getMoviesPopular() async {
    if (_loading) return [];

    _loading = true;

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final resp = await _fetchMovies(url);

    _popularMovies.addAll(resp);
    popularSink(_popularMovies);

    _loading = false;

    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apikey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await _fetchMovies(url);
  }
}
