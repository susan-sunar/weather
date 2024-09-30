import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/views/bottom.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () => Get.offAll(() => PracticeBottomNavBar())
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/image/we.jpg"))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/image/we_cloud-removebg-preview.png"),fit: BoxFit.cover)
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
