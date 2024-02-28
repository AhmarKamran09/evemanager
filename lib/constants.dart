import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color lightBlue = Colors.lightBlue;
const Color black = Colors.black;

class PageNames {
  static const String LogInScreen = "LogInScreen";
  static const String SignUpScreen = "SignUpScreen";
  static const String UserProfilePage = "UserProfilePage";
  static const String HomeScreen = "HomeScreen";
  static const String LoadingScreen = "LoadingScreen";
  static const String AddPaymentMethodScreen = "AddPaymentMethodScreen";
  static const String AddMarriageHallScreen = "AddMarriageHallScreen";
 static const String UpdateMarriageHallScreen =   "UpdateMarriageHallScreen";
 
}

void DisplayToast(String message) {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16);
}

class FirebaseCollectionConst {
  static const String user = "user";
  static const String catering = "catering";
  static const String marriagehall = "marriagehall";
}
