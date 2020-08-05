import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = PageController(

          initialPage: 1,
          viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent-200) {
        
        // print('Cargaro siguientes películas');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        // children: _tarjetas(context),
        itemBuilder: (BuildContext context, i) {

          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }


  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    final tarjeta =  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,),
          ],
        ),
      );

      return GestureDetector(

        child: tarjeta,
        onTap: (){

          // print('ID de la película ${pelicula.title}');
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );

  }

  List<Widget> _tarjetas(context) {

    return peliculas.map((pelicula){

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,),
          ],
        ),
      );
    }).toList();
  }
}