import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top,left: 25,right: 15),
      child: Row(
              
          
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('What are you\n Looking for 👀',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              Container(
                child: Image(
                  image: AssetImage('assets/icons/s-cart.jpg',),
                  width: 30,
                ),
               
              )
            ],
          
       
      ),
    );
  }
}