import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/auth/login.dart';
import 'package:hikemaniak_app/screens/home.dart';

void main() async{
  AwesomeNotifications().initialize(
      'resource://mipmap/hike_maniak',
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notification',
          channelDescription: 'Notification channel for basic tests')
    ]
  );
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const SignInScreen();
  }
}
