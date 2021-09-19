import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchantnationuserapp/constants/m-colors.dart';
import 'package:merchantnationuserapp/models/MenuCartData.dart';
import 'package:merchantnationuserapp/models/Order.dart';
import 'package:merchantnationuserapp/screens/checkout_screens/OrderPlacedScreen.dart';
import 'package:merchantnationuserapp/screens/checkout_screens/shared/MGreenButtonFull.dart';
import 'package:merchantnationuserapp/screens/drawer_screens/settings_screens/AddYourCardScreen.dart';
import 'package:merchantnationuserapp/screens/drawer_screens/settings_screens/SettingsMenu.dart';
import 'package:merchantnationuserapp/screens/drawer_screens/shared/MGreenButton.dart';
import 'package:merchantnationuserapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:merchantnationuserapp/utils/Http-service.dart';
import 'package:merchantnationuserapp/utils/InternetException.dart';
import 'package:merchantnationuserapp/utils/dialog.dart';
import 'package:merchantnationuserapp/utils/progress.dart';
import 'package:uuid/uuid.dart';

class ListPaymentMethods {
  String title;
  String image;
  String number;

  ListPaymentMethods({this.title, this.image, this.number});
}

class PaymentScreen extends StatefulWidget {
  var checkout;
  PaymentScreen({@required this.checkout});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isSwitchedDelivery = false;
  InternetException internetException = InternetException();
  void toggleSwitchDelivery(bool value) {
    if (isSwitchedDelivery == false) {
      setState(() {
        isSwitchedDelivery = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitchedDelivery = false;
      });
      print('Switch Button is OFF');
    }
  }

  List<ListPaymentMethods> listPaymentMethods = [];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DynamoProgressIndicator progressIndicator = new DynamoProgressIndicator();

  @override
  void initState() {
    super.initState();
    //print(widget.data);
    internetException.hasNet().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int total_elements = this.listPaymentMethods.length;
    ScreenSizeConfig().init(context);
    var screenSizeHeight = ScreenSizeConfig.safeBlockVertical * 100;
    var screenSizeWidth = ScreenSizeConfig.safeBlockHorizontal * 100;
    return internetException.connection == false
        ? internetException.NoInternetWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 8.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                "Payment",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            floatingActionButton: InkWell(
              onTap: () async {
                this.progressIndicator.show();
                var uuid = Uuid();
                //post order
                widget.checkout[Order.paymentType] = "Cash";
                widget.checkout[Order.transactionId] = uuid.v4().toString();
                widget.checkout[Order.items] = MenuData.menuCartData.menu;

                DynamoDialog dialog = DynamoDialog(title: 'Order Checkout');
                if (await dialog.showAlertDialog(context)) {
                  print("usama");
                  print(widget.checkout);
                  Response response = await ApiHandler().makePostRequest(
                      ApiRoutes.order + widget.checkout[Order.restaurant],
                      widget.checkout);
                  if (response.statusCode == 200) {
                    progressIndicator.hind();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderPlacedScreen(
                                recipt: widget.checkout,
                              )),
                    );
                  }
                }
              },
              child: MGreenButtonFull(
                totalprice: widget.checkout[Order.netAmount],
                title: 'Pay',
                icon: this.progressIndicator.getStatus() == true
                    ? this.progressIndicator.indicator()
                    : Icons.arrow_forward,
              ),
            ),
            // navroute: OrderPlacedScreen()),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    isSwitchedDelivery == false
                        ? Container(
                            height: screenSizeHeight * 0.03,
                          )
                        : Container(),
                    isSwitchedDelivery == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(total_elements, (index) {
                              return _cardOfService(listPaymentMethods[index],
                                  screenSizeWidth, screenSizeHeight, index);
                            }),
                          )
                        : Container(),
                    Container(
                      height: screenSizeHeight * 0.02,
                    ),
                    isSwitchedDelivery == false
                        ? InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => AddYourCardScreen()),
                              // );
                            },
                            child: Container(
                              width: screenSizeWidth * 0.8,
                              child: Text(
                                "+  Add another",
                                style: TextStyle(
                                    color: MColors.greendarkshaded,
                                    fontSize:
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            4.5),
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      height: screenSizeHeight * 0.15,
                    ),
                    //cash on delivery
                    Container(
                      height: screenSizeHeight * 0.07,
                      width: screenSizeWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: screenSizeWidth * 0.02,
                              ),
                              Container(
                                height: screenSizeWidth * 0.05,
                                width: screenSizeWidth * 0.05,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cashondelivaryicon.png'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                width: screenSizeWidth * 0.02,
                              ),
                              Text(
                                "Cash On Delivery",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            4.5),
                              ),
                            ],
                          ),
                          Container(
                            width: screenSizeWidth * 0.1,
                          ),
                          Switch(
                            onChanged: toggleSwitchDelivery,
                            value: true,
                            activeColor: MColors.greendarkshaded,
                            activeTrackColor: Colors.lightGreen,
                            inactiveThumbColor: Colors.grey[700],
                            inactiveTrackColor: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: screenSizeHeight * 0.13,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _cardOfService(listPaymentMethods, var screenSizeWidth,
      var screenSizeHeight, var index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: screenSizeHeight * 0.12,
          width: screenSizeWidth * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.5), //(x,y)
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: screenSizeHeight * 0.08,
                width: screenSizeWidth * 0.03,
              ),
              //circular dot
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: screenSizeWidth * 0.05,
                    width: screenSizeWidth * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                  ),
                  Container(
                    height: screenSizeWidth * 0.035,
                    width: screenSizeWidth * 0.035,
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == index ? Colors.grey : Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: screenSizeHeight * 0.08,
                width: screenSizeWidth * 0.03,
              ),
              //image eg paypal
              Container(
                height: screenSizeHeight * 0.08,
                width: screenSizeWidth * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(listPaymentMethods.image),
                      fit: BoxFit.fill),
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
              ),
              Container(
                height: screenSizeHeight * 0.08,
                width: screenSizeWidth * 0.2,
              ),
              Container(
                height: screenSizeHeight * 0.08,
                width: screenSizeWidth * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listPaymentMethods.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenSizeConfig.safeBlockHorizontal * 4),
                    ),
                    Row(
                      children: [
                        Text(
                          listPaymentMethods.number.substring(0, 5),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  ScreenSizeConfig.safeBlockHorizontal * 4),
                        ),
                        Text(
                          "******",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  ScreenSizeConfig.safeBlockHorizontal * 4),
                        ),
                        Text(
                          listPaymentMethods.number.substring(
                              listPaymentMethods.number.length - 3,
                              listPaymentMethods.number.length - 1),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  ScreenSizeConfig.safeBlockHorizontal * 4),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
