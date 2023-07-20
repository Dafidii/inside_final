import 'package:flutter/material.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:inside_1/presentation/profile/profile_view_model.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/string_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => instance<ProfileViewModel>(),
      child: Consumer<ProfileViewModel>(
        builder: (BuildContext context, profileViewModel, Widget? child) {
          return profileViewModel.currentState.getScreenWidget(
            context,
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ColorManager.red,
                        // backgroundColor: ColorManager.red,
                        side: BorderSide(
                          color: ColorManager.red,
                        ),
                      ),
                      onPressed: () {
                        profileViewModel.signOut();
                      },
                      child: const Text(AppStrings.signOut),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
