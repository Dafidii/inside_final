import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/use_case/get_exhibitions_use_case.dart';
import 'package:inside_1/presentation/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final GetExhibitionsUseCase _getExhibitionsUseCase;

  HomeViewModel(this._getExhibitionsUseCase);

  @override
  Stream<List<Exhibition>> get exhibitionsStream =>
      _getExhibitionsUseCase.execute();
}

mixin HomeViewModelInputs {}

mixin HomeViewModelOutputs {
  Stream<List<Exhibition>> get exhibitionsStream;
}
