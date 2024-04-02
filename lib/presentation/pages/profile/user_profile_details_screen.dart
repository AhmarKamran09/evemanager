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
    // i have to remove the inheritance of uid as it is not required the uid is get here itself in a function
    bool readonly = false;
// i have to call get user of user cubit so that  when we show this screen we want
// to add different functionality for different roles
// for example for hall role we want to add a button to add hall

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

        return _body(readonly, context, uidvalue);
      }
      return _body(readonly, context, uidvalue);
    });
  }

  Scaffold _body(bool readonly, BuildContext context, String? uidvalue) {
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
                readonly: readonly,
                fieldvalue: name!,
                label: "Name",
                hint: "Enter Your Name"),
            MyTextField(
                readonly: readonly,
                fieldvalue: contact_number!,
                label: "Contact Number",
                hint: "Enter Your Contact Number"),
            MyTextField(
                readonly: readonly,
                fieldvalue: cnic!,
                label: "CNIC",
                hint: "Enter Your CNIC"),
            MyTextField(
                readonly: readonly,
                fieldvalue: address!,
                label: "Address",
                hint: "Enter Your Address"),
            SizedBox(height: 20),
            Switch(
              onChanged: (e) {
                // setState(() {
                //   readonly = e;
                // });
              },
              value: readonly,
            ),
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
// apply conditions of checking that the int valyues are not empty,int inputs are
// not having text characters,if all the etxt editing controllers have some value
//meaning they aere not null

    await BlocProvider.of<UserProfileCubit>(context).UpdateUser(
        user: UserEntity(
      uid: uidvalue,
      name: name!.text,
      contact_number: contact_number!.text,
      // contact_number!.text.isNotEmpty ? int.parse(contact_number!.text) : 0,
      cnic: cnic!.text,
      // cnic!.text.isNotEmpty ? int.parse(cnic!.text) : 0,
      address: address!.text,
    ));
      //  Navigator.pushReplacementNamed(context, PageNames.);
 
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
