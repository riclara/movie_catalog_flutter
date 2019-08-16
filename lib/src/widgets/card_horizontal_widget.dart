import 'package:flutter/material.dart';
import 'package:movie_catalog_flutter/src/model/pelicula_model.dart';

class CardHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3);
  final Function nextPage;

  CardHorizontal({ @required this.movies, @required this.nextPage });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });
    
    return Container(
      child: Container(
        height: _screenSize.height * 0.25,
        child: PageView(
          pageSnapping: false,
          controller: _pageController,
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