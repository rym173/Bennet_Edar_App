import 'package:bennet_eddar_app/screens/YourOrders/PendingOrder.dart';
import 'package:bennet_eddar_app/screens/YourOrders/TreatedOrder.dart';
import 'package:bennet_eddar_app/widgets/org_top_bar_without_arrow.dart';
import 'package:flutter/material.dart';

class YourOrders extends StatelessWidget {
  const YourOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: OrgAppTopBarNoArrw(title: 'VOS COMMANDES', automaticallyImplyLeading: false),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Container(
                color: Colors.white, // Set the background color for the tabs
                child:const  Expanded(
                  child: TabBar(
                    indicatorPadding: EdgeInsets.symmetric(
                        horizontal:
                            16.0), // Adjust the horizontal space around the underline
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              Color.fromRGBO(2, 2, 2, 1), // Set the color of the underline
                          width: 3.0, // Set the thickness of the underline
                        ),
                      ),
                    ),
                    labelColor:
                        Color(0xFF020202), // Set the selected tab text color
                    labelStyle: TextStyle(
                      fontSize: 14, // Set the selected tab text size
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor:
                        Color(0xFF8D92A3), // Set the unselected tab text color
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'En cours',
                          ),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Précédentes',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PendingOrder(),
                  TreatedOrder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
