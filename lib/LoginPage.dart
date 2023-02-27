import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_project/ip.dart';
import 'package:iot_project/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//var pass;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  var ip = IP.ip;
  void login() async{
    var url = "http://$ip/IOT/Login.php";
    var res = await http.post(Uri.parse(url),body: {
      'email' : email.text,
      'password' : password.text,
    });
    if(res.body == 'Sucess'){
      Fluttertoast.showToast(msg: "Login Sucessfull");
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, MyRoute.HomePage);
    }
    else{
      Fluttertoast.showToast(msg: "Inavlid User Id Or Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            //bottom: 0,
            child: Image(
              image: AssetImage("assets/images/iot.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: double.maxFinite.h,
              width: double.maxFinite.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.sp),
                  topLeft: Radius.circular(25.sp),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.sp, bottom: 10.sp),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: const Color.fromRGBO(138, 48, 127, 1)),
                    ),
                  ),
                  textInput(email, "Enter Your Email", Icons.mail, false),
                  SizedBox(height: 13.sp),
                  textInput(password, "Password", Icons.mail, true),
                  SizedBox(height: 20.sp),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sharedPreference =
                            await SharedPreferences.getInstance();
                        sharedPreference.setString('email', email.text);
                        login();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 13.sp, horizontal: 70.sp),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 60.sp),
                        child: Text(
                          "Don't Have Any Account?",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoute.SignUP);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  Container(
                    margin: EdgeInsets.only(left: 70.sp, right: 70.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 40.sp,
                          color: Colors.blue,
                        ),
                        Icon(
                          CupertinoIcons.device_laptop,
                          size: 40.sp,
                          color: Colors.deepPurple,
                        ),
                        Icon(
                          CupertinoIcons.gift_fill,
                          size: 40.sp,
                          color: const Color.fromARGB(255, 240, 47, 111)
                              .withOpacity(0.8.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  textInput(TextEditingController cont, String text, IconData ic, bool check) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 15.sp),
      child: TextField(
        // style: TextStyle(
        //   color: Colors.white,
        //   fontSize: 20.sp,
        // ),
        controller: cont,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: Colors.black, width: 1.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: Colors.black, width: 1.sp),
          ),
          prefixIcon: const Icon(
            Icons.person,
            //color: Colors.white,
            size: 30,
          ),
          labelText: text,
          labelStyle: TextStyle(
            fontSize: 17.sp,
            color: Colors.black,
            //fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1.sp),
        ),
        obscureText: (check == true) ? true : false,
      ),
    );
  }
}
