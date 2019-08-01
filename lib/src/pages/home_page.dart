import 'package:flutter/material.dart';
import 'package:movie_catalog_flutter/src/providers/movies.provider.dart';
import 'package:movie_catalog_flutter/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cartelera'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards()
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: _moviesProvider.nowPlaying(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) return CardSwiper( elements: snapshot.data, );
        return Container(
          height: 400.0,
          child: CircularProgressIndicator()
        );
      },
    );
    
  }
}