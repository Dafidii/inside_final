import 'dart:io';

class RegisterRequest {
  String email;
  String password;

  RegisterRequest(this.email, this.password);
}

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class AddImageToStoreRequest {
  String storeId;
  String productId;
  String path;
  File imageFile;
  
  AddImageToStoreRequest(this.path, this.storeId, this.productId, this.imageFile);
}