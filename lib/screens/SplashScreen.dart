// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:merchantnationuserapp/constants/m-uri.dart';



// import 'package:merchantnationuserapp/screens/preference_shared/screenSizeConfig.dart';
// import 'package:merchantnationuserapp/screens/signin_signup/login.dart';
// import 'package:merchantnationuserapp/utils/local-storage.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     print("In Splash Screen");
//     super.initState();
//     Storage.initialize();
//     // initialize().then((e) {
//     //   setState(() {});
//     // });
// Timer(Duration(milliseconds:300),()=>{
//      Navigator.push(context, MaterialPageRoute(builder: (context)=> login()))
//     });
//   }

//   initialize() async {
//     await Storage.initialize();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenSizeConfig().init(context);
//     var screenSizeHeight = ScreenSizeConfig.safeBlockVertical * 100;
//     var screenSizeWidth = ScreenSizeConfig.safeBlockHorizontal * 100;

//     return 
//     // BlocListener<UserBloc, UserState>(
//     //   listener: (context, state) {
//     //     if (state is UserLoggedIn) {
//     //       print("State user logged in");
//     //       Navigator.pushReplacement(
//     //         context,
//     //         MaterialPageRoute(builder: (context) => MyRestaurantHomeScreen()),
//     //       );
//     //     } else if (state is UserInitial) {
//     //       print('User Initial and not logged in');

//     //     }
//     //   },
//     //   child: 
//       Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             Container(
//               width: screenSizeWidth,
//               height: screenSizeHeight * 1.2,
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                     image: AssetImage(MUri.BACKGROUND_IMAGE_PNG),
//                     fit: BoxFit.cover,
//                   )),
//                 ),
//               ),
//             ),


//           ],
//         ),
//       );
    
//   }
// }
