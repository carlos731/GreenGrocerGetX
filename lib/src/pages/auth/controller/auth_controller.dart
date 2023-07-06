import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    await authRepository.signIn(email: email, password: password);

    //await Future.delayed(const Duration(seconds: 2)); // criado antes para fazer o delay de 2 segundos para duração do circular progress do botão!

    isLoading.value = false;
  }
}
