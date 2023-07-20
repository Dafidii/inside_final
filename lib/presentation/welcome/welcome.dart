import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/string_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Image.asset(
              ImagesAsset.welcome,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.welcomeTitleText,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorManager.secondary),
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  AppStrings.welcomeSubText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: AppSize.s72,
                ),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).goNamed(AppPageRouteName.signup);
                    },
                    child: const Text(AppStrings.getStarted)),
                const SizedBox(
                  height: AppSize.s16,
                ),
                OutlinedButton(
                  onPressed: () {
                    GoRouter.of(context).goNamed(AppPageRouteName.login);
                  },
                  child: const Text(AppStrings.alreadyHaveAnAccount),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
