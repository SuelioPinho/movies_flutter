import 'dart:convert';

import 'package:movies_flutter/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = '25552f96112da43fcd2cbecae967626b';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularPage = 0;

  Future<List<Movie>> _fetchMovies(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Movies.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Movie>> getMoviesNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await _fetchMovies(url);
  }

  Future<List<Movie>> getMoviesPopular() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apikey, 'language': _language});

    return await _fetchMovies(url);
  }
}
