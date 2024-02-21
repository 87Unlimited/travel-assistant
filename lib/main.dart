import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_assistant/config/theme/theme.dart';
import 'package:travel_assistant/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'app.dart';
import 'features/auth/presentation/views/login/login_view.dart';
import 'features/auth/presentation/views/register/register_view.dart';
import 'features/auth/presentation/views/verify_email_view.dart';

void main() {
  // Todo: Add Widgets Binding
  // Todo: Init Local Storage
  // Todo: Await Native Splash
  // Todo: Initialize Firebase
  // Todo: Initialize Authentication


  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if(user.emailVerified) {
                  return const LoginView();
                } else {
                  return const LoginView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        }
    );
  }
}