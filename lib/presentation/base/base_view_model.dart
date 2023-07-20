import 'package:flutter/foundation.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends ChangeNotifier with BaseViewModelInputs, BaseViewModelOutputs {

  FlowState _currentState = ContentState(stateRendererType: StateRendererType.fullScreenContentState);

  @override
  FlowState get currentState => _currentState;

  @override
  setCurrentState(FlowState flowState) {
    _currentState = flowState;
    Future.delayed(Duration.zero, () => notifyListeners());
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }

}

mixin BaseViewModelInputs {

  setCurrentState(FlowState flowState);

  void start();

  void disposeValues();
}

mixin BaseViewModelOutputs {
  FlowState get currentState;
}

