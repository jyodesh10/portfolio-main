import 'package:flutter/material.dart';
import 'package:portfolio/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  int percent = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          percent = 10;
        });
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          percent = 25;
        });
      });
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          percent = 45;
        });
      });
      Future.delayed(const Duration(milliseconds: 1200), () {
        setState(() {
          percent = 60;
        });
      });
      Future.delayed(const Duration(milliseconds: 1350), () {
        setState(() {
          percent = 80;
        });
      });
      Future.delayed(const Duration(milliseconds: 1480), () {
        setState(() {
          percent = 100;
        });
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: AppColors.cyyan,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [

              const Color(0xFF37474F),
              const Color(0xFF263238),
              Colors.black.withValues(alpha:0.9),

            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0,  0.4,  0.9],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", height: 40.sp, width: 40.sp,),
              Text("$percent %", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w200, color: AppColors.white),),
              SizedBox(
                height: 8.sp,
              ),
              SizedBox(
                width: 20.w,
                child: LinearProgressIndicator(
                  color: AppColors.cyyan,
                  value: percent/100,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}