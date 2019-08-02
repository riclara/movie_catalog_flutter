import 'package:flutter/material.dart';
import 'package:movie_catalog_flutter/src/model/pelicula_model.dart';
import 'package:movie_catalog_flutter/src/providers/movies.provider.dart';
import 'package:movie_catalog_flutter/src/widgets/card_horizontal_widget.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _foter(context)
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
          child: CircularProgressIndicator()
        );
      },
    );
    
  }

  Widget _foter(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,),
          ),
          FutureBuilder(
            future: _moviesProvider.getPopulares(),
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if(snapshot.hasData) return CardHorizontal(movies: snapshot.data);
              return Container(
                child: Center(child: CircularProgressIndicator())
              );
            },
          ),
        ],
      ),
    );
  }
}