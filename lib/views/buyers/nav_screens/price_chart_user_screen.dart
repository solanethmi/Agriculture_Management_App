import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PriceChartUserScreen extends StatefulWidget {
  @override
  _PriceChartUserScreenState createState() => _PriceChartUserScreenState();
}

class _PriceChartUserScreenState extends State<PriceChartUserScreen> {
  List<Map<String, dynamic>> rows = [];

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price Chart '),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 900,
          decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/icons/firstpage.jpg",),
        fit: BoxFit.cover,
        opacity: 0.4,
        
        
        ),),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Product Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Average Price',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            ],
            rows: [
              ...List<DataRow>.generate(
                rows.length,
                (index) {
                  return _buildDataRow(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(rows[index]['productName'].toString(),style: TextStyle(fontSize: 17),),
        ),
        DataCell(
          Text(rows[index]['quantity'].toString(),style: TextStyle(fontSize: 17),),
        ),
        DataCell(
          Text(rows[index]['averagePrice'].toString(),style: TextStyle(fontSize: 17),),
        ),
      ],
    );
  }

  void _fetchRecords() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pricechart').get();
      List<Map<String, dynamic>> fetchedRows = [];

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        fetchedRows = List.from(data['records']);
      });

      setState(() {
        rows = fetchedRows;
      });
    } catch (e) {
      print('Error fetching records: $e');
    }
  }
}
