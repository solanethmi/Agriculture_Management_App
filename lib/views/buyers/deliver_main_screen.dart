import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DeliverMainScreen extends StatefulWidget {
  @override
  _DeliverMainScreenState createState() => _DeliverMainScreenState();
}

class _DeliverMainScreenState extends State<DeliverMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fill Details"),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save details to Firebase
                _saveDetailsToFirebase();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveDetailsToFirebase() async {
    FirebaseFirestore.instance.collection('currentdeliverdetails').add({
      'name': nameController.text,
      'phoneNumber': phoneNumberController.text,
      'city': cityController.text,
      'latitude': latitudeController.text,
      'longitude': longitudeController.text,
    });

    // Clear text controllers after saving
    nameController.clear();
    phoneNumberController.clear();
    cityController.clear();
    latitudeController.clear();
    longitudeController.clear();
  }

  void _deleteRecord(String documentId) async {
    await FirebaseFirestore.instance
        .collection('currentdeliverdetails')
        .doc(documentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Deliver Main Screen"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('currentdeliverdetails')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var records = snapshot.data!.docs;

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              var record = records[index].data() as Map<String, dynamic>;
              String documentId = records[index].id;

              return ListTile(
                title: Text(record['name']),
                subtitle: Text(record['phoneNumber']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Delete record from Firebase
                        _deleteRecord(documentId);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNotificationDialog,
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}
