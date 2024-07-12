import 'package:explore_indonesia/app/env/colors.dart';
import 'package:explore_indonesia/app/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  // padding: EdgeInsets.all(36),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CText(
                        "Explore\nNusantara",
                        fontSize: 20,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  
  }
}
