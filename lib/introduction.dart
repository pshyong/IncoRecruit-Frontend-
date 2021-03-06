/// Carousel Page / Slideshow Page
///
/// the purpose of this page is to let people know more about Arezue and
/// give them the option to register or login.

import 'package:arezue/services/auth.dart';
import 'package:arezue/login_page.dart';
import 'package:arezue/utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:arezue/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> slides = [
  // slide images
  ArezueTexts.slide00,
  ArezueTexts.slide01,
  ArezueTexts.slide02,
  ArezueTexts.slide03,
  ArezueTexts.slide04
];

final List<String> slideTexts = [
  // slide texts
  ArezueTexts.slide00Text,
  ArezueTexts.slide01Text,
  ArezueTexts.slide02Text,
  ArezueTexts.slide03Text,
  ArezueTexts.slide04Text,
];

final Widget placeholder = Container(color: ArezueColors.outPrimaryColor);

final List child = map<Widget>(
  slides,
  (index, i) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(i),
            Padding(
              padding: new EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Text(
                slideTexts[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ArezueColors.outSecondaryColor,
                  fontSize: 22,
                  fontFamily: 'Arezue',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  CarouselWithIndicator({Key key, this.auth, this.onSignIn}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    // Page build function
    return Stack(children: <Widget>[
      CarouselSlider(
        items: child,
        autoPlay: true,
        viewportFraction: 1.0,
        height: MediaQuery.of(context).size.height - 40,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        scrollDirection: Axis.horizontal,
        autoPlayInterval: Duration(seconds: 6),
        pauseAutoPlayOnTouch: Duration(seconds: 20),
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Positioned(
        bottom: 100,
        child: new Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: map<Widget>(
              slides,
              (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(255, 255, 255, 1.0)
                          : Color.fromRGBO(255, 255, 255, 0.5)),
                );
              },
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        child: new Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                // Signup Button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: ArezueColors.outSecondaryColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new LoginPage(
                              auth: widget.auth,
                              onSignIn: widget.onSignIn,
                              formType: FormType.jobseekerRegister,
                            ),
                        fullscreenDialog: true),
                  );
                },
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                color: ArezueColors.outPrimaryColor,
                child: Text(ArezueTexts.createAccount,
                    style: TextStyle(
                      color: ArezueColors.outSecondaryColor,
                      fontSize: 18,
                      fontFamily: 'Arezue',
                      fontWeight: FontWeight.w400,
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              RaisedButton(
                // Signin Button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: ArezueColors.outSecondaryColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(
                              auth: widget.auth,
                              onSignIn: widget.onSignIn,
                              formType: FormType.login,
                            ),
                        fullscreenDialog: true),
                  );
                },
                padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                color: ArezueColors.outSecondaryColor,
                child: Text(ArezueTexts.signin,
                    style: TextStyle(
                      color: ArezueColors.outPrimaryColor,
                      fontSize: 18,
                      fontFamily: 'Arezue',
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class Intro extends StatelessWidget {
  Intro({Key key, this.auth, this.onSignIn}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    // Page Build Function
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ArezueColors.outPrimaryColor,
        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(children: [
                  CarouselWithIndicator(
                    auth: auth,
                    onSignIn: onSignIn,
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
