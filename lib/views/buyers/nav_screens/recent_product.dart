import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se_project/views/buyers/nav_screens/collect_item.dart';

class RecentProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('vendorproduct').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var products = snapshot.data!.docs;

        return Container(
          height: 900,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/vegebg.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
          child: Column(
            children: List.generate(
              products.length,
              (index) {
                var productData = products[index].data() as Map<String, dynamic>;
                var productName = productData['productName'] as String?;
                var quantity = productData['quantity'] as int?;
                var location = productData['location'] as String?;
                var productImage = productData['productImage'] as String?;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Adjust as needed
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side: Image
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: productImage != null
                                ? DecorationImage(
                                    image: MemoryImage(base64Decode(productImage)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: 16), // Space between image and details
                        // Right side: Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Name: ${productName ?? ''}',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('Quantity: ${quantity ?? 0}', style: TextStyle(fontSize: 20)),
                            SizedBox(height: 8),
                            Text('Location: ${location ?? ''}', style: TextStyle(fontSize: 20)),
                            SizedBox(height: 16),
                            // Add Cart Button
                            ElevatedButton(
                              onPressed: () {

                                 Navigator.push(context,MaterialPageRoute(builder: (context){
                          return CollectItem();
                        }));
                                // Add Cart functionality here
                              },
                              child: Text('Collect It'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
