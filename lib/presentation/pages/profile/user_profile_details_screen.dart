import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/presentation/cubit/userprofile/user_profile_cubit.dart';
import 'package:evemanager/presentation/pages/loading_screen/loading_screen.dart';
import 'package:evemanager/presentation/widgets/Credentials/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileDetailsScreen extends StatefulWidget {
  const UserProfileDetailsScreen({super.key});

  @override
  State<UserProfileDetailsScreen> createState() =>
      _UserProfileDetailsScreenState();
}

class _UserProfileDetailsScreenState extends State<UserProfileDetailsScreen> {
  TextEditingController? name = TextEditingController();
  TextEditingController? contact_number = TextEditingController();
  TextEditingController? cnic = TextEditingController();
  TextEditingController? address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? uidvalue = ModalRoute.of(context)?.settings.arguments as String?;
    cnic?.text = "0";
    contact_number?.text = "0";

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
        uidvalue = state.user.uid;
        name?.text = state.user.name ?? "";
        contact_number?.text = state.user.contact_number.toString();
        cnic?.text = state.user.cnic.toString();
        address?.text = state.user.address ?? "";

        return _body(context, uidvalue);
      }
      return _body(context, uidvalue);
    });
  }

  Scaffold _body(BuildContext context, String? uidvalue) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile Details"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            MyTextField(
                fieldvalue: name!, label: "Name", hint: "Enter Your Name"),
            MyTextField(
                fieldvalue: contact_number!,
                label: "Contact Number",
                hint: "Enter Your Contact Number"),
            MyTextField(
                fieldvalue: cnic!, label: "CNIC", hint: "Enter Your CNIC"),
            MyTextField(
                fieldvalue: address!,
                label: "Address",
                hint: "Enter Your Address"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextButton(
                      onPressed: () async {
                        await _update(context, uidvalue);
                      },
                      child: Text("UPDATE")),
                ),
                Container(
                    child: TextButton(
                        onPressed: () async {
                          await deleteaccount(context, uidvalue);
                        },
                        child: Text("DELETE ACCOUNT")))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _update(BuildContext context, String? uidvalue) async {
    await BlocProvider.of<UserProfileCubit>(context).UpdateUser(
        user: UserEntity(
      uid: uidvalue,
      name: name!.text,
      contact_number: contact_number!.text,
      cnic: cnic!.text,
      address: address!.text,
    ));
  }

  Future<void> deleteaccount(BuildContext context, String? uidvalue) async {
    print(uidvalue);
    await BlocProvider.of<UserProfileCubit>(context).DeleteUser(
        user: UserEntity(
      uid: uidvalue,
    ));

    Navigator.pushReplacementNamed(context, PageNames.LogInScreen);
  }
}
