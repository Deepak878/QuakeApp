import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quake/flutter_maps/quakes_map.dart/model/quake.dart';
import 'package:quake/flutter_maps/quakes_map.dart/network/network.dart';


class QuakesApp extends StatefulWidget {
  @override
  _QuakesAppState createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
  Future<Quake> _quakesData;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = <Marker>[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quakesData = Network().getAllQuakes();
    _quakesData.then((values) => {
      print('Place : ${values.features[0].properties.place}')
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:<Widget>[
          _buildGoogleMap(context)
                  ]
                ),

                floatingActionButton: FloatingActionButton.extended(
                  onPressed: (){
                    findQuakes();
                                      }, 
                                      label: Text('Find Quakes')),
                                  );
                                }
                              
                              Widget  _buildGoogleMap(BuildContext context) {
                                return Container(
                                  width:MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  
                                   child: GoogleMap(
                                     mapType: MapType.normal,
                                     onMapCreated: (GoogleMapController controller){
                                       _controller.complete(controller);
                                     },
                                     initialCameraPosition: CameraPosition(target: LatLng(36.1083333, -177.860833),zoom: 1),
                                     markers: Set<Marker>.of(_markerList),
                                     ),
                                     
                                );
                              }
                    
                      void findQuakes() {
                        setState(() {
                          _markerList.clear();
                          _handleResponse();
                                                  });
                                                }
                          
                            void _handleResponse() {
                              setState(() {
                                _quakesData.then((quakes) => {
                                  quakes.features.forEach((quake) { 
                                    _markerList.add(Marker(markerId: MarkerId(quake.id),
                                    infoWindow: InfoWindow(title:quake.properties.mag.toString(),snippet: quake.properties.title),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                                    position: LatLng(quake.geometry.coordinates[1], quake.geometry.coordinates[0]),

                                    ));
                                  })
                                });
                              });
                            }
}