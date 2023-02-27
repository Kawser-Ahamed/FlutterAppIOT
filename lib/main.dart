import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iot_project/HomePage.dart';
import 'package:iot_project/LoginPage.dart';
import 'package:iot_project/SignUp.dart';
import 'package:iot_project/route.dart';

import 'SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          initialRoute: MyRoute.SplashScreen,
          //initialRoute: MyRoute.SignUP,
          //initialRoute: MyRoute.HomePage,
          routes: {
            MyRoute.SplashScreen: (context) => const SplashScreen(),
            MyRoute.LoginPage: (context) => const LoginPage(),
            MyRoute.SignUP: (context) => const SignUp(),
            MyRoute.HomePage: (context) => const HomePage(),
          },
        );
      },
    );
  }
}
