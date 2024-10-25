import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_taxi_app/assistants/assistant_methods.dart';
import 'package:user_taxi_app/global/global.dart';
import 'package:user_taxi_app/widgets/my_drawer.dart';

import '../authentication/login_screen.dart';

 class MainScreen extends StatefulWidget {
 
   @override
   State<MainScreen> createState() => _MainScreenState();
 }
 
 class _MainScreenState extends State<MainScreen> {
   final Completer<GoogleMapController> _controllerGoogleMap =
   Completer<GoogleMapController>();
   GoogleMapController ? newgoogleMapController;
   static const CameraPosition _kMontreal = CameraPosition(
     target: LatLng(45.5017, -73.5673),
     zoom: 14.4746,
   );
   GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
   double searchLocationContainerHeight = 220;

   Position? userCurrentPosition;
   var geoLocator = Geolocator();

   LocationPermission? _locationPermission;
   double bottomPaddingOfMap = 0;

   blackThemeGoogleMap()
   {
     newgoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
   }

   checkIfPermissionAllowed() async
   {
     _locationPermission = await Geolocator.requestPermission();
     if(_locationPermission == LocationPermission.denied){
       _locationPermission = await Geolocator.requestPermission();
     }
   }

   locateUserPosition() async
   {
     Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     userCurrentPosition = cPosition;
     LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
     CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);
     
     newgoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
   }

   @override
  void initState() {

    super.initState();
    checkIfPermissionAllowed();
  }

   @override
   Widget build(BuildContext context)
   {
     return Scaffold(
       key: sKey,
       drawer: Container(
         width: 265,
         child: Theme(
             data: Theme.of(context).copyWith(
               canvasColor: Colors.black,
             ),
             child: MyDrawer(
               name: userModelCurrentInfo!.name,
               email: userModelCurrentInfo!.email,
         
             ),
           ),
       ),

       body: Stack(
         children: [
           GoogleMap(
             padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
             mapType:MapType.normal ,
             myLocationEnabled: true,
             zoomGesturesEnabled: true,
             zoomControlsEnabled: true,
             initialCameraPosition: _kMontreal ,
             onMapCreated: (GoogleMapController controller)
             {
                _controllerGoogleMap.complete(controller);
                newgoogleMapController = controller;

                blackThemeGoogleMap();

                setState(() {
                  bottomPaddingOfMap =255;
                });

                locateUserPosition();
             },
           ),

           //custom hamburger button for darawer

           Positioned(
             top: 37,
             left: 20,
             child: GestureDetector(
               onTap: ()
               {
                 sKey.currentState!.openDrawer();
               },
               child: const CircleAvatar(
                 backgroundColor: Colors.grey,
                 child: Icon(
                   Icons.menu,
                   color: Colors.black54,
                 ),
               ),
             ),
           ),

           //ui for searching
           Positioned(
             bottom:0,
             left:0,
             right:0,
             child: AnimatedSize(
               curve: Curves.easeIn,
               duration: const Duration(milliseconds: 120),
               child: Container(
                 height: searchLocationContainerHeight,
                   decoration: const BoxDecoration(
                     color: Colors.black87,
                     borderRadius: BorderRadius.only(
                       topRight: Radius.circular(20),
                       topLeft: Radius.circular(20),
                     ),
                   ),

                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                   child: Column(
                     children: [
                       //from location
                       Row(
                         children: [
                         Icon(Icons.add_location_alt_outlined, color:Colors.grey),
                           SizedBox(width: 12.0,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               const Text(
                                 "From",
                                 style: TextStyle(color: Colors.grey,fontSize: 12),
                               ),
                               Text(
                                 "Your current location",
                                 style: const TextStyle(color: Colors.grey,fontSize: 14),
                               ),
                             ],
                           )
                         ],
                       ),

                       const SizedBox(height: 10.0,),
                       const Divider(
                         height: 1,
                         thickness: 1,
                         color:Colors.grey,
                       ),

                       const SizedBox(height: 16.0,),

                       Row(
                         children: [
                           Icon(Icons.add_location_alt_outlined, color:Colors.grey),
                           SizedBox(width: 12.0,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               const Text(
                                 "to",
                                 style: TextStyle(color: Colors.grey,fontSize: 12),
                               ),
                               Text(
                                 "where to go ?",
                                 style: const TextStyle(color: Colors.grey,fontSize: 14),
                               ),
                             ],
                           )
                         ],
                       ),

                       const SizedBox(height: 10.0,),
                       const Divider(
                         height: 1,
                         thickness: 1,
                         color:Colors.grey,
                       ),

                       const SizedBox(height: 16.0,),

                       ElevatedButton(
                         child: const Text(
                           "Request A Ride",
                         ),
                         onPressed: ()
                         {

                         },
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.green,
                           textStyle: const TextStyle(fontSize: 16, fontWeight:FontWeight.bold),
                         ),
                       ),


                     ],
                   ),
                 ),
               ),
             ) ,

           ),
         ],
       )
     );
   }
 }
 