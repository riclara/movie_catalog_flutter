import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_catalog_flutter/src/model/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Movie> elements;

  CardSwiper({ @required this.elements });
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    


    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              image: NetworkImage(elements[index].getPosterImg()),
            )
          );
        },
        itemCount: 3,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
