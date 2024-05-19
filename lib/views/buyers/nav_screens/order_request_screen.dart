import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderNotificationsScreen extends StatefulWidget {
  @override
  _OrderNotificationsScreenState createState() => _OrderNotificationsScreenState();
}

class _OrderNotificationsScreenState extends State<OrderNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orderdetails').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading order notifications'));
          } else {
            final orderDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: orderDocs.length,
              itemBuilder: (context, index) {
                final orderData = orderDocs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('New Order: ${orderData['fullName']}'),
                  subtitle: Text('Quantity: ${orderData['quantity']}'),
                  onTap: () {
                    // Navigate to OrderDetailsScreen when tapping on the notification
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(orderId: orderDocs[index].id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _orderDetails;

  @override
  void initState() {
    super.initState();
    // Fetch order details when the screen is created
    _orderDetails = _fetchOrderDetails();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchOrderDetails() async {
    return await FirebaseFirestore.instance.collection('orderdetails').doc(widget.orderId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: FutureBuilder(
        future: _orderDetails,
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading order details'));
          } else {
            final orderData = snapshot.data!.data();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: ${orderData?['fullName']}'),
                  Text('Quantity: ${orderData?['quantity']}'),
                  Text('Phone Number: ${orderData?['phoneNumber']}'),
                  Text('Address: ${orderData?['address']}'),
                  Text('Payment Method: ${orderData?['paymentMethod']}'),
                  // Add more details as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
