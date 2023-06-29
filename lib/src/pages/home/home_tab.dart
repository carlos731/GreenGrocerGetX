import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/custom_colors.dart';
import '../common_widgets/app_name_widget.dart';
import '../common_widgets/custom_shimmer.dart';
import 'components/category_tile.dart';
import 'package:app/src/config/app_data.dart' as appData;

import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  //Para mater a homeTab sempre viva, corrigindo o bug de mudança de tela
  @override
  bool get wantKeepAlive => true;

  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  
    Future.delayed(const Duration(seconds: 2), 
    (){
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        //Badge
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                backgroundColor: CustomColors.customContrastColor,
                label: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: AddToCartAnimation(
        // para versão 0.0.7 apresentada nas aulas do curso:
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },

        /* 
        //para versão 2.0.3 
        cartKey: globalKeyCartItems,
        createAddToCartAnimation: (addToCartAnimationMethod) {
          runAddToCartAnimation = addToCartAnimationMethod;
        },
        jumpAnimation: const JumpAnimationOptions(
          curve: Curves.ease,
          duration: Duration(
            millisseconds: 100,
          ),
        ),
        */

        child: Column(
          children: [
            // Campos pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    hintText: 'Pesquise aqui...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: CustomColors.customContrastColor,
                      size: 21,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ))),
              ),
            ),

            // Categorias
            Container(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              height: 40,
              child: !isLoading ? ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCategory = appData.categories[index];
                      });
                    },
                    category: appData.categories[index],
                    isSelected: appData.categories[index] == selectedCategory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: appData.categories.length,
              ) : ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) => Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 12),
                    child: CustomShimmer(
                      height: 20,
                      width: 60,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),)
              ),
            ),

            // Grid
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemCount: appData.items.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: appData.items[index],
                          cartAnimationMethod: itemSelectedCartAnimations,
                        );
                      },
                    )
                  : GridView.count(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(10, (index) => CustomShimmer(
                          height: double.infinity,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(20),
                        ),),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
