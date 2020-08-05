import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
 
import 'package:movies_app/src/pages/home_page.dart';
import 'package:movies_app/src/pages/pelicula_detalle.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/'       : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}