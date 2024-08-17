import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class treatedOrderItem extends StatefulWidget {
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

  const treatedOrderItem({
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

  factory treatedOrderItem.fromMap(Map<String, dynamic> map) {
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

    return treatedOrderItem(
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
  _treatedOrderItemState createState() => _treatedOrderItemState();
}

class _treatedOrderItemState extends State<treatedOrderItem> {
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

  final treatedOrderItem widget;

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
        // ... (other details)
        const SizedBox(height: 16),
      ],
    );
  }
}
