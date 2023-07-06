import 'package:app/src/constants/storage_keys.dart';
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

  Future<void> validateToken() async {
    // Recuperar o token que já foi salvo
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (messsage) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // Zerar o user
    user = UserModel();

    // Remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);

    // Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);

  }

  void saveTokenAndProceedToBase() {
    // Salvar o token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    // Ir para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
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

        saveTokenAndProceedToBase();

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
