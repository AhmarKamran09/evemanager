import 'package:evemanager/dependency_injection.dart' as di;
import 'package:evemanager/on_general_route.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:evemanager/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/cubit/userprofile/user_profile_cubit.dart';
import 'package:evemanager/presentation/pages/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..AppStarted(context),
        ),
        BlocProvider<CredentialsCubit>(
          create: (_) => di.sl<CredentialsCubit>(),
        ),
        BlocProvider<UserProfileCubit>(
          create: (_) => di.sl<UserProfileCubit>(),
        ),
        BlocProvider<VenueCubit>(
          create: (_) => di.sl<VenueCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Eve Manager',
        // //////////////////////////Create a beautiful theme for the whole app in the end
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        onGenerateRoute: OnGeneralRoute.routes,
        initialRoute: "/",
        routes: {
          "/": (context) => BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return SplashScreen(
                      uid: state.uid,
                      authenticated: true,
                    );
                  } else {
                    return SplashScreen(authenticated: false);
                  }
                },
              )
        },
      ),
    );
  }
}
