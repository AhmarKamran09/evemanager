import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDrawer extends StatelessWidget {
  final String? uid;
  final BuildContext? parentcontext;
  const MainDrawer({
    super.key,
    this.uid,
    this.parentcontext,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: lightBlue,
          child: Center(
            child: Icon(
              Icons.event,
              size: 80,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                iconColor: lightBlue,
                splashColor: lightBlue.withOpacity(0.2),
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, PageNames.HomeScreen,
                      arguments: uid);
                },
              ),
              ListTile(
                iconColor: lightBlue,
                splashColor: lightBlue.withOpacity(0.2),
                leading: Icon(Icons.person),
                title: Text("My Profile"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, PageNames.UserProfilePage,
                      arguments: uid);
                },
              ),
              ListTile(
                iconColor: lightBlue,
                splashColor: lightBlue.withOpacity(0.2),
                leading: Icon(Icons.payment),
                title: Text("Add Payment Method"),
                onTap: () async {
                  Navigator.pop(context);
                  // Navigator.pushReplacementNamed(
                  //     context, );
                },
              ),
              ListTile(
                iconColor: lightBlue,
                splashColor: lightBlue.withOpacity(0.2),
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                  Navigator.pop(context);
                  await BlocProvider.of<AuthCubit>(context).SignOut();
                  Navigator.pushReplacementNamed(
                      context, PageNames.LogInScreen);
                      
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
