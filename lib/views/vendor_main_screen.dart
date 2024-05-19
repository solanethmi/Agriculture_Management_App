import 'package:flutter/material.dart';
import 'package:se_project/views/buyers/nav_screens/add_product_screen.dart';
import 'package:se_project/views/buyers/nav_screens/order_request_screen.dart';
import 'package:se_project/views/buyers/nav_screens/price_chart_user_screen.dart';
import 'package:se_project/views/buyers/nav_screens/vendor_remove_product.dart';

class VendorMainScreen extends StatefulWidget {
  const VendorMainScreen({Key? key}) : super(key: key);

  @override
  State<VendorMainScreen> createState() => _VendorMainScreenState();
}

class _VendorMainScreenState extends State<VendorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/firstpage.jpg"),
              fit: BoxFit.cover,
              opacity: 0.4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {

                     Navigator.push(context,MaterialPageRoute(builder: (context){
                          return AddProductScreen();
                        }));

                  // Handle the 'ADD PRODUCT' button tap
                  // Add your logic here
                },
                child: Text('ADD PRODUCT'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(200, 80),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                  Navigator.push(context,MaterialPageRoute(builder: (context){
                          return OrderNotificationsScreen();
                           }));
                  // Handle the 'REQUESTS' button tap
                  // Add your logic here
                },
                child: Text('REQUESTS'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 163, 246, 74),
                  minimumSize: Size(200, 80),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                    Navigator.push(context,MaterialPageRoute(builder: (context){
                          return RemoveProduct();
                        }));
                  // Handle the 'REMOVE PRODUCT' button tap
                  // Add your logic here
                },
                child: Text('REMOVE PRODUCT'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(200, 80),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                    Navigator.push(context,MaterialPageRoute(builder: (context){
                          return PriceChartUserScreen();
                        }));
                  // Handle the 'REMOVE PRODUCT' button tap
                  // Add your logic here
                },
                child: Text('PRICE CHART'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 126, 254, 71),
                  minimumSize: Size(200, 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
