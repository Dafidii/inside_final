import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inside_1/app/constants.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();

  String getTitle();

  String getCallbackButtonText();

  VoidCallbackAction? getRetryActionFunction;
  VoidCallback? callback;
}

class ContentState extends FlowState {
  StateRendererType stateRendererType;

  ContentState({required this.stateRendererType});

  @override
  String getMessage() => kEmpty;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => kEmpty;

  @override
  String getCallbackButtonText() => kEmpty;
}

class SuccessState extends FlowState {
  StateRendererType stateRendererType;
  String title;
  String message;
  String callbackButtonText;
  VoidCallback? buttonCallback;

  SuccessState(
      {required this.stateRendererType,
        String? title,
        String? message,
        String? callbackButtonText,
        this.buttonCallback})
      : message = message ?? kEmpty,
        title = title ?? kEmpty,
        callbackButtonText = callbackButtonText ?? kEmpty;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => title;

  @override
  String getCallbackButtonText() => callbackButtonText;

  @override
  VoidCallback? get callback => buttonCallback;
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => kEmpty;

  @override
  String getCallbackButtonText() => kEmpty;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => kEmpty;

  @override
  String getCallbackButtonText() => kEmpty;
}

bool _bannerIsOut = false;
bool get bannerIsOut => _bannerIsOut;
set bannerIsOut(bool value) {
  _bannerIsOut = value;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget) {
    switch (runtimeType) {
      case LoadingState:
        {
          // dismissBanner(context);
          // dismissSnackBar(context);
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            contentScreenWidget: contentScreenWidget,
          );
        }
      case ContentState:
        {
          // debugPrint(bannerIsOut.toString());
          if (bannerIsOut) {
            // debugPrint(_bannerIsOut.toString());
            // dismissBanner(context);
          }
          // dismissSnackBar(context);
          return contentScreenWidget;
        }
      case SuccessState:
        {
          // dismissBanner(context);
          // dismissSnackBar(context);
          if (getStateRendererType() ==
              StateRendererType.fullScreenSuccessState) {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              contentScreenWidget: contentScreenWidget,
              message: getMessage(),
              title: getTitle(),
              callbackButtonText: getCallbackButtonText(),
              callback: callback,
            );
          } else {
            // debugPrint('Hello');
            bannerIsOut = true;
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              contentScreenWidget: contentScreenWidget,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          // dismissBanner(context);
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              contentScreenWidget: contentScreenWidget,
              message: getMessage());
        }
      default:
        return contentScreenWidget;
    }
  }

  showBanner(StateRendererType stateRendererType, String message) {
    switch (stateRendererType) {
      case StateRendererType.bannerSuccessState:
        _showMaterialBanner(ColorManager.green, IconsAsset.checkmark, message);
      case StateRendererType.bannerErrorState:
        _showMaterialBanner(ColorManager.red, IconsAsset.errorCircleRegular, message);
      default:
      // default
    }
  }

  _showMaterialBanner(Color backgroundColor, String icon, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scaffoldKey.currentState?.showMaterialBanner(
        MaterialBanner(
          backgroundColor: backgroundColor,
          leading: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              ColorManager.backgroundColor,
              BlendMode.srcIn,
            ),
          ),
          content: Text(message),
          contentTextStyle: TextStyle(color: ColorManager.backgroundColor),
          actions: const [
            SizedBox(),
          ],
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        scaffoldKey.currentState?.hideCurrentMaterialBanner();
      });
    });
  }
}
