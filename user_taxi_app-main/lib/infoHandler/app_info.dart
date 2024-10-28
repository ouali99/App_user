import 'package:flutter/cupertino.dart';
import 'package:user_taxi_app/models/directions.dart';

class AppInfo extends ChangeNotifier
{
  Directions? userPickUpLocation;


  void updatePickUpLocationAddress(Directions userPickUpAddress)
  {
    userPickUpLocation = userPickUpAddress;
    notifyListeners();
  }
}