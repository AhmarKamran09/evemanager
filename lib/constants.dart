import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color lightBlue = Colors.lightBlue;
const Color black = Colors.black;

class PageNames {
  static const String LogInScreen = "LogInScreen";
  static const String SignUpScreen = "SignUpScreen";
  static const String UserProfileDetailsPage = "UserProfileDetailsPage";
  static const String ProfileMenuPage = "ProfileMenuPage";
  static const String HomeScreen = "HomeScreen";
  static const String LoadingScreen = "LoadingScreen";
  static const String AddPaymentMethodScreen = "AddPaymentMethodScreen";
  static const String AddVenuesScreen = "AddVenuesScreen";
  static const String UpdateVenueScreen = "UpdateVenueScreen";
  static const String VenueListScreen = "VenueListScreen";
  static const String VenueDetailsScreen = "VenueDetailsScreen";
  static const String CateringDetailsScreen = "CateringDetailsScreen";
  static const String CateringListScreen = "CateringListScreen";
  static const String AddCateringScreen = "AddCateringScreen";
  static const String UpdateCateringScreen = "UpdateCateringScreen";
  static const String PageNotFound = "PageNotFound";
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
  static const String bridalMakeupAndHair = "bridalMakeupAndHair";
  static const String clothing = "clothing";
  static const String decorations= "decorations";
  static const String entertainment = "entertainment";
  static const String invitation_design= "invitation_design";
  static const String photography = "photography";
  static const String sweets = "sweets";
  static const String transportation = "transportation";
  static const String videography = "videography";
  
}
