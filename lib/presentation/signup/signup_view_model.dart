import 'package:flutter/foundation.dart';
import 'package:inside_1/app/constants.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/app/extensions.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/domain/provider/connectivity.dart';
import 'package:inside_1/domain/use_case/create_user_use_case.dart';
import 'package:inside_1/domain/use_case/register_use_case.dart';
import 'package:inside_1/presentation/base/base_view_model.dart';
import 'package:inside_1/presentation/common/freezed_data_classes.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';

class SignupViewModel extends BaseViewModel
    with SignupViewModelInputs, SignupViewModelOutputs {
  RegisterObject registerObject = RegisterObject('', '', '');

  final RegisterUseCase _registerUseCase;
  final CreateUserUseCase _createUserUseCase;

  String? _error;

  SignupViewModel(this._registerUseCase, this._createUserUseCase);

  @override
  register() async {
    if (await instance<ConnectivityState>().isConnected) {
      _setError(null);

      setCurrentState(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));

      (await _registerUseCase.execute(RegisterUseCaseInputs(
              registerObject.email, registerObject.password)))
          .fold((failure) => _failureCatcher(failure), (user) async {
        (await _createUserUseCase.execute(
          CreateUserUseCaseInputs(
            uid: user.uid,
            username: registerObject.username.capitalise(),
            email: registerObject.email,
          ),
        ))
            .fold(
          (failure) {
            debugPrint(failure.message);
          },
          (success) => debugPrint(success.message),
        );
      });
    }
  }

  @override
  setEmail(String email) {
    registerObject = registerObject.copyWith(email: email);
    notifyListeners();
  }

  @override
  setPassword(String password) {
    registerObject = registerObject.copyWith(password: password);
    notifyListeners();
  }

  @override
  setUsername(String username) {
    registerObject = registerObject.copyWith(username: username);
    notifyListeners();
  }

  @override
  String? get error => _error;

  @override
  bool get isAllInputValid => _isAllInputValid();

  @override
  String? emailValidator(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!kEmailRegExp.hasMatch(email)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  @override
  String? passwordValidator(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    } else if (!kPasswordRegExp.hasMatch(password)) {
      return 'Password must contain:\n\t\tAt least one uppercase\n\t\tAt least one lowercase\n\t\tAt least one number\n\t\tAt least one symbol\n\t\tMinimum of 8 characters.';
    } else {
      return null;
    }
  }

  @override
  String? usernameValidator(String username) {
    if (!kNameRegExp.hasMatch(username)) {
      return 'Enter a valid username';
    } else if (username.isEmpty) {
      return 'Please enter your username';
    } else {
      return null;
    }
  }

  bool _isAllInputValid() =>
      (usernameValidator(registerObject.username) == null &&
              emailValidator(registerObject.email) == null &&
              passwordValidator(registerObject.password) == null)
          ? true
          : false;

  _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  _failureCatcher(Failure failure, {bool setError = true}) {
    if (failure.message == 'Check your internet connection') {
      setCurrentState(ContentState(
          stateRendererType: StateRendererType.fullScreenContentState));
    } else {
      setCurrentState(ContentState(
          stateRendererType: StateRendererType.fullScreenContentState));
      setError ? _setError(failure.message) : null;
    }
  }
}

mixin SignupViewModelInputs {
  register();

  setUsername(String username);
  setEmail(String email);
  setPassword(String password);
}

mixin SignupViewModelOutputs {
  String? usernameValidator(String username);
  String? emailValidator(String email);
  String? passwordValidator(String password);

  bool get isAllInputValid;

  String? get error;
}
