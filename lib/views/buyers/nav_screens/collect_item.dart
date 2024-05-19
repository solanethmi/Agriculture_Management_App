import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectItem extends StatefulWidget {
  @override
  _CollectItemState createState() => _CollectItemState();
}

class _CollectItemState extends State<CollectItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String fullName;
  late int quantity;
  late String phoneNumber;
  late String address;
  late String paymentMethod;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save data to Firestore
      FirebaseFirestore.instance.collection('orderdetails').add({
        'fullName': fullName,
        'quantity': quantity,
        'phoneNumber': phoneNumber,
        'address': address,
        'paymentMethod': paymentMethod,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Reset form after submission
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collect Item'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 900,
                      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/icons/fruitbg.jpg",),
        fit: BoxFit.cover,
        opacity: 0.2,
        
        ),),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        fullName = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quantity';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        quantity = int.parse(value);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Payment Method'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the payment method';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        paymentMethod = value;
                      },
                    ),
                  ),
                  SizedBox(height: 46),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
