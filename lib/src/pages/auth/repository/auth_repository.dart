import '../../../constants/endpoints.dart';
import '../../../models/user_model.dart';
import '../../../services/http_manager.dart';
import '../result/auth_result.dart';
import 'auth_errors.dart' as authErrors;

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      // print('Signin funcionou!');
      //print(result['result']);

      final user = UserModel.fromJson(result[
          'result']); // Instanciando novo usuário. Recebendo dados da requisição e armazenando na variável.

      return AuthResult.success(user);

      //print(user);
    } else {
      //print('Signin não funcionou!');
      //print(result['error']);
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changePassword,
      method: HttpMethods.post,
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return result['error'] == null; 

  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
        url: Endpoints.resetPassword,
        method: HttpMethods.post,
        body: {'email': email});
  }
}
