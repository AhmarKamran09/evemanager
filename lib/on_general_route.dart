import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:evemanager/presentation/pages/Credentials/login_screen.dart';
import 'package:evemanager/presentation/pages/Credentials/signup_screen.dart';
import 'package:evemanager/presentation/pages/admins/catering_admin_home/add_catering_screen.dart';
import 'package:evemanager/presentation/pages/admins/catering_admin_home/update_catering_screen.dart';
import 'package:evemanager/presentation/pages/admins/chat_screen_admin.dart';
import 'package:evemanager/presentation/pages/admins/decoration_admin_home/add_decoration__screen.dart';
import 'package:evemanager/presentation/pages/admins/decoration_admin_home/update_decoration_screen.dart';
import 'package:evemanager/presentation/pages/admins/entertainment_admin_home/add_entertainment__screen.dart';
import 'package:evemanager/presentation/pages/admins/entertainment_admin_home/update_entertainment_screen.dart';
import 'package:evemanager/presentation/pages/admins/photography_admin_home/add_photography__screen.dart';
import 'package:evemanager/presentation/pages/admins/photography_admin_home/update_photography_screen.dart';
import 'package:evemanager/presentation/pages/admins/sweets_admin_home/add_sweets__screen.dart';
import 'package:evemanager/presentation/pages/admins/sweets_admin_home/update_sweets_screen.dart';
import 'package:evemanager/presentation/pages/admins/venue_admin_home/add_venues.dart';
import 'package:evemanager/presentation/pages/admins/venue_admin_home/update_venue_screen.dart';
import 'package:evemanager/presentation/pages/admins/videography_admin_home/add_videography__screen.dart';
import 'package:evemanager/presentation/pages/admins/videography_admin_home/update_videography_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/catering/catering_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/catering/cateringlist_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/client_home_page.dart';
import 'package:evemanager/presentation/pages/client_home_page/decoration/decoration_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/decoration/decoration_list_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/entertainment/entertainment_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/entertainment/entertainment_list_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/messages_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/photography/photography_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/photography/photography_list_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/sweets/sweets_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/sweets/sweets_list_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/venue/venue_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/venue/venuelist_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/videography/videography_details_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/videography/videography_list_screen.dart';
import 'package:evemanager/presentation/pages/home/home_navigation_screen.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:evemanager/presentation/pages/profile/profile_menu_page.dart';
import 'package:evemanager/presentation/pages/profile/user_profile_details_screen.dart';
import 'package:flutter/material.dart';

class OnGeneralRoute {
  static Route<dynamic>? routes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageNames.LogInScreen:
        {
          return routeBuilder(LoginScreen());
        }
      case PageNames.UserProfileDetailsPage:
        {
          return routeBuilder(UserProfileDetailsScreen());
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
      case PageNames.PageNotFound:
        {
          return routeBuilder(PageNotFound());
        }
      case PageNames.ProfileMenuPage:
        {
          return routeBuilder(ProfileMenuPage(
            uid: args as String,
          ));
        }
      case PageNames.ChatScreenAdmin:
        {
          return routeBuilder(ChatScreenAdmin(
            uid: args as String,
          ));
        }
      case PageNames.ClientHomePage:
        {
          return routeBuilder(ClientHomePage(uid: args as String));
        }
      case PageNames.MessagesScreen:
        {
          final argsMap = args as Map<String, dynamic>?;

          return routeBuilder(MessagesScreen(
            chatEntity: argsMap!['chatEntity'] as ChatEntity,
            uid: argsMap['uid'] as String,
            userRole: argsMap['userrole'] as UserRole,
          ));
        }
      case PageNames.VenueDetailsScreen:
        {
          final argsMap = args as Map<String, dynamic>?;
          return routeBuilder(VenueDetailsScreen(
            venueEntity: argsMap!['venue'] as VenueEntity,
            userid: argsMap['uid'] as String,
          ));
        }
      case PageNames.VenueListScreen:
        {
          return routeBuilder(VenueListScreen(
            uid: args as String,
          ));
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
      case PageNames.CateringDetailsScreen:
        {
          return routeBuilder(CateringDetailsScreen(
            cateringEntity: args as CateringEntity,
          ));
        }
      case PageNames.CateringListScreen:
        {
          return routeBuilder(CateringListScreen());
        }
      case PageNames.AddCateringScreen:
        {
          return routeBuilder(AddCateringScreen(
            uid: args as String,
          ));
        }
      case PageNames.UpdateCateringScreen:
        {
          return routeBuilder(UpdateCateringScreen(
            cateringEntity: args as CateringEntity,
          ));
        }
      case PageNames.DecorationDetailsScreen:
        {
          return routeBuilder(DecorationDetailsScreen(
            decorationEntity: args as DecorationsEntity,
          ));
        }
      case PageNames.DecorationListScreen:
        {
          return routeBuilder(DecorationListScreen());
        }
      case PageNames.AddDecorationScreen:
        {
          return routeBuilder(AddDecorationScreen(
            uid: args as String,
          ));
        }
      case PageNames.UpdateDecorationScreen:
        {
          return routeBuilder(UpdateDecorationScreen(
            decorationEntity: args as DecorationsEntity,
          ));
        }
      case PageNames.EntertainmentDetailsScreen:
        {
          return routeBuilder(EntertainmentDetailsScreen(
            entertainmentEntity: args as EntertainmentEntity,
          ));
        }
      case PageNames.EntertainmentListScreen:
        {
          return routeBuilder(EntertainmentListScreen());
        }
      case PageNames.AddEntertainmentScreen:
        {
          return routeBuilder(AddEntertainmentScreen(
            uid: args as String,
          ));
        }
      case PageNames.UpdateEntertainmentScreen:
        {
          return routeBuilder(UpdateEntertainmentScreen(
            entertainmentEntity: args as EntertainmentEntity,
          ));
        }
      case PageNames.PhotographyDetailsScreen:
        {
          return routeBuilder(PhotographyDetailsScreen(
            photographyEntity: args as PhotographyEntity,
          ));
        }
      case PageNames.PhotographyListScreen:
        {
          return routeBuilder(PhotographyListScreen());
        }
      case PageNames.AddPhotographyScreen:
        {
          return routeBuilder(AddPhotographyScreen(
            uid: args as String,
          ));
        }
      case PageNames.UpdatePhotographyScreen:
        {
          return routeBuilder(UpdatePhotographyScreen(
            photographyEntity: args as PhotographyEntity,
          ));
        }
      case PageNames.SweetsDetailsScreen:
        {
          return routeBuilder(SweetsDetailsScreen(
            sweetsEntity: args as SweetEntity,
          ));
        }
      case PageNames.SweetsListScreen:
        {
          return routeBuilder(SweetsListScreen());
        }
      case PageNames.AddSweetsScreen:
        {
          return routeBuilder(AddSweetsScreen(
            uid: args as String,
          ));
        }
      case PageNames.UpdateSweetsScreen:
        {
          return routeBuilder(UpdateSweetsScreen(
            sweetsEntity: args as SweetEntity,
          ));
        }
      case PageNames.VideographyDetailsScreen:
        {
          return routeBuilder(VideographyDetailsScreen(
            videographyEntity: args as VideographyEntity,
          ));
        }
      case PageNames.VideographyListScreen:
        {
          return routeBuilder(VideographyListScreen());
        }
      case PageNames.AddVideographyScreen:
        {
          return routeBuilder(AddVideographyScreen(
            uid: args as String,
          ));
        }
      case PageNames.UpdateVideographyScreen:
        {
          return routeBuilder(UpdateVideographyScreen(
            videographyEntity: args as VideographyEntity,
          ));
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
