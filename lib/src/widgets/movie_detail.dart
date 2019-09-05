import 'package:flutter/material.dart';
import 'package:movie_catalog_flutter/src/model/actor.model.dart';
import 'package:movie_catalog_flutter/src/model/pelicula_model.dart';
import 'package:movie_catalog_flutter/src/providers/movies.provider.dart';
import 'package:movie_catalog_flutter/src/providers/movies.provider.dart' as prefix0;

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0 ),
                _posterTitle( context, movie ),
                _description( movie ),
                _createCasting( movie )
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _createAppBar(Movie movie){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage.assetNetwork(
          placeholder: 'assets/img/loading.gif',
          image:movie.geBackgroundImg(),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 1000),
        )
      ),
    );
  }

  Widget _posterTitle (BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text( movie.voteAverage.toString() )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description (Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 20.0 ),
      child: Text( 
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCasting(Movie movie) {
    final moviesProvider = MoviesProvider();

    return FutureBuilder<List<Actor>>(
      future: moviesProvider.getCast(movie.id),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if(snapshot.hasData){
          return _createActorPageView( snapshot.data );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );


  }

  Widget _createActorPageView(List<Actor> data) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: data.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemBuilder: (context, i) {
          return _actorCard(data[i]);
        },
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: actor.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(actor.getFoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 145.0,
              ),
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

}