import 'package:flutter/material.dart';
import 'package:merchantnationuserapp/screens/preference_shared/screenSizeConfig.dart';

class MPartition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, ScreenSizeConfig.safeBlockHorizontal * 5,
          0, ScreenSizeConfig.safeBlockHorizontal * 2),
      child: Container(
        color: Colors.grey,
        width: ScreenSizeConfig.safeBlockHorizontal * 90,
        height: ScreenSizeConfig.safeBlockVertical * 0.2,
      ),
    );
  }
}
