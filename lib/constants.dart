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
  static const String AddBridalMakeupAndHairScreen =
      "AddBridalMakeupAndHairScreen";
  static const String UpdateBridalMakeupAndHairScreen =
      "UpdateBridalMakeupAndHairScreen";
  static const String BridalMakeupAndHairDetailsScreen =
      "BridalMakeupAndHairDetailsScreen";
  static const String BridalMakeupAndHairListScreen =
      "BridalMakeupAndHairListScreen";
  static const String AddClothingScreen = "AddClothingScreen";
  static const String UpdateClothingScreen = "UpdateClothingScreen";
  static const String ClothngDetailsScreen = "ClothngDetailsScreen";
  static const String ClothngListScreen = "ClothngListScreen";
  static const String AddDecorationScreen = "AddDecorationScreen";
  static const String UpdateDecorationScreen = "UpdateDecorationScreen";
  static const String DecorationDetailsScreen = "DecorationDetailsScreen";
  static const String DecorationListScreen = "DecorationListScreen";
  static const String AddEntertainmentScreen = "AddEntertainmentScreen";
  static const String UpdateEntertainmentScreen = "UpdateEntertainmentScreen";
  static const String EntertainmentDetailsScreen = "EntertainmentDetailsScreen";
  static const String EntertainmentListScreen = "EntertainmentListScreen";
  static const String AddInvitationDesignScreen = "AddInvitationDesignScreen";
  static const String UpdateInvitationDesignScreen =
      "UpdateInvitationDesignScreen";
  static const String InvitationDesignDetailsScreen =
      "InvitationDesignDetailsScreen";
  static const String InvitationDesignListScreen = "InvitationDesignListScreen";
  static const String AddPhotographyScreen = "AddPhotographyScreen";
  static const String UpdatePhotographyScreen = "UpdatePhotographyScreen";
  static const String PhotographyDetailsScreen = "PhotographyDetailsScreen";
  static const String PhotographyListScreen = "PhotographyListScreen";
  static const String AddSweetsScreen = "AddSweetsScreen";
  static const String UpdateSweetsScreen = "UpdateSweetsScreen";
  static const String SweetsDetailsScreen = "SweetsDetailsScreen";
  static const String SweetsListScreen = "SweetsListScreen";
  static const String AddTransportationScreen = "AddTransportationScreen";
  static const String UpdateTransportationScreen = "UpdateTransportationScreen";
  static const String TransportationDetailsScreen =
      "TransportationDetailsScreen";
  static const String TransportationListScreen = "TransportationListScreen";
  static const String AddVideographyScreen = "AddVideographyScreen";
  static const String UpdateVideographyScreen = "UpdateVideographyScreen";
  static const String VideographyDetailsScreen = "VideographyDetailsScreen";
  static const String VideographyListScreen = "VideographyListScreen";
  static const String ClientHomePage = "ClientHomePage";
  static const String PageNotFound = "PageNotFound";
  static const String MessagesScreen = "MessagesScreen";
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
  static const String decorations = "decorations";
  static const String entertainment = "entertainment";
  static const String invitation_design = "invitation_design";
  static const String photography = "photography";
  static const String sweets = "sweets";
  static const String transportation = "transportation";
  static const String videography = "videography";
  static const String chats = "chat";
  static const String messages = "messages";
}
