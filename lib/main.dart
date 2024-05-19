import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:se_project/views/buyers/auth/login_screen.dart';
import 'package:se_project/views/buyers/nav_screens/first_screen.dart';
//import 'package:se_project/views/buyers/main_screen.dart';

//import 'package:se_project/views/buyers/auth/register_screen.dart';
//import 'package:se_project/views/buyers/nav_screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: Platform.isAndroid? 
    FirebaseOptions(
      apiKey:"AIzaSyCTkF9nEo6NRJP_bWSpbgf1VKAOoWttRI8",
      appId: "1:865497470842:web:191c5c1b28e982061e28c3",
     messagingSenderId:"865497470842", 
     projectId: "se-project-a2095",
     storageBucket: "se-project-a2095.appspot.com",) 
     : null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirstPage(),
        
    );
  }
}

