import 'package:flutter/material.dart';
import 'FadeAnimation.dart';
import 'LoginPage.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(
      MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _scaleAnimationController;
  AnimationController _scale2AnimationController;
  AnimationController _widthAnimationController;
  AnimationController _positionAnimationController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;
  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthAnimationController.forward();
            }
          });

    _widthAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _widthAnimation = Tween<double>(begin: 80.0, end: 300.0)
        .animate(_widthAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionAnimationController.forward();
            }
          });

    _positionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _positionAnimation = Tween<double>(begin: 0.0, end: 220.0)
        .animate(_positionAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon=true;
              });
              _scale2AnimationController.forward();
            }
          });

    _scale2AnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2AnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
            Navigator.push(context, PageTransition(child: LoginPage(), type: PageTransitionType.fade));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        width: double.infinity,
        child: Stack(children: <Widget>[
          Positioned(
            top: -50,
            left: 0,
            child: FadeAnimation(
              1,
              Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: 0,
            child: FadeAnimation(
              1.3,
              Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -150,
            left: 0,
            child: FadeAnimation(
              1.6,
              Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                SizedBox(height: 15),
                FadeAnimation(
                  1.3,
                  Text(
                    'Lorem Ipsum has been the industry\'s \nstandard dummy text ever since the 1500s',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7), height: 1.4),
                  ),
                ),
                SizedBox(height: 180),
                FadeAnimation(
                  1.6,
                  AnimatedBuilder(
                    animation: _scaleAnimationController,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _widthAnimationController,
                          builder: (context, child) => Container(
                            width: _widthAnimation.value,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.4),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: InkWell(
                              onTap: () {
                                _scaleAnimationController.forward();
                              },
                              child: Stack(children: <Widget>[
                                AnimatedBuilder(
                                  animation: _positionAnimationController,
                                  builder: (context, child) => Positioned(
                                    left: _positionAnimation.value,
                                    child: AnimatedBuilder(
                                      animation: _scale2AnimationController,
                                      builder: (context, child) =>
                                          Transform.scale(
                                        scale: _scale2Animation.value,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: hideIcon==false ? Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 25,
                                          ) : Container(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
