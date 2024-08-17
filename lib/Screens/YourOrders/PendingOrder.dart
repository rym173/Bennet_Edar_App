import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/widgets/CustomDialog.dart';
import 'dart:math' as math;

class PendingOrder extends StatefulWidget {
  const PendingOrder({super.key});

  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
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
              price: 10.99,
              quantity: 2,
              status: 'En attente',
              customerAddress: 'vieux kouba',
              customerInstructions: 'example',
              customerItems: 'example',
              customerPhone: '0785851532',
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.02),
            TreatedOrderItem(
              menuName: 'Chetitha Serdine',
              imageUrl: 'assets/image/dishes/chetitha.jpg',
              price: 15.99,
              quantity: 1,
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
    required this.status,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerInstructions,
    required this.customerItems,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  _TreatedOrderItemState createState() => _TreatedOrderItemState();
}

class _TreatedOrderItemState extends State<TreatedOrderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                      style: TextStyle(
                        color: const Color(0xFF020202),
                        fontSize: widget.screenWidth * 0.052,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Prix: ${widget.price.toString()} DZD  .  Quantité: ${widget.quantity} ',
                      style: TextStyle(
                        color: const Color(0xFF8D92A3),
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
                if (widget.status == 'Acceptée' || widget.status == 'Rejetée')
                  IconButton(
                    icon: Transform.rotate(
                      angle: -math.pi / 2,
                      child: Icon(Icons.move_down, color: Color(0xFFFFB261), size: widget.screenWidth * 0.04),
                    ),
                    onPressed: () {
                      _showDetailsDialog(
                        context,
                        'Souhaitez-vous vraiment placer cette commande en Précédentes?',
                      );
                    },
                  ),
                if (widget.status == 'En attente')
                  IconButton(
                    icon: Icon(Icons.cancel, color: Color(0xFFFFB261), size: widget.screenWidth * 0.04),
                    onPressed: () {
                      _showDetailsDialog(
                        context,
                        'Souhaitez-vous vraiment annuler cette commande?',
                      );
                    },
                  ),
                const SizedBox(height: 6),
                Text(
                  widget.status,
                  style: TextStyle(
                    color: widget.status == 'Acceptée'
                        ? Colors.green
                        : (widget.status == 'Rejetée'
                            ? Colors.red
                            : const Color(0xFFFFB261)),
                    fontSize: widget.screenWidth * 0.034,
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



  void _showDetailsDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(displayText: text);
      },
    );
  }
 
  }
