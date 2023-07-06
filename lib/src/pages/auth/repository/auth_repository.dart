import '../../../constants/endpoints.dart';
import '../../../models/user_model.dart';
import '../../../services/http_manager.dart';
import '../result/auth_result.dart';
import 'auth_errors.dart' as authErrors;

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token' : token,
      }
    );

    if(result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
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
}
