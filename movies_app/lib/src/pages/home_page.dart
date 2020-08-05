
import 'package:flutter/material.dart';

import 'package:movies_app/src/providers/peliculas_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {


  final peliculasProvider = PeliculasProvider(); //una instancia

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares(); //llama inicialmente al método de obtener las películas populares
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){})
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(), //este son las tarjetas de las que están en cine
            _footer(context), //este es el widget del pageview que contiene las películas populares
          ],),
      )
        
        );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEncines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

      if (snapshot.hasData){

        return CardSwiper(
          peliculas: snapshot.data);
      } else {

        return Container(
                  child: Center(
                   child: CircularProgressIndicator()),
                  padding: EdgeInsets.only(top: 100.0),
                  );
      }
        

      },
    );
    // peliculasProvider.getEncines();
    // return Container();
    // return CardSwiper(
    //   peliculas: [1,2,3,4,5]);
  }

  Widget _footer(context) {

    return Container(

      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:20.0),
            child: Text('Populares!', style: Theme.of(context).textTheme.subtitle1)),

          SizedBox(height: 5.0,),

          StreamBuilder( //contrucción del stream
            stream: peliculasProvider.popularesStream, //este es el valor que se va a obtener del stream, la analogía al future pero que se podrá actualiar 
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if (snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,);//all llamar peliculasprovider.getPopulares dentro del MovieHorizontal va agregar elementos a la lista de la siguiente página, se le pasa al sink, luego se procesa con el stream
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
 

        ],
      ),
    );
  }
}