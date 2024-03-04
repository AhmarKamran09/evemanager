import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
import 'package:evemanager/presentation/pages/Credentials/login_screen.dart';
import 'package:evemanager/presentation/pages/Credentials/signup_screen.dart';
import 'package:evemanager/presentation/pages/add_payment_method_screen/add-payment_method_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/marriage_hall_vendors_screen.dart';
import 'package:evemanager/presentation/pages/home/home_screen.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:evemanager/presentation/pages/marriage_hall_admin_home/add_marriage_halls.dart';
import 'package:evemanager/presentation/pages/marriage_hall_admin_home/update_marriage_hall.dart';
import 'package:evemanager/presentation/pages/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';

class OnGeneralRoute {
  static Route<dynamic>? routes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageNames.LogInScreen:
        {
          return routeBuilder(LoginScreen());
        }
      case PageNames.MarriageHallVendorsScreen:
        {
          return routeBuilder(MarriageHallVendorsScreen());
        }
      case PageNames.UpdateMarriageHallScreen:
        {
          return routeBuilder(UpdateMarriageHallScreen(
            marriageHallEntity: args as MarriageHallEntity,
          ));
        }
      case PageNames.AddMarriageHallScreen:
        {
          return routeBuilder(AddMarriageHalls(uid: args as String));
        }
      case PageNames.UserProfilePage:
        {
          return routeBuilder(UserProfileScreen());
        }
      case PageNames.AddPaymentMethodScreen:
        {
          return routeBuilder(AddPaymentMethodScreen());
        }
      case PageNames.LoadingScreen:
        {
          return routeBuilder(LoadingScreen());
        }
      case PageNames.HomeScreen:
        {
          return routeBuilder(HomeScreen());
        }

      case PageNames.SignUpScreen:
        {
          return routeBuilder(SignUpScreen());
        }
      default:
        {
          return routeBuilder(PageNotFound());
        }
    }
  }
}

dynamic routeBuilder(Widget child, {Object? arguments}) {
  return MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(arguments: arguments));
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Not Found"),
      ),
      body: Center(
        child: Text("Page Not Found"),
      ),
    );
  }
}
