import '../core/logic_helper/import_all.dart';

class BaseViewModel extends Model {
  ViewState _state = ViewState.Initial;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void updateView() {
    notifyListeners();
  }
}
