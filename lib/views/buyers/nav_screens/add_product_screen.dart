// Add these imports at the beginning of your file
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String productName;
  late int quantity;
  late String location;
  String selectedProductType = 'Vegetables'; // Default value
  String selectedCategory = 'Fruits'; // Default value
  Uint8List? _productImage;

  bool _isLoading = false;

  Future<void> selectGalleryImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _productImage = bytes;
      });
    }
  }

  Future<void> _submitProduct() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        // Add product to Firebase
        await FirebaseFirestore.instance.collection('vendorproduct').add({
          'productName': productName,
          'quantity': quantity,
          'location': location,
          'productType': selectedProductType,
          'category': selectedCategory,
          // Assuming you store images as base64 strings
          'productImage': _productImage != null ? base64Encode(_productImage!) : null,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _formKey.currentState!.reset();
          _productImage = null;
          _isLoading = false;
          selectedProductType = 'Vegetables'; // Reset to default value
          selectedCategory = 'Fruits'; // Reset to default value
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added successfully!'),
          ),
        );
      } catch (e) {
        print('Error adding product: $e');
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding product. Please try again.'),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/firstpage.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectGalleryImage();
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color.fromARGB(255, 237, 230, 167),
                        image: _productImage != null
                            ? DecorationImage(
                                image: MemoryImage(_productImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.photo,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      productName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter quantity';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      quantity = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter location';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      location = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Location',
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedProductType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProductType = newValue!;
                      });
                    },
    //                items: <String>['Vegetables', 'Fruits', 'Grains', 'Fresh Milk', 'Green Leaves']
      //                  .map<DropdownMenuItem<String>>((String value) {
        //              return DropdownMenuItem<String>(
          //              value: value,
            //            child: Text(value),
              //        );
                //    }).toList(),
                  //  decoration: InputDecoration(
                    //  labelText: 'Product Type',
  //                  ),
    //              ),
      //            SizedBox(height: 20),
        //          DropdownButtonFormField<String>(
          //          value: selectedCategory,
            //        onChanged: (String? newValue) {
              //        setState(() {
                //        selectedCategory = newValue!;
                  //    });
                    //},
                    items: <String>['Fruits', 'Vegetables', 'Grains', 'Dairy', 'Others']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Category',
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _submitProduct();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 227, 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                      ),
                    ),
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
