import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:merchantnationuserapp/constants/m-colors.dart';
import 'package:merchantnationuserapp/constants/m-strings.dart';
import 'package:merchantnationuserapp/screens/SplashScreen/splashScreen.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    //  MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => UserBloc()
    //         ..add(
    //           CheckIfLoggedIn(),
    //         ),
    //     ),
    //     // BlocProvider(
    //     //   create: (context) => ScanBloc(),
    //     // ),
    //   ],
    //   child: OverlaySupport(
    //     child: 
        MaterialApp(
            title: MStrings.AppTitle,
            theme: ThemeData(
              fontFamily: 'SourceSansPro',
              brightness: Brightness.dark,
              scaffoldBackgroundColor: MColors.BACKGROUND_COLOR,
            ),
            debugShowCheckedModeBanner: false,
            home: SafeArea(child: SplashScreen()));
      
  
    
  }
}
