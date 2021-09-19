import 'package:flutter/material.dart';
import 'package:merchantnationuserapp/constants/m-colors.dart';
import 'package:merchantnationuserapp/models/MenuCartData.dart';
import 'package:merchantnationuserapp/screens/preference_shared/screenSizeConfig.dart';

class MGreenButtonFull extends StatefulWidget {
  var title;
  var icon;
  var totalprice;
  MGreenButtonFull(
      {@required this.title, @required this.icon, this.totalprice});
  @override
  _MGreenButtonFullState createState() => _MGreenButtonFullState();
}

class _MGreenButtonFullState extends State<MGreenButtonFull> {
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    var cardSizeHeight = ScreenSizeConfig.safeBlockVertical * 10;
    var cardSizeWidth = ScreenSizeConfig.safeBlockHorizontal * 100;
    return Container(
      height: cardSizeHeight,
      width: cardSizeWidth,
      decoration: BoxDecoration(
        color: MColors.greendarkshaded,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ScreenSizeConfig.safeBlockHorizontal * 5.5),
          ),
          Container(
              alignment: AlignmentDirectional.centerEnd,
              width: cardSizeWidth * 0.9,
              height: cardSizeHeight,
              child: Text(
                widget.totalprice.toStringAsFixed(3),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeConfig.safeBlockHorizontal * 5.5),
              ))
        ],
      ),
    );
  }
}
