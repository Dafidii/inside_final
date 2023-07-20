import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:inside_1/app/constants.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';

class ConnectivityState extends ChangeNotifier {
  Future<bool> get isConnected => InternetConnectionCheckerPlus().hasConnection;

  late StreamSubscription subscription;
  ConnectivityState() {
    subscription =
        InternetConnectionCheckerPlus().onStatusChange.listen((status) async {
      bool isDeviceConnected =
          await InternetConnectionCheckerPlus().hasConnection;
      if (!isDeviceConnected) {
        scaffoldKey.currentState!.showMaterialBanner(
          MaterialBanner(
            backgroundColor: ColorManager.red,
            leading: SvgPicture.asset(
              IconsAsset.cloudOffline,
              colorFilter: ColorFilter.mode(
                ColorManager.backgroundColor,
                BlendMode.srcIn,
              ),
            ),
            content: const Text('You are currently offline'),
            contentTextStyle: TextStyle(color: ColorManager.backgroundColor),
            actions: const [
              SizedBox(),
            ],
          ),
        );
      } else {
        scaffoldKey.currentState!.hideCurrentMaterialBanner();
      }
    });
  }
}
