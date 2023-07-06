import 'package:flutter/material.dart';

import '../../config/custom_colors.dart';
import '../common_widgets/app_name_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  // Antes usado para demorar um tempo e navegar para signin!
  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(const Duration(seconds: 2), () {
  //     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c){
  //     //   return const SignInScreen();
  //     // }));
  //     Get.offNamed(PagesRoutes.signInRoute);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppNameWidget(
              greenTitleColor: Colors.white,
              textSize: 40,
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
