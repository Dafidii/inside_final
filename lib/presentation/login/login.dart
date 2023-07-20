import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:inside_1/presentation/login/login_view_model.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/string_manager.dart';
import 'package:inside_1/presentation/resources/style_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => instance<LoginViewModel>(),
      child: Consumer<LoginViewModel>(
        builder: (BuildContext context, loginViewModel, Widget? child) {
          _emailController.addListener(
                  () => loginViewModel.setEmail(_emailController.text));
          _passwordController.addListener(
                  () => loginViewModel.setPassword(_passwordController.text));

          Widget errorWidget() {
            if (loginViewModel.error != null) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconsAsset.errorCircleRegular,
                    colorFilter:
                    ColorFilter.mode(ColorManager.red, BlendMode.srcIn),
                    width: AppSize.s32,
                    height: AppSize.s32,
                  ),
                  const SizedBox(width: AppSize.s16),
                  Text(loginViewModel.error!,
                      style: bodyMedium.copyWith(color: ColorManager.red)),
                ],
              );
            } else {
              return const SizedBox();
            }
          }

          return loginViewModel.currentState.getScreenWidget(
            context,
            Scaffold(
              appBar: const PreferredSize(
                  preferredSize: Size.zero,
                  child: SizedBox(
                    height: double.infinity,
                  )),
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: SafeArea(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            Text(
                              AppStrings.signIntoYourAccount,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: AppSize.s4),
                            Text(
                              AppStrings.loginText,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: ColorManager.gray8,
                              ),
                            ),
                            const SizedBox(height: AppSize.s16),
                            errorWidget(),
                            const SizedBox(height: AppSize.s8),
                            Text(
                              AppStrings.emailText,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: ColorManager.gray12,
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  labelText: AppStrings.emailSubText),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (_) => loginViewModel
                                  .emailValidator(_emailController.text),
                            ),
                            const SizedBox(height: AppSize.s16),
                            Text(
                              AppStrings.passwordText,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: ColorManager.gray12,
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  labelText: AppStrings.passwordSubText),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (_) => loginViewModel
                                  .passwordValidator(_passwordController.text),
                            ),
                            const SizedBox(height: AppSize.s20),
                            ElevatedButton(
                                onPressed: loginViewModel.isAllInputValid ? () {
                                  loginViewModel.login();
                                } : null,
                                child: const Text(AppStrings.signIn)),
                            const SizedBox(height: AppSize.s16),
                            Center(
                              child: Text(
                                AppStrings.forgot,
                                style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: ColorManager.gray12,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSize.s20),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                    color: ColorManager.gray12,
                                  ),
                                  children: [
                                    const TextSpan(text: AppStrings.doYou),
                                    TextSpan(
                                      text: AppStrings.signUp,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                        color: ColorManager.secondary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          GoRouter.of(context).pushNamed(
                                            AppPageRouteName.signup,
                                          );
                                        },
                                    ),
                                  ],
                                ),
                                textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }
}
