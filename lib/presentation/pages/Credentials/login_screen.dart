import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/Credentials/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialsCubit, CredentialsState>(
      listener: (context, state) {
        if (state is CredentialsLoading) {
          Navigator.pushReplacementNamed(context, PageNames.LoadingScreen);
        }
        if (state is CredentialsSuccess) {
          Navigator.pushReplacementNamed(context, PageNames.HomeScreen);
        } else {
          Navigator.pushReplacementNamed(context, PageNames.LogInScreen);
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
          title: const Center(child: Text('LoginScreen')),
        ),
        body: ListView(
          children: [
            MyTextField(
              fieldvalue: email,
              hint: "Enter Your Email",
              label: "Email",
            ),
            MyTextField(
              fieldvalue: password,
              label: "Password",
              hint: "Enter Password",
              Isobscure: true,
            ),
            Container(
                child: Row(
              children: [
                const SizedBox(
                  width: 250,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: black.withOpacity(0.4)),
                    )),
              ],
            )),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                  onPressed: () async {
                    await _login(context);
                  },
                  child: Text("Login")),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, PageNames.SignUpScreen);
                },
                child: Text(
                  "Create A New Account",
                  style: TextStyle(color: black.withOpacity(0.4)),
                )),
          ],
        ));
  }

  Future<void> _login(BuildContext context) async {
    await BlocProvider.of<CredentialsCubit>(context).SignInUser(
        user: UserEntity(
      email: email.text,
      password: password.text,
    ));
  }
}
