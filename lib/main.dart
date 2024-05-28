import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/auth/login.dart';
import 'package:hikemaniak_app/screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/logout' : (context)=> SignInScreen(),
    },
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const SignInScreen();
  }
}
