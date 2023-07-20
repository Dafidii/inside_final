import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String email,
      String password,
      String username) = _RegisterObject;
}
