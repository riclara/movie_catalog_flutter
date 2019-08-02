import 'package:flutter/material.dart';
import 'package:movie_catalog_flutter/src/model/pelicula_model.dart';

class CardHorizontal extends StatelessWidget {
  final List<Movie> movies;

  CardHorizontal({ this.movies });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      child: Container(
        height: _screenSize.height * 0.2,
        child: PageView(
          pageSnapping: false,
          controller: PageController(
            initialPage: 1,
            viewportFraction: 0.3,
          ),
          children: _cards(context),
        ),
      ),
    );
  }

  List<Widget> _cards(context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}