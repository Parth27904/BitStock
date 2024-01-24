import 'dart:async';

import 'package:cryptogen/features/landing/ui/landing.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 4),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Landing()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child:  Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/splash.gif'),fit: BoxFit.cover)),
        ));
  }
}
