import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/user_model.dart';

// Rodar o comando para gerar o arquivo: flutter pub run build_runner build
part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult.success(UserModel user) = Success;
  factory AuthResult.error(String message) = Error;
}
