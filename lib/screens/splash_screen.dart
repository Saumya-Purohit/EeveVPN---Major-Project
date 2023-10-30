import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import '../helpers/ad_helper.dart';
import '../main.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();

      //navigate to home
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.brown[300]!, Colors.brown[700]!],
          ),
        ),
        child: Stack(
          children: [
            //app logo
            Positioned(
                left: mq.width * .2, // Adjusted to center the larger image
                top: mq.height * .1, // Adjusted to center the larger image
                width: mq.width * .6, // Increased from .4 to .6
                height:
                    mq.height * .6, // Added to control the height of the image
                child: Image.asset('assets/images/logo.png')),

            //label
            Positioned(
                bottom: mq.height * .15,
                width: mq.width,
                child: Text(
                  'MADE IN INDIA WITH ❤️',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber[800], letterSpacing: 1),
                ))
          ],
        ),
      ),
    );
  }
}
