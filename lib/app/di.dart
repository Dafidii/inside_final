import 'package:get_it/get_it.dart';
import 'package:inside_1/data/data_source/remote/firebase_auth_remote_data_source.dart';
import 'package:inside_1/data/data_source/remote/firestore_exhibitions_remote_data_source.dart';
import 'package:inside_1/data/data_source/remote/firestore_user_remote_data_source.dart';
import 'package:inside_1/data/network/app_api/firebase_auth_service.dart';
import 'package:inside_1/data/network/app_api/firestore_exhibitions_service.dart';
import 'package:inside_1/data/network/app_api/firestore_user_service.dart';
import 'package:inside_1/data/network/network_info.dart';
import 'package:inside_1/data/repository/firebase_auth_repository_impl.dart';
import 'package:inside_1/data/repository/firestore_exhibitions_repository_impl.dart';
import 'package:inside_1/data/repository/firestore_user_repository_impl.dart';
import 'package:inside_1/domain/provider/auth_provider.dart';
import 'package:inside_1/domain/provider/connectivity.dart';
import 'package:inside_1/domain/repositories/firebase_auth_repository.dart';
import 'package:inside_1/domain/repositories/firestore_exhibitions_repository.dart';
import 'package:inside_1/domain/repositories/firestore_user_repository.dart';
import 'package:inside_1/domain/use_case/create_user_use_case.dart';
import 'package:inside_1/domain/use_case/get_exhibitions_use_case.dart';
import 'package:inside_1/domain/use_case/get_user_info_use_case.dart';
import 'package:inside_1/domain/use_case/login_use_case.dart';
import 'package:inside_1/domain/use_case/register_use_case.dart';
import 'package:inside_1/domain/use_case/sign_out_use_case.dart';
import 'package:inside_1/presentation/home/home_view_model.dart';
import 'package:inside_1/presentation/login/login_view_model.dart';
import 'package:inside_1/presentation/profile/profile_view_model.dart';
import 'package:inside_1/presentation/signup/signup_view_model.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionCheckerPlus()));

  instance.registerLazySingleton<FirebaseAuthServiceClient>(
          () => FirebaseAuthServiceClient());
  instance.registerLazySingleton<FirebaseAuthRemoteDataSource>(
          () => FirebaseAuthRemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<FirebaseAuthRepository>(
          () => FirebaseAuthRepositoryImpl(instance(), instance()));


  instance.registerLazySingleton<FirestoreUserServiceClient>(
          () => FirestoreUserServiceClient());
  instance.registerLazySingleton<FirestoreUserRemoteDataSource>(
          () => FirestoreUserRemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<FirestoreUserRepository>(
          () => FirestoreUserRepositoryImpl(instance(), instance()));

  instance.registerLazySingleton<FirestoreExhibitionsServiceClient>(
          () => FirestoreExhibitionsServiceClient());
  instance.registerLazySingleton<FirestoreExhibitionsRemoteDataSource>(
          () => FirestoreExhibitionsRemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<FirestoreExhibitionsRepository>(
          () => FirestoreExhibitionsRepositoryImpl(instance(), instance()));


  instance.registerLazySingleton<GetExhibitionsUseCase>(
          () => GetExhibitionsUseCase(instance()));

  instance.registerSingleton<AuthState>(AuthState());
  instance.registerSingleton<ConnectivityState>(ConnectivityState());

  initHomeModule();
  initProfileModule();
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initSignupModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<CreateUserUseCase>(() => CreateUserUseCase(instance()));
    instance.registerFactory<SignupViewModel>(() => SignupViewModel(instance(), instance()));
  }
}

initProfileModule() {
  if (!GetIt.I.isRegistered<ProfileViewModel>()) {
    instance.registerFactory<SignOutUseCase>(() => SignOutUseCase(instance()));

    instance.registerFactory<GetUserInfoUseCase>(
            () => GetUserInfoUseCase(instance()));

    instance.registerFactory<ProfileViewModel>(
            () => ProfileViewModel(instance(), instance(),));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeViewModel>()) {
    instance.registerFactory<HomeViewModel>(
            () => HomeViewModel(instance()));
  }
}