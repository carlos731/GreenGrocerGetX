import 'package:app/src/config/custom_colors.dart';
import 'package:flutter/material.dart';
import '../../models/cart_item_model.dart';
import '../../services/utils_services.dart';
import 'package:app/src/config/app_data.dart' as appData;

import '../common_widgets/payment_dialog.dart';
import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      appData.cartItems.remove(cartItem);
      utilsServices.showToast(message: '${cartItem.item.itemName} removido(a) do carrinho', context: context, width: 300, height: 50);
    });
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in appData.cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appData.cartItems.length,
              itemBuilder: (_, index) {
                final cartItem = appData.cartItems[index];
                // return CartTile(
                //   cartItem: appData.cartItems[index],
                //   remove: removeItemFromCart,
                // );
                return CartTile(
                  cartItem: appData.cartItems[index],
                  updatedQuantity: (qtd) {
                    if (qtd == 0) {
                      removeItemFromCart(appData.cartItems[index]);
                    } else {
                      setState(() => cartItem.quantity = qtd);
                    }
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      // primary: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      //print(result);

                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PaymentDialog(
                              order: appData.orders.first,
                            );
                          },
                        );
                      } else {
                        utilsServices.showToast(message: 'Pedido não confirmado', isError: true, context: context, width: 300, height: 50);
                      }
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confimação'),
          content: const Text('Deseja realment concluir o pedido'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
