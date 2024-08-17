import 'package:bennet_eddar_cook/constants/endpoints.dart';
import 'package:bennet_eddar_cook/screens/YourOrders/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<OrderItem>> fetchOrders(String cookId) async {
  final response =
      await http.get(Uri.parse(getApiEndpointForCookOrders(cookId)));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body)['orders'];
    return data.map((item) => OrderItem.fromMap(item)).toList();
  } else {
    throw Exception('Failed to load orders');
  }
}

class OrdersPage extends StatefulWidget {
  final String cookId;

  OrdersPage({required this.cookId});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<OrderItem>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = fetchOrders(widget.cookId);
    // Start a periodic timer to refresh data every 1 minute
    Timer.periodic(Duration(seconds: 30), (Timer timer) {
      // Fetch data again
      _refreshOrders();
    });
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _ordersFuture = fetchOrders(widget.cookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<OrderItem>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            );

          if (snapshot.hasData && snapshot.data!.isEmpty) {
            // Display a message when there are no items
            return Center(
              child: Text(
                'Rien à Afficher',
                style: const TextStyle(
                  color: Color(0xFF8D92A3),
                  fontFamily: 'Yaldevi',
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              OrderItem order = snapshot.data![index];
              return OrderItem(
                orderNumber: order.orderNumber,
                userName: order.userName,
                orderDate: order.orderDate,
                totalPrice: order.totalPrice,
                quantity: order.quantity,
                customerPhone: order.customerPhone,
                customerAddress: order.customerAddress,
                customerInst: order.customerInst,
                orderState: order.orderState,
                dishes: order.dishes,
              );
            },
          );
        },
      ),
    );
  }
}
