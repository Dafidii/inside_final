import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/string_manager.dart';
import 'package:inside_1/presentation/resources/style_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';
import 'package:inside_1/presentation/signup/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => instance<SignupViewModel>(),
      child: Consumer<SignupViewModel>(
        builder: (BuildContext context, signupViewModel, Widget? child) {
          _emailController.addListener(
                  () => signupViewModel.setEmail(_emailController.text));
          _passwordController.addListener(
                  () => signupViewModel.setPassword(_passwordController.text));
          _usernameController.addListener(
                  () => signupViewModel.setUsername(_usernameController.text));

          Widget errorWidget() {
            if (signupViewModel.error != null) {
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
                  Text(signupViewModel.error!,
                      style: bodyMedium.copyWith(color: ColorManager.red)),
                ],
              );
            } else {
              return const SizedBox();
            }
          }

          return signupViewModel.currentState.getScreenWidget(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          Text(
                            AppStrings.createYourAccount,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: AppSize.s4),
                          Text(
                            AppStrings.createText,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorManager.gray8,
                                    ),
                          ),
                          const SizedBox(height: AppSize.s16),
                          errorWidget(),
                          const SizedBox(height: AppSize.s8),
                          Text(
                            AppStrings.usernameText,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorManager.gray12,
                                    ),
                          ),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: AppStrings.usernameSubText,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) => signupViewModel
                                .usernameValidator(_usernameController.text),
                          ),
                          const SizedBox(height: AppSize.s16),
                          Text(
                            AppStrings.emailText,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorManager.gray12,
                                    ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                labelText: AppStrings.emailSubText),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) => signupViewModel
                                .emailValidator(_emailController.text),
                          ),
                          const SizedBox(height: AppSize.s16),
                          Text(
                            AppStrings.passwordText,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorManager.gray12,
                                    ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: AppStrings.passwordSubText),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) => signupViewModel
                                .passwordValidator(_passwordController.text),
                          ),
                          const SizedBox(height: AppSize.s16),
                          const SizedBox(height: AppSize.s20),
                          ElevatedButton(
                            onPressed:
                                signupViewModel.isAllInputValid ? () {
                              signupViewModel.register();
                                } : null,
                            child: const Text(AppStrings.createAccount),
                          ),
                          const SizedBox(height: AppSize.s28),
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
                                  const TextSpan(text: AppStrings.already),
                                  TextSpan(
                                    text: AppStrings.signIn,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: ColorManager.secondary,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        GoRouter.of(context).pushNamed(
                                          AppPageRouteName.login,
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
            )),
          );
        },
      ),
    );
  }
}
