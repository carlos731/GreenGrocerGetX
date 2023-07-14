import 'package:app/src/pages/orders/controller/all_orders_controller.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
  Get.put(AllOrdersController());
  //   Get.lazyPut( // Para carregar os dados automaticamente sempre que abrir a tela
  //     () => AllOrdersController(),
  //     fenix: true,
  //   );
  }
}
