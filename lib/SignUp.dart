import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_project/ip.dart';
import 'package:iot_project/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  var ip = IP.ip;
  void signUp() async{
  var url = "http://$ip/IOT/SignUP.php";
  var res = await http.post(Uri.parse(url),body: {
    'email' : email.text,
    'userId' : userId.text,
    'password' : password.text,
    'phone' : mobile.text,
  });
  if(res.body == 'already exist'){
    Fluttertoast.showToast(msg: "Email Is Already Exist");
  }
  else if(res.body == 'Sucess'){
    Fluttertoast.showToast(msg: "Account Creation Sucessfull");
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, MyRoute.HomePage);
  }
  else{
    Fluttertoast.showToast(msg: "Server Error");
  }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: const Color(0xFFFF6B6B),
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              scale: 1.0,
              image: AssetImage("assets/images/back2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.sp, top: 50.sp, bottom: 20.sp),
                child: Text(
                  "Create A New Account",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black.withOpacity(0.9.sp),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              textInput(email, "Enter Your Email", Icons.mail, false),
              textInput(userId, "User Name", Icons.mail, false),
              textInput(password, "Password", Icons.mail, true),
              textInput(mobile, "Phone Number", Icons.mail, false),
              SizedBox(height: 20.sp),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    signUp();
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', email.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 13.sp, horizontal: 40.sp),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoute.LoginPage);
                  },
                  child: Text(
                    "Already Have An Account?",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFFFF6B6B),
                    ),
                  ),
                ),
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
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  "Copyright By",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Team Loop Squad",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textInput(TextEditingController cont, String text, IconData ic, bool check) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 15.sp),
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: Colors.greenAccent, width: 2.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: Colors.greenAccent, width: 2.sp),
          ),
          prefixIcon: const Icon(
            Icons.person,
            //color: Colors.black,
            size: 30,
          ),
          labelText: text,
          labelStyle: TextStyle(
            fontSize: 17.sp,
            color: Colors.black,
            //fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9.sp),
        ),
        obscureText: (check == true) ? true : false,
      ),
    );
  }
}
