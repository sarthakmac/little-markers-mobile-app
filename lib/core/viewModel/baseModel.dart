import 'package:flutter/widgets.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/appError.dart';

class BaseModel extends ChangeNotifier {

  ViewState _state = ViewState.IDLE;
  ViewState get state => _state;

  ApiError error;

  /// Returns true when a request did not return an error.
  bool get success => error == null;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  bool isNotError(dynamic response) {
    if (response is ApiError) {
      error = response;
      return false;
    } else {
      return true;
    }
  }
}
