import 'package:flutter/material.dart';

showSnack(context,String title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Color.fromARGB(255, 247, 229, 60),
    content: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      ),
    ),
    );
}