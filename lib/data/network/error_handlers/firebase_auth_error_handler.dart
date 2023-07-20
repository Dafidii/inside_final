import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/data/network/failure.dart';

enum FirebaseAuthStatus{
  successful,

  // email and password
  invalidEmail,
  // sign in
  wrongPassword,
  userDisabled,
  userNotFound,
  //create account
  emailAlreadyInUse,
  operationNotAllowed,
  weakPassword,

  noInternetConnection,
  networkRequestFailed,
  userAlreadyExist,
  unknown,
}

class FirebaseAuthErrorHandler implements Exception {
  late Failure failure;

  FirebaseAuthErrorHandler.handle(dynamic error){
    if(error is FirebaseAuthException){
      failure = _handleError(error);
    } else {
    }
  }

  Failure _handleError(FirebaseAuthException error){
    switch(error.code){
      case FirebaseAuthResponseCode.invalidEmail:
        return FirebaseAuthStatus.invalidEmail.getFailure();
      case FirebaseAuthResponseCode.wrongPassword:
        return FirebaseAuthStatus.wrongPassword.getFailure();
      case FirebaseAuthResponseCode.userDisabled:
        return FirebaseAuthStatus.userDisabled.getFailure();
      case FirebaseAuthResponseCode.userNotFound:
        return FirebaseAuthStatus.userNotFound.getFailure();
      case FirebaseAuthResponseCode.emailAlreadyInUse:
        return FirebaseAuthStatus.emailAlreadyInUse.getFailure();
      case FirebaseAuthResponseCode.operationNotAllowed:
        return FirebaseAuthStatus.operationNotAllowed.getFailure();
      case FirebaseAuthResponseCode.weakPassword:
        return FirebaseAuthStatus.weakPassword.getFailure();
      case FirebaseAuthResponseCode.noInternetConnection:
        return FirebaseAuthStatus.noInternetConnection.getFailure();
      case FirebaseAuthResponseCode.networkRequestFailed:
        return FirebaseAuthStatus.networkRequestFailed.getFailure();
      case FirebaseAuthResponseCode.userAlreadyExist:
        return FirebaseAuthStatus.userAlreadyExist.getFailure();
      default:
        return FirebaseAuthStatus.unknown.getFailure();
    }
  }
}

extension FirebaseAuthStatusExtension on FirebaseAuthStatus {
  Failure getFailure(){
    switch(this){
      case FirebaseAuthStatus.invalidEmail:
        return Failure(FirebaseAuthResponseCode.invalidEmail, FirebaseAuthResponseMessage.invalidEmail);
      case FirebaseAuthStatus.wrongPassword:
        return Failure(FirebaseAuthResponseCode.wrongPassword, FirebaseAuthResponseMessage.wrongPassword);
      case FirebaseAuthStatus.userDisabled:
        return Failure(FirebaseAuthResponseCode.userDisabled, FirebaseAuthResponseMessage.userDisabled);
      case FirebaseAuthStatus.userNotFound:
        return Failure(FirebaseAuthResponseCode.userNotFound, FirebaseAuthResponseMessage.userNotFound);
      case FirebaseAuthStatus.emailAlreadyInUse:
        return Failure(FirebaseAuthResponseCode.emailAlreadyInUse, FirebaseAuthResponseMessage.emailAlreadyInUse);
      case FirebaseAuthStatus.operationNotAllowed:
        return Failure(FirebaseAuthResponseCode.operationNotAllowed, FirebaseAuthResponseMessage.operationNotAllowed);
      case FirebaseAuthStatus.weakPassword:
        return Failure(FirebaseAuthResponseCode.weakPassword, FirebaseAuthResponseMessage.weakPassword);
      case FirebaseAuthStatus.noInternetConnection:
        return Failure(FirebaseAuthResponseCode.noInternetConnection, FirebaseAuthResponseMessage.noInternetConnection);
      case FirebaseAuthStatus.networkRequestFailed:
        return Failure(FirebaseAuthResponseCode.networkRequestFailed, FirebaseAuthResponseMessage.networkRequestFailed);
      case FirebaseAuthStatus.userAlreadyExist:
        return Failure(FirebaseAuthResponseCode.userAlreadyExist, FirebaseAuthResponseMessage.userAlreadyExist);
      case FirebaseAuthStatus.unknown:
        return Failure(FirebaseAuthResponseCode.unknown, FirebaseAuthResponseMessage.unknown);
      default:
        return Failure(FirebaseAuthResponseCode.unknown, FirebaseAuthResponseMessage.unknown);
    }
  }
}

class FirebaseAuthResponseCode{
  static const String successful = 'success';

  // email and password response codes
  static const String invalidEmail = 'invalid-email';
  // sign in
  static const String wrongPassword = 'wrong-password';
  static const String userDisabled = 'user-disabled';
  static const String userNotFound = 'user-not-found';
  // create account
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String weakPassword = 'weak-password';


  static const String unknown = 'unknown';
  static const String noInternetConnection = 'no-internet-connection';
  static const String networkRequestFailed = 'network-request-failed';
  static const String userAlreadyExist = 'user-already-exist';
}

class FirebaseAuthResponseMessage{
  static const String successful = 'success';

  // email and password response codes
  static const String invalidEmail = 'Email is not valid';
  // sign in
  static const String wrongPassword = 'Incorrect email or password';
  static const String userDisabled = 'This user is disabled';
  static const String userNotFound = 'Incorrect email or password';
  // create account
  static const String emailAlreadyInUse = 'This email is already in use';
  static const String operationNotAllowed = 'Email/Password account in firebase console is not enabled';
  static const String weakPassword = 'The password entered is weak';


  static const String unknown = 'An error occurred. Please try again later.';
  static const String noInternetConnection = 'Check your internet connection';
  static const String networkRequestFailed = 'Check your internet connection';
  static const String userAlreadyExist = 'User already exist !!!';

}