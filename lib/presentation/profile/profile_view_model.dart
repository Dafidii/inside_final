import 'package:flutter/cupertino.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/provider/auth_provider.dart';
import 'package:inside_1/domain/provider/connectivity.dart';
import 'package:inside_1/domain/use_case/get_user_info_use_case.dart';
import 'package:inside_1/domain/use_case/sign_out_use_case.dart';
import 'package:inside_1/presentation/base/base_view_model.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';

class ProfileViewModel extends BaseViewModel with ProfileViewModelInputs, ProfileViewModelOutputs {
  final SignOutUseCase _signOutUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;

  ProfileViewModel(this._signOutUseCase, this._getUserInfoUseCase);

  @override
  signOut() async {
    if (await instance<ConnectivityState>().isConnected) {
      (await _signOutUseCase.execute(null))
          .fold((failure) => _failureCatcher(failure), (success) => debugPrint(success.message));
    }}


  _failureCatcher(Failure failure) {
    debugPrint(failure.message);
    if (failure.message == 'Check your internet connection') {
      setCurrentState(ContentState(
          stateRendererType: StateRendererType.fullScreenContentState));
    } else {
      setCurrentState(ContentState(
          stateRendererType: StateRendererType.fullScreenContentState));
    }
  }

  @override
  Stream<UsersInfo> get userInfoStream => _getUserInfoUseCase.execute(GetUserInfoUseCaseInputs(instance<AuthState>().userUid));
}

mixin ProfileViewModelInputs {
  signOut();
}

mixin ProfileViewModelOutputs {
  Stream<UsersInfo> get userInfoStream;
}