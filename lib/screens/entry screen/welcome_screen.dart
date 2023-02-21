import 'dart:ui';

import '../auth/registration_screen.dart';
import '../auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/Button_properties.dart';
import 'package:messenger/services/navigation_management.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'dart:math' as math;

import 'CenterWidgetClipper.dart';

//kbackgroundcolo=Color(0xFFD2FFF4),kprimary=Color(0xFF2D5D80),ksecondary=Color(0xFF265DAB),

class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  Widget topbind(double screenwidth){
    return Transform.rotate(
      angle: -35 *math.pi/180,
      child: Container(
        width: 1.2 * screenwidth,
        height: 1.2 * screenwidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: LinearGradient(
            begin: Alignment(-1,-0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color(0xFF20B7D2),
            ],
          )
        ),
      ),
    );
  }
  Widget centerbind(double screensize){

    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final path=Path();
    path.moveTo(0, 0.17 * height);
    path.cubicTo(
      0.23 *width,
      0.12 *height,
      0.36 *width,
      0.13 *height,
      0.48 *width,
      0.14 *height,
    );
    path.cubicTo(
        0.6 * width,
        0.15 * height,
        0.91 * width,
        0.23 * height,
        0.94 * width,
        0.34 * height,
    );
    path.cubicTo(
        0.97 * width,
        0.46 * height,
        0.74 * width,
        0.46 * height,
        0.66 * width,
        0.56 * height,);
    path.cubicTo(
        0.58 * width,
        0.66 * height,
        0.72 * width,
        0.73 * height,
        0.68 * width,
        0.81 * height,);
    path.cubicTo(
            0.63 *width,
            0.89 * height,
            0.45 * width,
            0.97 * height,
            0.3 * width,
            height,);
    path.lineTo(0, height);
    path.close;
    return Stack(
      children: [
        ClipPath(
          clipper: CenterWidgetClipper(path:path),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1,-0.6),
                  end: Alignment(-1,0.8),
                  colors: [
                    Color(0xFF20B7D2),
                    Color(0x4D447CE3),
                  ],
                )
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bottombind(double screensize){
    return Container(
      width: 1.5 * screensize,
      height: 1.5 * screensize,
      decoration:const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6,-1.1),
          end: Alignment(0.7,0.8),
          colors: [
            Color(0xFF2079D2),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screensize=MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -160,
              left: -30,
              bottom: 400,

              child: topbind(screensize.width),),
            Positioned(
              top: 400,
              left: 20,
              bottom: -400,
              child: bottombind(screensize.width),),
            centerbind(screensize.width),
            Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Row(
                        children: [
                          AnimatedTextKit(

                            animatedTexts:[
                            TyperAnimatedText("HELLO THERE.... ",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),speed: const Duration(milliseconds: 200)),
                            TyperAnimatedText("AND..  ",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),speed: const Duration(milliseconds: 100)),
                            TyperAnimatedText("WELCOME... ",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),speed: const Duration(milliseconds: 200)),

                          ],repeatForever: true,
                            pause: const Duration(milliseconds: 1500),

                          ),
                          ],
                      ),
                      SizedBox(height: 50,),
                      ButtonProperties(
                        colour: Colors.lightBlueAccent,
                        label: 'Log In',
                        onpressed: (){
                          Navigation.pushNamedAndReplace(context, LoginScreen.id);
                        },
                      ),
                      ButtonProperties(
                          colour: Colors.blueAccent,
                          onpressed: (){
                            Navigation.pushNamedAndReplace(context, RegistrationScreen.id);
                          },
                          label: 'Register'
                      ),

                    ]
                ),
              ),
            ),


          ],
        )
    );
  }
}
