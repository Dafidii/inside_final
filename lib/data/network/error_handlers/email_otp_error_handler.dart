import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/data/network/failure.dart';

enum EmailOTPStatus{
  successful,
  invalidOTP,

  noInternetConnection,
  unknown,
}

class EmailOTPErrorHandler implements Exception {
  late Failure failure;

  EmailOTPErrorHandler.handle(dynamic error){
    if(error is FirebaseAuthException){
      failure = _handleError(error);
    } else {
    }
  }

  Failure _handleError(FirebaseAuthException error){
    switch(error.code){
      case EmailOTPResponseCode.noInternetConnection:
        return EmailOTPStatus.noInternetConnection.getFailure();
      case EmailOTPResponseCode.invalidOTP:
        return EmailOTPStatus.invalidOTP.getFailure();
      default:
        return EmailOTPStatus.unknown.getFailure();
    }
  }
}

extension EmailOTPStatusExtension on EmailOTPStatus {
  Failure getFailure(){
    switch(this){
      case EmailOTPStatus.noInternetConnection:
        return Failure(EmailOTPResponseCode.noInternetConnection, EmailOTPResponseMessage.noInternetConnection);
      case EmailOTPStatus.invalidOTP:
        return Failure(EmailOTPResponseCode.invalidOTP, EmailOTPResponseMessage.invalidOTP);
      case EmailOTPStatus.unknown:
        return Failure(EmailOTPResponseCode.unknown, EmailOTPResponseMessage.unknown);
      default:
        return Failure(EmailOTPResponseCode.unknown, EmailOTPResponseMessage.unknown);
    }
  }
}

class EmailOTPResponseCode{
  static const String successful = 'success';
  static const String invalidOTP = 'invalid-otp';

  static const String unknown = 'unknown';
  static const String noInternetConnection = 'no-internet-connection';
}

class EmailOTPResponseMessage{
  static const String successful = 'success';
  static const String invalidOTP = 'Invalid OTP. Please try again';

  static const String unknown = 'An error occurred. Please try again later.';
  static const String noInternetConnection = 'Check your internet connection';

}