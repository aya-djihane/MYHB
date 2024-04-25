import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UiProvider extends ChangeNotifier {
 bool _isDark = false;
 bool get isDark =>_isDark;
 changeThem(){
   _isDark= !isDark;
   notifyListeners();
 }
}