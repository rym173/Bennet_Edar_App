import 'package:flutter/material.dart';
import 'ordered_item_model.dart';
import '../../commons/colors.dart';
import '../../commons/styles.dart';

class OrderedItemWidget extends StatelessWidget {
  final OrderedItem item;

  OrderedItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    int total = item.quantity * item.price;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(218, 218, 218, 1)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 26.0,
                height: 26.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 194, 194, 194), // Adjust color as needed
                  ),
                ),
                child: Center(
                  child: Text(
                    item.quantity.toString(),
                    style: const TextStyle(
                      color: AppColors.accentColor, // Adjust color as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                item.dishName,
                style: AppFonts.dishDescTextstyle,
              ),
              const Spacer(),
              // Display the total price instead of 'Your Price'
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$total DZD', // Display the total price
                  style: const TextStyle(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
         

         
        ],
      ),
    );
  }
}
