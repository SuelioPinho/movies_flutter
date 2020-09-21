import 'package:flutter/material.dart';
import 'package:movies_flutter/src/providers/movies_provider.dart';
import 'package:movies_flutter/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
          children: [
            _cardsSwiper(),
          ],
        ),
      ),
    );
  }

  Widget _cardsSwiper() {
    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getMoviesNoPlaying(),
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
}
