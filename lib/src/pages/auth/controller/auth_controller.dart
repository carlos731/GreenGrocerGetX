import 'package:app/src/pages_routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../services/utils_services.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  Future<void> validateToken() async{
    // Recuperar o token que já foi salvo
    // authRepository.validateToken(token);
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    //await Future.delayed(const Duration(seconds: 2)); // criado antes para fazer o delay de 2 segundos para duração do circular progress do botão!

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        Get.offAllNamed(PagesRoutes.baseRoute);
        print(user);
      },
      error: (message) {
        utilsServices.showFlutterToast(
          message: message,
          isError: true,
        );
        print(message);
      },
    );
  }
}
