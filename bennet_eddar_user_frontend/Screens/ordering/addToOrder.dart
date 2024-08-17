// add_to_order_screen.dart
import 'package:bennet_eddar_app/commons/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/top_bar_widget.dart';
import 'swapping_dishes_widget.dart';
import '../../widgets/button_widget.dart';
import 'checked_item_widget.dart';
import 'add_instructions_widget.dart';
import '../../data/menu_dataa.dart';
import 'ordered_item_model.dart';
import 'confirmOrder.dart';
import 'funct.dart';

class AddToOrderScreen extends StatefulWidget {
  final String menuId;

  AddToOrderScreen({Key? key, required this.menuId}) : super(key: key);

  @override
  _AddToOrderScreenState createState() => _AddToOrderScreenState();
}


class _AddToOrderScreenState extends State<AddToOrderScreen> {
  String currentMenu = '1'; // default menu
  OrderedItemsModel? orderedItemsModel;

  @override
  void initState() {
    super.initState();
    orderedItemsModel = context.read<OrderedItemsModel>();
    // Use the menuId parameter here to set the currentMenu
    currentMenu = widget.menuId;
  }

  @override
  void dispose() {
    // Clear the orderedItems when the screen is disposed
    orderedItemsModel?.clearOrderedItems();
    super.dispose();
  }

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuItems = MenuDataa.menus[currentMenu] ?? [];

    return Scaffold(
      appBar: AppTopBar(title: 'Menu ${currentMenu}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwappingImageWithText(
                data: menuItems
                    .map((item) => ImageTextModel(
                          imagePath: item['imagePath']!,
                          title: item['dishName']!,
                          description: item['description']!,
                          
                        ))
                    .toList(),
              ),
              const SizedBox(height: 50.0),
              const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Sélectionnez un repas ou plusieurs: ',
                  style: AppFonts.dishNameTextstyle,
                ),
              ),
              const SizedBox(height: 20.0),
              // Example list of dishes
              Consumer<OrderedItemsModel>(
                builder: (context, orderedItemsModel, child) {
                  return Column(
                    children: [
                      for (Map<String, dynamic> menuItem
                          in menuItems) // Use 'menuItem' instead of 'item'
                        CheckedOrderItem(
                          dishName: menuItem['dishName'],
                          orderedItemsModel: orderedItemsModel,
                          price: menuItem['price'],
                          onChecked: (isChecked, quantity) {
                            String dishName = menuItem['dishName'];
                            if (isChecked) {
                              orderedItemsModel.addOrderedItem(OrderedItem(
                                dishName: dishName,
                                quantity: quantity,
                                specialInstructions: '',
                                price: menuItem['price'],
                              ));
                            } else {
                              var itemToRemove = orderedItemsModel
                                      .orderedItems.isNotEmpty
                                  ? orderedItemsModel.orderedItems
                                      .firstWhereOrNull(
                                          (item) => item.dishName == dishName)
                                  : null;
                              if (itemToRemove != null) {
                                orderedItemsModel
                                    .removeOrderedItem(itemToRemove);
                              }
                            }
                          },
                        ),
                    ],
                  );
                },
              ),

              // Add Special Instructions section
              SpecialInstructionsWidget(
                onSpecialInstructionsChanged: (instructions) {
                  context
                      .read<OrderedItemsModel>()
                      .updateLastSpecialInstructions(instructions);
                },
              ),
              const SizedBox(height: 30.0),
              // Add to order button
              AppElevatedButton(
                label: 'Ajouter à la commande',
                onPressed: () {
                  // Show the ConfirmOrderScreen as a modal
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmOrderScreen(
                        orderedItems:
                            context.read<OrderedItemsModel>().orderedItems,
                        onDismissed: () {},
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
