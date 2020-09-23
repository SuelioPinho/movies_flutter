import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:movies_flutter/src/pages/home_page.dart';
import 'package:movies_flutter/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'movie_detail': (BuildContext context) => MovieDetail()
      },
    );
  }
}
