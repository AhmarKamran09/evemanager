import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:evemanager/presentation/cubit/userprofile/user_profile_cubit.dart';
import 'package:evemanager/presentation/pages/Credentials/login_screen.dart';
import 'package:evemanager/presentation/pages/admins/catering_admin_home/catering_admin_home.dart';
import 'package:evemanager/presentation/pages/admins/venue_admin_home/venue_admin_home.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:evemanager/presentation/pages/client_home_page/client_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationScreen extends StatefulWidget {
  HomeNavigationScreen({
    super.key,
  });
  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _IsAuthenticatedLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? uid = ModalRoute.of(context)!.settings.arguments as String?;

// add the function og getting current location
    // we want to add payment method here in main drawer for all types of users
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is UnAuthenticated) {
        Navigator.pushReplacementNamed(context, PageNames.LogInScreen);
      }
    }, builder: (context, state) {
      if (state is Authenticated) {
        uid = state.uid;
        return _userbloc(uid);
      }
      return _userbloc(uid);
    });
  }

  BlocConsumer<UserProfileCubit, UserProfileState> _userbloc(String? uid) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
      if (state is UserProfileFailure) {
        Navigator.pushReplacementNamed(context, PageNames.LogInScreen);
      }
    }, builder: (context, state) {
      if (state is UserProfileLoading) {
        return LoadingScreen();
      }
      if (state is UserProfileSuccess) {
        uid = state.user.uid;
        if (state.user.role == "1") {
          return ClientHomePage(
            uid: uid,
          );
        } else if (state.user.role == "3") {
          return VenueAdminHome(uid: uid);
        } else if (state.user.role == "5") {
          return CateringAdminHome(uid: uid);
        } else {
          return LoginScreen();
        }
      } else {
        return LoginScreen();
      }
    });
  }

  Future<void> _IsAuthenticatedLogin(BuildContext context) async {
    await BlocProvider.of<AuthCubit>(context).LoggedInWithAuthentication();
    await BlocProvider.of<UserProfileCubit>(context).GetUser();
  }
}
