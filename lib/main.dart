import 'package:app/src/pages/auth/controller/auth_controller.dart';
import 'package:app/src/pages_routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ter certeza que está inicializado

  // Comandos para controlar a orientação de tela: app deitado ou em pé.
  SystemChrome.setPreferredOrientations([
    //DeviceOrientation.landscapeRight,
    //DeviceOrientation.landscapeLeft,
    //DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });

  Get.put(AuthController()); // Injeção de dependência

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,
      //home: const SplashScreen(), // Não usa mais isso
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
