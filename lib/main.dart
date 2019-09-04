import 'package:flutter/material.dart';
import 'package:movie_catalog_flutter/src/pages/home_page.dart';
import 'package:movie_catalog_flutter/src/widgets/movie_detail.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}