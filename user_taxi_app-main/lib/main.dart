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
        apiKey: "AIzaSyB08gztU8CUSFBvlf27UOGUrSvt6mMukfQ",
        authDomain: "driversapp-860a0.firebaseapp.com",
        projectId: "driversapp-860a0",
        storageBucket: "driversapp-860a0.appspot.com",
        messagingSenderId: "17472347586",
        appId: "1:17472347586:web:1343f9ea37932254b64a5b",
        measurementId: "G-LNKY09G06V"
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



