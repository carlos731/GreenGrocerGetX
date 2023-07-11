import 'package:app/src/pages/base/controller/navigation_controller.dart';
import 'package:app/src/pages/cart/view/cart_tab.dart';
import 'package:app/src/pages/home/view/home_tab.dart';
import 'package:app/src/pages/orders/orders_tab.dart';
import 'package:app/src/pages/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  //int currentIndex = 0;
  //final pageController = PageController();

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Páginas
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),

      //BottomNavigation
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: navigationController.currentIndex,
            onTap: (index) {
              navigationController.navigatePageView(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(100),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Carrinho',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Pedidos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'perfil',
              ),
            ],
          )),
    );

    /*
      bottomNavigationBar: Obx(() => ) BottomNavigationBar(
        currentIndex: navigationController.currentIndex,
        onTap: (index) {
          //setState(() {
            currentIndex = index;
            pageController.jumpToPage(index); // Faz com que quando clicar num bottom ele pule para proxima pagina.
            //pageController.animateToPage( // Faz acontecer uma animação quando clica num botão arrastando para próxima página.
              //index,
              //duration: const Duration(milliseconds: 500),
              //curve: Curves.ease,
            //);
          //});
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Carrinho'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: 'perfil'),
        ],
      ),
    */
  }
}
