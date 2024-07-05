import 'package:evemanager/constants.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Profile"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("My Profile"),
            onTap: () {
              Navigator.pushNamed(context, PageNames.UserProfileDetailsPage,
                  arguments: uid);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              Navigator.pop(context);
              await BlocProvider.of<AuthCubit>(context).SignOut();
              Navigator.pushReplacementNamed(context, PageNames.LogInScreen);
            },
          ),
        ],
      ),
    );
  }
}
