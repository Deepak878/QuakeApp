

import 'dart:convert';
import 'package:http/http.dart';
import 'package:quake/flutter_maps/quakes_map.dart/model/quake.dart';

class Network{
Future<Quake> getAllQuakes() async{
  var apiUrl = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson';
  final response  = await get(Uri.encodeFull(apiUrl));
    if(response.statusCode == 200){
      print('Quake Data : ${response.body}' );
      return Quake.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Error getting quakes');
    }
  }
  
   
}