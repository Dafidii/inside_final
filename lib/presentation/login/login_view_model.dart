import 'package:inside_1/app/constants.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/domain/provider/connectivity.dart';
import 'package:inside_1/domain/use_case/login_use_case.dart';
import 'package:inside_1/presentation/base/base_view_model.dart';
import 'package:inside_1/presentation/common/freezed_data_classes.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  LoginObject loginObject = LoginObject('', '');

  final LoginUseCase _loginUseCase;

  String? _error;

  LoginViewModel(this._loginUseCase);

  @override
  login() async {
    if (await instance<ConnectivityState>().isConnected) {
      setCurrentState(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));

      (await _loginUseCase.execute(
          LoginUseCaseInputs(loginObject.email, loginObject.password)))
          .fold((failure) => _failureCatcher(failure), (success) => success);
    }
  }

  @override
  setPassword(String password) {
    loginObject = loginObject.copyWith(password: password);
    notifyListeners();
  }

  @override
  setEmail(String email) {
    loginObject = loginObject.copyWith(email: email);
    notifyListeners();
  }

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
    } else {
      return null;
    }
  }

  bool _isAllInputValid() => (emailValidator(loginObject.email) == null &&
          passwordValidator(loginObject.password) == null)
      ? true
      : false;

  @override
  bool get isAllInputValid => _isAllInputValid();

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

  @override
  String? get error => _error;

  _setError(String? message) {
    _error = message;
    notifyListeners();
  }
}

mixin LoginViewModelInputs {
  login();

  setPassword(String password);
  setEmail(String email);
}

mixin LoginViewModelOutputs {
  String? emailValidator(String email);
  String? passwordValidator(String password);

  bool get isAllInputValid;

  String? get error;
}
