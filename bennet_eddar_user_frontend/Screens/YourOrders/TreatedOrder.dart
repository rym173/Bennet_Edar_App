import 'package:flutter/material.dart';

class TreatedOrder extends StatefulWidget {
  const TreatedOrder({super.key});

  @override
  _TreatedOrderState createState() => _TreatedOrderState();
}

class _TreatedOrderState extends State<TreatedOrder> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        color: Colors.white,
        child: Column(
          children: [
            TreatedOrderItem(
              menuName: 'Couscous',
              imageUrl: 'assets/image/dishes/Couscouss.jpg',
              price: 10.99,
              quantity: 2,
              acceptedTime: '12.11.2023',
              status: 'Acceptée',
              customerAddress: 'vieux kouba',
              customerInstructions: 'example',
              customerItems: 'example',
              customerPhone: '0785851532',
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.02),
            TreatedOrderItem(
              menuName: 'Chekhchoukha',
              imageUrl: 'assets/image/dishes/chekhchoukha.jpg',
              price: 15.99,
              quantity: 1,
              rejectedTime: '11.11.2023',
              status: 'Rejetée',
              customerAddress: 'sidi abdellah',
              customerInstructions: 'example example',
              customerItems: 'example example',
              customerPhone: '0546896520',
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            
            // Add more TreatedOrderItems as needed
          ],
        ),
      ),
    );
  }
}

class TreatedOrderItem extends StatefulWidget {
  final String menuName;
  final String imageUrl;
  final double price;
  final int quantity;
  final String? acceptedTime;
  final String? rejectedTime;
  final String status;
  final String customerPhone;
  final String customerAddress;
  final String customerInstructions;
  final String customerItems;
  final double screenWidth;
  final double screenHeight;

  const TreatedOrderItem({
    Key? key,
    required this.menuName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.acceptedTime,
    this.rejectedTime,
    required this.status,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerInstructions,
    required this.customerItems,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  _TreatedOrderItemState createState() => _TreatedOrderItemState();
}

class _TreatedOrderItemState extends State<TreatedOrderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDetailsDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.imageUrl,
                  width: widget.screenWidth * 0.18,
                  height: widget.screenWidth * 0.18,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.menuName,
                      style:  TextStyle(
                        color: Color(0xFF020202),
                        fontSize: widget.screenWidth * 0.052,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Prix: ${widget.price.toString()} DZD  .  Quantité: ${widget.quantity} ',
                      style:  TextStyle(
                        color: Color(0xFF8D92A3),
                        fontSize: widget.screenWidth * 0.034,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.acceptedTime != null)
                  Text(
                    'Le: ${widget.acceptedTime}',
                    style:  TextStyle(
                      color: Colors.green,
                      fontSize: widget.screenWidth * 0.025,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (widget.rejectedTime != null)
                  Text(
                    'Le: ${widget.rejectedTime}',
                    style:  TextStyle(
                      color: Colors.red,
                      fontSize: widget.screenWidth * 0.025,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  widget.status,
                  style: TextStyle(
                    color: widget.status == 'Acceptée' ? Colors.green : Colors.red,
                    fontSize: widget.screenWidth * 0.025,
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _showDetailsDialog(BuildContext context) {
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: const Color(0xFFF7EDDC),
      title: Text(
        'Menu: ${widget.menuName}',
        style: const TextStyle(
          color: Color(0xFF020202),
          fontSize: 19,
          fontFamily: 'Yaldevi',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Number of items and list of items
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${widget.quantity} article(s):',
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.customerItems,
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 14,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
              // Instructions
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructions:',
                    style: TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.customerInstructions,
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 14,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
              // Customer phone number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Numéro de téléphone client',
                    style: TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' ${widget.customerPhone}',
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 14,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
              // Customer location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Adresse du client:',
                    style: TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.customerAddress,
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 14,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);

  }
}
