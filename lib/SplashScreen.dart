import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iot_project/HomePage.dart';
import 'package:iot_project/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidation().whenComplete(() async {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => finalEmail == null
                      ? const LoginPage()
                      : const HomePage())));
    });
    super.initState();
  }

  Future getValidation() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var getEmail = sharedPreference.getString('email');
    setState(() {
      finalEmail = getEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: const Color.fromRGBO(48, 38, 100, 1),
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/Color.jpg"),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.wifi,
              color: Colors.white,
              size: 50.sp,
            ),
            SizedBox(height: 10.sp),
            Text(
              "I O T",
              style: TextStyle(
                fontSize: 40.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.sp),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ]),
        ),
      ),
    );
  }
}
