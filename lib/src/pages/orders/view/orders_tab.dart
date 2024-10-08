import 'package:app/src/pages/orders/controller/all_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              //physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (_, index) => OrderTile(order: controller.allOrders[index]),
              //itemBuilder: (_, index) {
                //return OrderTile(order: appData.orders[index],);//(appData.orders[index].id);
              //},
              itemCount: controller.allOrders.length,
            ),
          );
        }
      ),
    );
  }
}
