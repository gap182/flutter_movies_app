
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/actores_model.dart';

import 'package:movies_app/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apiKey   = '4ea087383e185035de3e29571714db71';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-Es';

  int _popularesPage = 0;
  bool _cargando     = false;

  List<Pelicula> _populares = List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final populares = Peliculas.fromJsonList(decodedData['results']);

    return populares.items;
  }

  Future<List<Pelicula>> getEncines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {

    String _apiKey = '4ea087383e185035de3e29571714db71';
    String _url = 'api.themoviedb.org';
    String _language = 'es-ES';

    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    print('Cargando siguientes...');


    final urlPop = Uri.https(_url, '3/movie/popular', {
      'language': _language,
      'api_key' : _apiKey,
      'page'    : _popularesPage.toString(),
    });
    
    final resp = await _procesarRespuesta(urlPop);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;
    

    
  }

 Future<List<Actor>> getCast(String peliId) async{

   final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key' : _apiKey,
      'language': _language,
   });

   final resp = await http.get(url);
   final decodedData = json.decode(resp.body);

   final cast = Cast.fromJsonList(decodedData['cast']);

   return cast.actores;
  }
}