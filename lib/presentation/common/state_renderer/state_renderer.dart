import 'package:flutter/material.dart';
import 'package:inside_1/app/constants.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';

enum StateRendererType {
  bannerErrorState,
  bannerSuccessState,

  snackBarSuccessState,

  fullScreenContentState,
  fullScreenLoadingState,
  fullScreenOverlayLoadingState,
  fullScreenSuccessState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String title;
  final String message;
  final String callbackButtonText;
  final VoidCallback? retryActionFunction;
  final VoidCallback? callback;
  final Widget contentScreenWidget;

  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    String? title,
    String? message,
    this.contentScreenWidget = const SizedBox(),
    this.retryActionFunction,
    this.callback,
    String? callbackButtonText,
  })  : title = title ?? kEmpty,
        message = message ?? kEmpty,
        callbackButtonText = callbackButtonText ?? kEmpty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.fullScreenOverlayLoadingState:
        return _getOpacityStack(
            contentScreenWidget,
            const Center(
              child: SizedBox(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  child: CircularProgressIndicator()),
            ));
      case StateRendererType.fullScreenLoadingState:
        return _getStack(
            contentScreenWidget, const Center(
              child: SizedBox(
              width: AppSize.s40,
              height: AppSize.s40,
              child: CircularProgressIndicator()),
            ));
      case StateRendererType.fullScreenContentState:
        return contentScreenWidget;
      // case StateRendererType.fullScreenSuccessState:
      //   return _getStack(
      //       contentScreenWidget,
      //       _getItemsInColumn([
      //         _getAnimatedSuccess(),
      //         _getTitle(context, title),
      //         _getMessage(context, message),
      //         _getButton(callback, callbackButtonText)
      //       ]));
      default:
        return Container();
    }
  }

  Widget _getTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Center(
          child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _getMessage(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p8, horizontal: AppPadding.p16),
      child: Center(
          child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: ColorManager.gray6),
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _getOpacityStack(Widget bottom, Widget top) {
    return Stack(
      children: [
        bottom,
        Opacity(
          opacity: 0.8,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: ColorManager.backgroundColor,
            child: top,
          ),
        )
      ],
    );
  }

  Widget _getStack(Widget bottom, Widget top) {
    return Stack(
      children: [
        bottom,
        Container(
          width: double.infinity,
          height: double.infinity,
          color: ColorManager.backgroundColor,
          child: top,
        )
      ],
    );
  }
}
