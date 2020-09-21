import 'dart:convert';

import 'package:movies_flutter/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = '25552f96112da43fcd2cbecae967626b';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> getMoviesNoPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodeData['results']);

    print(movies);

    return movies.items;
  }
}
