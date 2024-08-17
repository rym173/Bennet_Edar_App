// checked_item_widget.dart
import 'package:flutter/material.dart';
import '../../commons/colors.dart';
import '../../commons/styles.dart';
import 'ordered_item_model.dart';

class CheckedOrderItem extends StatefulWidget {
  final String dishName;
  final Function(bool isChecked, int quantity) onChecked;
  final OrderedItemsModel orderedItemsModel; 
  final int price; 

  CheckedOrderItem({
    required this.dishName,
    required this.onChecked,
    required this.orderedItemsModel, 
    required this.price, 
  });

  @override
  _CheckedOrderItemState createState() => _CheckedOrderItemState();
}

class _CheckedOrderItemState extends State<CheckedOrderItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChecked(
              isChecked, widget.orderedItemsModel.getQuantity(widget.dishName));
        });
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color.fromRGBO(218, 218, 218, 1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accentColor,
                ),
              ),
              child: isChecked
                  ? Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16.0),
            Text(
              widget.dishName,
              style: AppFonts.dishDescTextstyle,
            ),
            const Spacer(),
            if (isChecked)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        int currentQuantity = widget.orderedItemsModel
                            .getQuantity(widget.dishName);
                        if (currentQuantity > 1) {
                          OrderedItem orderedItem = OrderedItem(
                            dishName: widget.dishName,
                            quantity: currentQuantity - 1,
                            specialInstructions: '',
                            price: widget.price, // Include the price here
                          );
                          widget.orderedItemsModel.addOrderedItem(orderedItem);
                        }
                      });
                    },
                  ),
                  Text(
                      '${widget.orderedItemsModel.getQuantity(widget.dishName)}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        int currentQuantity = widget.orderedItemsModel
                            .getQuantity(widget.dishName);
                        OrderedItem orderedItem = OrderedItem(
                          dishName: widget.dishName,
                          quantity: currentQuantity + 1,
                          specialInstructions: '',
                          price: widget.price,
                        );
                        widget.orderedItemsModel.addOrderedItem(orderedItem);
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
