import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('vendorproduct').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black, fontSize: 20));
        }

        var products = snapshot.data!.docs;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/firstpage.jpg"),
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
                var documentId = products[index].id;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 255, 255, 255), // Adjust as needed
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(height: 8),
                              Text('Quantity: ${quantity ?? 0}', style: TextStyle(fontSize: 15, color: Colors.black)),
                              SizedBox(height: 8),
                              Text('Location: ${location ?? ''}', style: TextStyle(fontSize: 15, color: Colors.black)),
                              SizedBox(height: 16),
                              // Add Cart Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add Update Product functionality here
                                    },
                                    child: Text('Update Product', style: TextStyle(fontSize: 14, color: Colors.black)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _removeProduct(documentId);
                                    },
                                    child: Text('Remove', style: TextStyle(fontSize: 14, color: Colors.black)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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

  void _removeProduct(String documentId) async {
    await FirebaseFirestore.instance.collection('vendorproduct').doc(documentId).delete();
  }
}
