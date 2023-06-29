import 'package:flutter/material.dart';
import 'package:app/src/config/app_data.dart' as appData;

import 'components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemBuilder: (_, index) => OrderTile(order: appData.orders[index]),
        //itemBuilder: (_, index) {
          //return OrderTile(order: appData.orders[index],);//(appData.orders[index].id);
        //},
        itemCount: appData.orders.length,
      ),
    );
  }
}
