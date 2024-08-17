import 'package:flutter/material.dart';
import 'funct.dart';

// ordered_item_model.dart
class OrderedItem {
  String dishName;
  int quantity;
  int price; // Add this line
  String specialInstructions;

  OrderedItem({
    required this.dishName,
    required this.quantity,
    required this.price, // Add this line
    required this.specialInstructions,
  });
}

class OrderedItemsModel extends ChangeNotifier {
  List<OrderedItem> _orderedItems = [];

  List<OrderedItem> get orderedItems => _orderedItems;

  void addOrderedItem(OrderedItem item) {
    // Check if the item is already in the list
    var existingItemIndex = _orderedItems
        .indexWhere((existingItem) => existingItem.dishName == item.dishName);

    if (existingItemIndex != -1) {
      // If the item exists, update its quantity
      _orderedItems[existingItemIndex].quantity = item.quantity;
    } else {
      // If the item does not exist, add it to the list
      _orderedItems.add(item);
    }

    notifyListeners();
  }

  void removeOrderedItem(OrderedItem item) {
    _orderedItems.remove(item);
    notifyListeners();
  }


  void updateLastSpecialInstructions(String specialInstructions) {
    if (_orderedItems.isNotEmpty) {
      _orderedItems.last.specialInstructions = specialInstructions;
      notifyListeners();
    }
  }

 
  void clearOrderedItems() {
    _orderedItems.clear();
    print('Articles commandés effacés');
    notifyListeners();
  }

  int calculateTotalPrice() {
    return _orderedItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

    int getQuantity(String dishName) {
    var item = _orderedItems.firstWhereOrNull((item) => item.dishName == dishName);
    return item?.quantity ?? 1;
  }
}
