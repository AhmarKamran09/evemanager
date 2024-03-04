import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/presentation/pages/Credentials/login_screen.dart';
import 'package:evemanager/presentation/pages/Credentials/signup_screen.dart';
import 'package:evemanager/presentation/pages/add_payment_method_screen/add-payment_method_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/venuelist_screen/venuelist_screen.dart';
import 'package:evemanager/presentation/pages/home/home_navigation_screen.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:evemanager/presentation/pages/venue_admin_home/add_venues.dart';
import 'package:evemanager/presentation/pages/venue_admin_home/update_venue_screen.dart';
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
      case PageNames.VenueListScreen:
        {
          return routeBuilder(VenueListScreen());
        }
      case PageNames.UpdateVenueScreen:
        {
          return routeBuilder(UpdateVenueScreen(
            venueEntity: args as VenueEntity,
          ));
        }
      case PageNames.AddVenuesScreen:
        {
          return routeBuilder(AddVenues(uid: args as String));
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
          return routeBuilder(HomeNavigationScreen());
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
