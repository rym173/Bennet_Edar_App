import 'package:flutter/material.dart';
import 'ordered_item_model.dart';
import 'confirmed_item_widget.dart';
import '../../commons/colors.dart';
import '../../commons/styles.dart';
import 'package:provider/provider.dart';
import '../../widgets/button_widget.dart';
import 'successful_order_widget.dart';
import '../promo_code/promoCodeScreen.dart';
import '../promo_code/promo_code_model.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final List<OrderedItem> orderedItems;
  final VoidCallback onDismissed;

  ConfirmOrderScreen({required this.orderedItems, required this.onDismissed});

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  bool orderConfirmed = false;
  PromoCode? selectedPromoCode;
  late int subtotalSum;
  late double totalSum;

  @override
  Widget build(BuildContext context) {
    subtotalSum = context.read<OrderedItemsModel>().calculateTotalPrice();
    totalSum = subtotalSum.toDouble() * (1 - (selectedPromoCode?.percentage ?? 0) / 100);

    double screenHeight = MediaQuery.of(context).size.height;
    double modalHeight = screenHeight * 0.8; // Adjust the percentage as needed

    // Method to navigate to the Promo Code page
    Future<void> _navigateToPromoCodePage() async {
      PromoCode? result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PromoCodePage()),
      );

      if (result != null) {
        // Handle the selected promo code
        setState(() {
          selectedPromoCode = result;
          // Recalculate the total sum after applying the promo code
          totalSum = subtotalSum.toDouble() * (1 - (selectedPromoCode?.percentage ?? 0) / 100);
        });
      }
    }

    return Container(
      height: modalHeight,
      child: orderConfirmed
          ? OrderSuccessWidget() // Display the success message widget
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Votre commande',
                        style: AppFonts.titleAppBarTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onDismissed();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.orderedItems.length + 4, // Add 4 for Promo Code section and "Confirm Order" button
                    itemBuilder: (context, index) {
                      if (index < widget.orderedItems.length) {
                        OrderedItem item = widget.orderedItems[index];
                        return OrderedItemWidget(item: item);
                      } else if (index == widget.orderedItems.length) {
                        return Container(
                          padding: const EdgeInsets.only(left: 15, right: 6, top: 40, bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                                style: AppFonts.dishDescTextstyle,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$subtotalSum DZD',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index == widget.orderedItems.length + 1) {
                        return Container(
                          padding: const EdgeInsets.only(left: 15, right: 6, bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Promo Code',
                                style: AppFonts.dishDescTextstyle,
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: selectedPromoCode != null
                                    ? Text(
                                        '${selectedPromoCode!.percentage}% (${selectedPromoCode!.name})',
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          // Navigate to the Promo Code page
                                          _navigateToPromoCodePage();
                                        },
                                        style: TextButton.styleFrom(
                                          primary: AppColors.primaryColor,
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: const Text('Voir les détails'),
                                      ),
                              ),
                            ],
                          ),
                        );
                      } else if (index == widget.orderedItems.length + 2) {
                        return Container(
                          padding: const EdgeInsets.only(left: 15, right: 6, bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: AppFonts.dishDescTextstyle,
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$totalSum DZD',
                                  style: const TextStyle(
                                    color: AppColors.accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Display the "Confirm Order" button
                        return Container(
                          padding: const EdgeInsets.all(30),
                          child: AppElevatedButton(
                            label: 'Confirmer la commande',
                            onPressed: () {
                              // Handle the confirmation logic
                              setState(() {
                                orderConfirmed = true;
                              });
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
