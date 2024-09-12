import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData _data;
  static late double infinityWidth;
  static late double infinityHeight;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  void init(BuildContext context) {
    _data = MediaQuery.of(context);
    infinityWidth = double.infinity;
    infinityHeight = double.infinity;
    screenWidth = _data.size.width;
    screenHeight = _data.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal = _data.padding.left + _data.padding.right;
    _safeAreaVertical = _data.padding.top + _data.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
