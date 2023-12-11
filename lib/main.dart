import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import 'helpers/ad_helper.dart';
import 'helpers/config.dart';
import 'helpers/pref.dart';
import 'screens/splash_screen.dart';

//global object for accessing device screen size
late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  //firebase initialization
  await Firebase.initializeApp();

  //initializing remote config
  await Config.initConfig();

  await Pref.initializeHive();

  await AdHelper.initAds();

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EeveVPN',
      home: SplashScreen(),

      //theme
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.brown[700], // Set the background color here
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 207, 190, 184),
      ),

      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      //dark theme
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),

      debugShowCheckedModeBanner: false,
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightText => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottomNav => Pref.isDarkMode ? Colors.white12 : Colors.brown[700]!;
}

void launchChat() async {
  dynamic conversationObject = {
    'appId':
        '2dc1f4f82f0aec4e4d968ae614b730836', // Replace with your Kommunicate App ID
  };

  KommunicateFlutterPlugin.buildConversation(conversationObject)
      .then((clientConversationId) {
    print("Conversation builder success : " + clientConversationId.toString());
  }).catchError((error) {
    print("Conversation builder error occurred : " + error.toString());
  });
}
