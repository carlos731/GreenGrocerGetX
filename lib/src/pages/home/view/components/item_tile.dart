import 'package:app/src/config/custom_colors.dart';
import 'package:app/src/models/item_model.dart';
import 'package:app/src/pages/cart/controller/cart_controller.dart';
import 'package:app/src/pages/product/product_screen.dart';
import 'package:app/src/pages_routes/app_pages.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ItemTile extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();

  final UtilsServices utilsServices = UtilsServices(); //Final tirar em
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  // Função responsável pela troca do icone de carrinho do card de produto
  Future<void> switchIcon() async {
    // Trocar o icone para o icone de check
    setState(() => tileIcon = Icons.check);
    // fazer o delay
    await Future.delayed(const Duration(milliseconds: 1000)); // Mais tempo resultara em erro
    // Alterar o icone para de adicionar ao carrinho de novo
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Conteudo
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            //   return ProductScreen(item: widget.item);
            // }));

            Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      // Implementação que funciona na versão add_cart_animation 0.0.7
                      child: Image.network( // asset: para imagen no projeto, network: para imagem da internet
                        widget.item.imgUrl,
                        key: imageGk,
                      ),

                      // Implementação que funciona na versão add_cart_animation 2.0.3
                      /*
                      child: Container(
                        key: imageGk,
                        child: Image.asset(
                          item.imgUrl,
                        ),
                      ),
                      */
                    ),
                  ),

                  // Nome
                  Text(widget.item.itemName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),

                  // Preço - Unidade
                  Row(
                    children: [
                      Text(utilsServices.priceToCurrency(widget.item.price),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwatchColor,
                          )),
                      Text('/${widget.item.unit}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        // Botão add carrinho
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  switchIcon();

                  cartController.addItemToCart(item: widget.item);

                  widget.cartAnimationMethod(imageGk);
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
