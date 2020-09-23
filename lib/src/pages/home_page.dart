import 'package:flutter/material.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';
import 'package:movies_flutter/src/widgets/card_swiper_widget.dart';
import 'package:movies_flutter/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies in theaters'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          children: [_cardsSwiper(), _footer(context)],
        ),
      ),
    );
  }

  Widget _cardsSwiper() {
    return FutureBuilder(
      future: moviesProvider.getMoviesNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0),
          FutureBuilder(
              future: moviesProvider.getMoviesPopular(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(movies: snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
          // StreamBuilder(
          //   stream: movi.popularesStream,
          //   builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          //     if (snapshot.hasData) {
          //       return MovieHorizontal(
          //         movies: snapshot.data,
          //         nextPage: moviesProvider.getMoviesPopular(),
          //       );
          //     } else {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
