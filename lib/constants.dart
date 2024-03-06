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
  static const String AddVenuesScreen = "AddVenuesScreen";
  static const String UpdateVenueScreen = "UpdateVenueScreen";
  static const String VenueListScreen = "VenueListScreen";
  static const String VenueDetailsScreen = "VenueDetailsScreen";
  static const String CateringDetailsScreen = "CateringDetailsScreen";
  static const String CateringListScreen = "CateringListScreen";
  
  
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
  static const String venues = "venues";
}
