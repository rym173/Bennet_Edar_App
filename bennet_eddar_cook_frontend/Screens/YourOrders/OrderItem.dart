import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class OrderItem extends StatefulWidget {
  final int orderNumber;
  final String userName;
  final String orderDate;
  final double totalPrice;
  final int quantity;
  final int customerPhone;
  final String customerAddress;
  final String customerInst;
  final String orderState;
  final List<Map<String, dynamic>> dishes;

  const OrderItem({
    required this.orderNumber,
    required this.userName,
    required this.orderDate,
    required this.totalPrice,
    required this.quantity,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerInst,
    required this.orderState,
    required this.dishes,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    List<dynamic> dishesList = map['dishes'] ?? [];
    List<Map<String, dynamic>> dishes =
        dishesList.map((item) => item as Map<String, dynamic>).toList();

    print('userPhone: ${map['user_phone']}');
    print('userLocation: ${map['user_location']}');
    print('specialInstruction: ${map['special_instruction']}');
    print('orderId: ${map['order_id']}');
    print('userName: ${map['user_name']}');
    print('orderDate: ${map['order_date']}');
    print('totalPrice: ${map['total_price']}');
    dishes.forEach((dish) {
      print(
          'Dish: ${dish['order_description']}, Quantity: ${dish['quantity']}');
    });

    return OrderItem(
      orderNumber: map['order_id'] ?? 0,
      userName: map['user_name'] ?? '',
      orderDate: map['order_date'] ?? '',
      totalPrice:
          (map['total_price'] != null) ? map['total_price'].toDouble() : 0.0,
      quantity: dishes.length,
      customerPhone: map['user_phone'] ?? '',
      customerAddress: map['user_location'] ?? '',
      customerInst: map['special_instruction'] ?? '',
      orderState: map['order_status'] ?? '',
      dishes: dishes,
    );
  }

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDetailsBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width *
                0.05, // 5% of screen width as horizontal padding
            vertical: MediaQuery.of(context).size.height *
                0.02, // 2% of screen height as vertical padding
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side with order number
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 2.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  '${widget.orderNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Middle with order details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.userName}',
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Prix Total: ${widget.totalPrice.toString()} DZD',
                    style: const TextStyle(
                      color: Color(0xFF8D92A3),
                      fontSize: 13,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Status: ${widget.orderState}',
                    style: const TextStyle(
                      color: Color(0xFF8D92A3),
                      fontSize: 13,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
              // Right side with order date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatOrderDate(widget.orderDate),
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 13,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the detailed view in a bottom sheet
  void _showDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          OrderDetailsBottomSheet(widget: widget),
    );
  }

  String _formatOrderDate(String orderDate) {
    // Assuming orderDate is a String containing the timestamp
    DateTime dateTime = DateTime.parse(orderDate); // Convert String to DateTime
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
}

class OrderDetailsBottomSheet extends StatefulWidget {
  const OrderDetailsBottomSheet({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OrderItem widget;

  @override
  _OrderDetailsBottomSheetState createState() =>
      _OrderDetailsBottomSheetState();
}

class _OrderDetailsBottomSheetState extends State<OrderDetailsBottomSheet> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    // Simulate an asynchronous operation (e.g., fetching data) using Future.delayed
    await Future.delayed(Duration(seconds: 2));
  }

  // Inside _OrderDetailsBottomSheetState class

  void _processOrder(String status) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://flask-cook-endpoint.vercel.app/update_order/${widget.widget.orderNumber}/$status/finish',
        ),
      );

      if (response.statusCode == 200) {
        // Order accepted/rejected successfully
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Order $status successfully'),
        ));

        Navigator.of(context).pop();
      } else {
        // Error handling
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to $status order'),
        ));
      }
    } catch (error) {
      // Exception handling
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<void>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else {
            return buildContent();
          }
        },
      ),
    );
  }

  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Commande #${widget.widget.orderNumber} - ${widget.widget.userName}',
          style: const TextStyle(
            color: Color(0xFF020202),
            fontSize: 19,
            fontFamily: 'Yaldevi',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Nombre Total des Plats: ${widget.widget.quantity}',
          style: const TextStyle(
            color: Color(0xFF020202),
            fontSize: 16,
            fontFamily: 'Yaldevi',
            fontWeight: FontWeight.bold,
          ),
        ),
        // List of dishes
        Expanded(
          child: ListView.builder(
            itemCount: widget.widget.quantity,
            itemBuilder: (context, index) {
              final dish = widget.widget.dishes[index];
              return ListTile(
                title: Text('${dish['order_description']}'),
                subtitle: Text('Quantité: ${dish['quantity']}'),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Instructions: ${widget.widget.customerInst}',
          style: const TextStyle(
            color: Color(0xFF020202),
            fontSize: 16,
            fontFamily: 'Yaldevi',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tel: ${widget.widget.customerPhone}',
          style: const TextStyle(
            color: Color(0xFF020202),
            fontSize: 16,
            fontFamily: 'Yaldevi',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Adresse: ${widget.widget.customerAddress}',
          style: const TextStyle(
            color: Color(0xFF020202),
            fontSize: 16,
            fontFamily: 'Yaldevi',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                _processOrder('Acceptée');
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                primary: const Color(0xFFFFB261),
              ),
              child: const Text('Accepter',
                  style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                _processOrder('Refusée');
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                primary: Colors.white,
                side: const BorderSide(color: const Color(0xFFFFB261)),
              ),
              child: const Text('Refuser',
                  style: TextStyle(color: Color(0xFFFFB261))),
            ),
          ],
        ),
      ],
    );
  }
}
