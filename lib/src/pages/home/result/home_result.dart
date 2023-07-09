
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_result.freezed.dart';

// Comando no TERMINAL para criar o freezed: flutter pub run build_runner watch --delete-conflicting-outputs
@freezed 
class HomeResult<T> with _$HomeResult {
  factory HomeResult.success(List<T> data ) = Success;
  factory HomeResult.error(String message) = Error;
}