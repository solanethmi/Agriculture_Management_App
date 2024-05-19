import 'package:flutter/material.dart';
import 'package:se_project/views/buyers/auth/deliver_login_screen.dart';
import 'package:se_project/views/buyers/auth/login_screen.dart';
import 'package:se_project/views/buyers/auth/vendor_login_screen.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FARMER FRIEND',
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 9, 60, 11),fontSize: 30),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/icons/firstpage.jpg",),
        fit: BoxFit.cover,
        opacity: 0.4,
        
        ),),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 250,),
              buildButtonRow("If you are a Buyer", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
                // Buyer button onTap function
                print("Buyer button tapped!");
              }),
              SizedBox(height: 30,),
              buildButtonRow("If you are a Vendor", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VendorLoginScreen(),
                  ),
                );
                // Vendor button onTap function
                print("Vendor button tapped!");
              }),
              SizedBox(height: 30,),
              buildButtonRow("If you are a Deliver", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliverLoginScreen(),
                  ),
                );
                // DeliveryPerson button onTap function
                print("DeliveryPerson button tapped!");
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonRow(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 27),
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: onTap,
            child: Text(
              text == "If you are a Deliver"
                  ? "Delivery"
                  : text == "If you are a Buyer"
                      ? "Buyer"
                      : "Vendor",
              style: TextStyle(
                fontSize: 20,
                color: text == "If you are DeliveryPerson"
                    ? Colors.orange
                    : const Color.fromARGB(255, 59, 160, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
