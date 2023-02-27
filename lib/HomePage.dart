import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_project/SplashScreen.dart';
import 'package:iot_project/db.dart';
import 'package:http/http.dart' as http;
import 'package:iot_project/ip.dart';
import 'package:iot_project/route.dart';
import 'package:shared_preferences/shared_preferences.dart';


var time = DateTime.now().toLocal();
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var ip = IP.ip;
  Future getData() async{
    var url = "http://$ip/IOT/Login.php";
    var res = await http.post(Uri.parse(url),body: {
      'email' : finalEmail.toString(),  
    });
    var res2 = await http.get(Uri.parse(url));
    var data = json.decode(res2.body);
    setState((){});
    return data; 
  }
  
  bool button = false;

  //GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // drawer: Drawer(
        //   //backgroundColor: const Color.fromRGBO(48, 38, 100, 1),
        //   child: FutureBuilder(
        //     future: getData(),
        //     builder: (context, snapshot) {
        //       if(snapshot.hasData){
        //         //var mydata = snapshot[];
        //         return RefreshIndicator(
        //           onRefresh: getData,
        //           child: ListView(         
        //               children: [
        //               UserAccountsDrawerHeader(
        //               currentAccountPicture: CircleAvatar(
        //                 backgroundImage:
        //                     const AssetImage("assets/images/User.png"),
        //                 maxRadius: 15.0.sp,
        //               ),
        //               accountName: Text(
        //                 snapshot.data['userId'],
        //                 style: TextStyle(
        //                   fontSize: 18.sp,
        //                 ),
        //               ),
        //               accountEmail: Text(
        //                 mydata['email'],
        //                 style: TextStyle(
        //                   fontSize: 18.sp,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: Icon(
        //                 Icons.home,
        //                 size: 30.sp,
        //                 color: Colors.indigo,
        //               ),
        //               title: Text(
        //                 "Home",
        //                 style: TextStyle(
        //                   fontSize: 17.sp,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: Icon(
        //                 Icons.phone_android,
        //                 size: 30.sp,
        //                 color: const Color.fromARGB(255, 178, 106, 196),
        //               ),
        //               title: Text(
        //                 "0$mydata['phone]",
        //                 style: TextStyle(
        //                   fontSize: 17.sp,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: Icon(
        //                 Icons.favorite,
        //                 size: 30.sp,
        //                 color: Colors.red,
        //               ),
        //               title: Text(
        //                 "Favourite",
        //                 style: TextStyle(
        //                   fontSize: 17.sp,
        //                   //color: Colors.blue,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: Icon(
        //                 Icons.facebook_outlined,
        //                 size: 30.sp,
        //                 color: Colors.blue,
        //               ),
        //               title: Text(
        //                 "Facebook",
        //                 style: TextStyle(
        //                   fontSize: 17.sp,
        //                   //color: Colors.blue,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: Icon(
        //                 Icons.mail,
        //                 size: 30.sp,
        //                 color: const Color.fromARGB(255, 212, 82, 30),
        //               ),
        //               title: Text(
        //                 "Gmail",
        //                 style: TextStyle(
        //                   fontSize: 17.sp,
        //                   //color: Colors.blue,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: IconButton(
        //                 onPressed: () async {
        //                   SharedPreferences sharedPreferences =
        //                       await SharedPreferences.getInstance();
        //                   sharedPreferences.remove('email');
        //                   Navigator.pushNamed(context, MyRoute.LoginPage);
        //                 },
        //                 icon: Icon(
        //                   Icons.logout,
        //                   size: 30.sp,
        //                   color: Colors.red,
        //                 ),
        //               ),
        //               title: Text(
        //                 "Log Out",
        //                 style: TextStyle(
        //                   fontSize: 17.sp,
        //                   //color: Colors.blue,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //           );
        //       }
        //       else{
        //         return const CircularProgressIndicator();
        //       }
        //     },
        //     ),
        // ),


        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(48, 38, 100, 1),
          title: Text(
            "Internet Of Things",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
            ),
          ),
        ),
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.sp),
                child: Text(
                  'Current Time',
                  style: TextStyle(
                    fontSize: 30.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.sp),
                child: Text(
                  '${time.hour} : ${time.minute} : ${time.second}',
                  style: TextStyle(
                    fontSize: 30.sp,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 50.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                      color:
                          (button == false) ? Colors.grey : Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                      border: Border.all(
                        color: Colors.cyan,
                        width: 2.sp,
                      )),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 5.sp,
                          left: (button == false) ? 10.sp : 85.sp,
                          right: (button == false) ? 80.sp : 5.sp,
                          bottom: 5.sp,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                button = !button;
                                Timer(
                                  const Duration(seconds: 2),
                                  () {
                                    button = false;
                                  },
                                );
                                if (button == true) {
                                  //sendData();
                                }
                              });
                            },
                            child: Container(
                              // height: 20.h,
                              // width: 30.w,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.sp)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ListView(
//                   children: [
//                     UserAccountsDrawerHeader(
//                       currentAccountPicture: CircleAvatar(
//                         backgroundImage:
//                             const AssetImage("assets/images/User.png"),
//                         maxRadius: 15.0.sp,
//                       ),
//                       accountName: Text(
//                         name.toString(),
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                       accountEmail: Text(
//                         email.toString(),
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.home,
//                         size: 30.sp,
//                         color: Colors.indigo,
//                       ),
//                       title: Text(
//                         "Home",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.phone_android,
//                         size: 30.sp,
//                         color: const Color.fromARGB(255, 178, 106, 196),
//                       ),
//                       title: Text(
//                         "0$phone",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.favorite,
//                         size: 30.sp,
//                         color: Colors.red,
//                       ),
//                       title: Text(
//                         "Favourite",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                           //color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.facebook_outlined,
//                         size: 30.sp,
//                         color: Colors.blue,
//                       ),
//                       title: Text(
//                         "Facebook",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                           //color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.mail,
//                         size: 30.sp,
//                         color: const Color.fromARGB(255, 212, 82, 30),
//                       ),
//                       title: Text(
//                         "Gmail",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                           //color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: IconButton(
//                         onPressed: () async {
//                           SharedPreferences sharedPreferences =
//                               await SharedPreferences.getInstance();
//                           sharedPreferences.remove('email');
//                           Navigator.pushNamed(context, MyRoute.LoginPage);
//                         },
//                         icon: Icon(
//                           Icons.logout,
//                           size: 30.sp,
//                           color: Colors.red,
//                         ),
//                       ),
//                       title: Text(
//                         "Log Out",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                           //color: Colors.blue,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),