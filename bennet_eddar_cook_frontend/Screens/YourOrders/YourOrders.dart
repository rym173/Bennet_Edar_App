import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/screens/YourOrders/TreatedOrder.dart';
import 'package:bennet_eddar_cook/screens/YourOrders/order.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:bennet_eddar_cook/widgets/org_top_bar_without_arrow.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key});

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  late String? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    userId = await getUserId();
    setState(() {}); // Trigger a rebuild after obtaining the user ID
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const OrgAppTopBarNoArrw(title: 'VOS COMMANDES', automaticallyImplyLeading: false),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Container(
                color: Colors.white,
                child: const TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 70.0),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFF020202),
                        width: 3.0,
                      ),
                    ),
                  ),
                  labelColor: Color(0xFF020202),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Color(0xFF8D92A3),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'En attente',
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Traitées',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  userId != null
                      ? OrdersPage(cookId: userId!)
                      : const Center(child: CircularProgressIndicator()),
                       treatedOrdersPage(cookId: userId!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
