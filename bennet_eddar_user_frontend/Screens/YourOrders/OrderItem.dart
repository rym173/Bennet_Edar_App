import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  final String menuName;
  final String imageUrl;
  final double price;
  final int quantity;
  final String CustomerPhone;
  final String CustomerAdress;
  final String CustomerInst;
  final String CustomerItems;
  final double width;

  const OrderItem({super.key, 
    required this.menuName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.CustomerPhone,
    required this.CustomerAdress,
    required this.CustomerInst,
    required this.CustomerItems,
    required this.width,
  });

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side with menu image, name, price, and quantity
          Row(
            children: [
              Image.network(
                widget.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.menuName,
                    style: const TextStyle(
                      color: Color(0xFF020202),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Prix: ${widget.price.toString()} DZD  .  Quantité: ${widget.quantity} ',
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
            ],
          ),
          // Right side with Treat button
          ElevatedButton(
            onPressed: () {
              _showDetailsDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Background color
              side: const BorderSide(
                  color: Color.fromARGB(255, 235, 236, 239)), // Border color
              minimumSize: const Size(100, 40), // Adjust width and height
            ),
            child: const Text(
              'TRAITER',
              style: TextStyle(
                color: Color(0xFFF8B64C),
                fontSize: 16,
                fontFamily: 'Yaldevi',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the detailed view in a dialog
  void _showDetailsDialog(BuildContext context) {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
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
          content: Container(
            constraints: const BoxConstraints(maxHeight: 400.0), // Adjust the maximum height as needed
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
                        widget.CustomerItems,
                        style: const TextStyle(
                          color: Color(0xFF020202),
                          fontSize: 14,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w600,
                          height: 0,
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
                        widget.CustomerInst,
                        style: const TextStyle(
                          color: Color(0xFF020202),
                          fontSize: 14,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w600,
                          height: 0,
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
                        ' ${widget.CustomerPhone}',
                        style: const TextStyle(
                          color: Color(0xFF020202),
                          fontSize: 14,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w600,
                          height: 0,
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
                        widget.CustomerAdress,
                        style: const TextStyle(
                          color: Color(0xFF020202),
                          fontSize: 14,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add logic for reject order
                    // TreatOrder();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.close, color: Color(0xFFFFB261)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add logic for confirm order
                    // TreatOrder()
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: const Color(0xFFFFB261),
                  ),
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  },
);

  }
}