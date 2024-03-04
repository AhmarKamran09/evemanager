import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:evemanager/presentation/widgets/Credentials/role_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/Credentials/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController role = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialsCubit, CredentialsState>(
      listener: (context, state) {
        if (state is CredentialsLoading) {
          Navigator.pushReplacementNamed(context, PageNames.LoadingScreen);
        } else if (state is CredentialsSuccess) {
          Navigator.pushReplacementNamed(context, PageNames.HomeScreen);
        } else {
          Navigator.pushReplacementNamed(context, PageNames.SignUpScreen);
        }
      },
      builder: (context, state) {
        return _body(context);
      },
    );
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: lightBlue.withOpacity(0.5),
          title: Center(child: Text('SignUp Screen')),
        ),
        body: ListView(
          children: [
            Center(
              child: MyTextField(
                fieldvalue: email,
                hint: "Enter Your Email",
                label: "Email",
              ),
            ),
            MyTextField(
              fieldvalue: password,
              label: "Password",
              hint: "Enter Password",
              Isobscure: true,
            ),
            RoleField(
              fieldvalue: role,
              
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: lightBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                  onPressed: () async {
                    await _signup(context);
                  },
                  child: Text("SignUp")),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, PageNames.LogInScreen);
                },
                child: Text(
                  "Already Have An Account",
                  style: TextStyle(color: black.withOpacity(0.4)),
                )),
          ],
        ));
  }

  Future<void> _signup(BuildContext context) async {
    if (role.text.isNotEmpty) {
      
      await BlocProvider.of<CredentialsCubit>(context).SignUpUser(
          user: UserEntity(
        role: role.text,
        email: email.text,
        password: password.text,
      ));
    } else {
      DisplayToast("Select Correct Role ");
    }
  }
}
