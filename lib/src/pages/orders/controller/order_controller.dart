import 'package:app/src/models/cart_item_model.dart';
import 'package:app/src/models/order_model.dart';
import 'package:app/src/pages/auth/controller/auth_controller.dart';
import 'package:app/src/pages/orders/orders_result/orders_result.dart';
import 'package:app/src/pages/orders/repository/orders_repository.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController(this.order);

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  bool isLoading = false;

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    
    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    
    setLoading(false);
    
    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utilsServices.showFlutterToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
