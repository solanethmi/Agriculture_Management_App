import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destination = LatLng(37.33429383, -122.0660005);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getPolylinePoints();
    getFirebaseData();
  }

  void getCurrentLocation() async {
    Location location = Location();

    try {
      var locationData = await location.getLocation();
      if (mounted) {
        setState(() {
          currentLocation = locationData;
        });
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void getPolylinePoints() async {
    if (currentLocation != null && currentLocation!.latitude != null) {
      PolylinePoints polylinePoints = PolylinePoints();

      String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(destination.latitude, destination.longitude),
      );

      if (mounted && result.points.isNotEmpty) {
        setState(() {
          polylineCoordinates.clear();
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        });
      }
    }
  }

  void getFirebaseData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('currentdeliverdetails').get();

    if (mounted) {
      querySnapshot.docs.forEach((doc) {
        double latitude = double.parse(doc['latitude']);
        double longitude = double.parse(doc['longitude']);

        markers.add(
          Marker(
            markerId: MarkerId("delivery_${markers.length + 1}"),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      });

      setState(() {});
    }
  }

  void _showRecordsDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delivery Records"),
        content: Container(
          height: 300, // Set a fixed height for the ListView
          width: double.maxFinite,
          child: StreamBuilder(
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

                  return ListTile(
                    title: Text(record['name']),
                    subtitle: Text('${record['phoneNumber']} - ${record['city']}'),
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: _showRecordsDialog,
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            child: Text("Show Records"),
          ),
        ],
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation!.latitude ?? 0.0,
                  currentLocation!.longitude ?? 0.0,
                ),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polylineCoordinates,
                  color: Colors.pink,
                  width: 6,
                ),
              },
              markers: Set<Marker>.from(markers),
            ),
    );
  }
}
