import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se_project/views/buyers/nav_screens/recent_product.dart';
import 'package:se_project/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:se_project/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:se_project/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:se_project/views/buyers/nav_screens/widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/icons/firstpage.jpg",),
        fit: BoxFit.cover,
        opacity: 0.4,
        
        ),),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(),
            SizedBox(height: 10,),
            SearchInputWidget(),
            BannerWidget(),
            CategoryText(),
            RecentProduct(),
          ],
        ),
      ),
    );
  }
}

