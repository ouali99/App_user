import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_taxi_app/splashScreen/splash_screen.dart';
//import 'package:users_app/splashScreen/splash_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    await Firebase.initializeApp();
    options: const FirebaseOptions(
        apiKey: "AIzaSyCfjO3fwcA1jAEnImYf6n1i4oNfMsYD_6M",
        authDomain: "taxi-services-clone.firebaseapp.com",
        projectId: "taxi-services-clone",
        storageBucket: "taxi-services-clone.appspot.com",
        messagingSenderId: "759037898579",
        appId: "1:759037898579:web:b3db04a7b195c882507ba6",
        measurementId: "G-YTZ80CRHYY"
    );

  }else{
await Firebase.initializeApp();
}

  runApp(
    MyApp(
      child: MaterialApp(
        title: 'Drivers App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
          home: const MySplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}



class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();

  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}



