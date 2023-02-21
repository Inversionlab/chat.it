import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:messenger/constants.dart';
import 'package:messenger/screens/entry%20screen/set-avatar-screen.dart';
import 'package:messenger/widgets/Button_properties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/screens/auth/login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:messenger/services/navigation_management.dart';
import '../../services/data management/data_management.dart';
import '../../services/data management/stored_string_collection.dart';
import 'package:messenger/screens/search_screen.dart';
import 'dart:math' as math;

import '../entry screen/CenterWidgetClipper.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  final _firebase = FirebaseFirestore.instance;
  bool spinner = false;
  late String firstname;
  late String lastname;
  late String username;
  late String email;
  late String password;
  late String docId;
  List<String> specialList = ['blind', 'deaf', 'mute', 'deaf&mute', 'none'];
  String specialAbility = 'none';
  late Map<String, dynamic> userData;
  final _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;
  TextEditingController firstnameCtrl = TextEditingController();
  TextEditingController lastnameCtrl = TextEditingController();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();


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

      backgroundColor: Colors.white,
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
          Padding(
            padding: EdgeInsets.only(left: 50),
            child: SizedBox(height: 300,width: 300,
              child:Lottie.network('https://assets6.lottiefiles.com/packages/lf20_p5yomfw6.json'),),
          ),

          Padding(
            padding: EdgeInsets.only(top: 100),
            child: ModalProgressHUD(
              inAsyncCall: spinner,
              child: Container(
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  return (value?.isEmpty)! ? 'Required Field' : null;
                                },
                                autofocus: true,
                                controller: firstnameCtrl,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  firstname = value;
                                },
                                decoration: kInputButtonStyle.copyWith(
                                    hintText: 'First Name',fillColor: Colors.white,filled: true),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  return (value?.isEmpty)! ? 'Required Field' : null;
                                },
                                controller: lastnameCtrl,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  lastname = value;
                                },
                                decoration:
                                kInputButtonStyle.copyWith(hintText: 'Last Name',fillColor: Colors.white,filled: true),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            return (value?.length)! < 5
                                ? 'Username should have at least 5 characters'
                                : null;
                          },
                          controller: usernameCtrl,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            username = value;
                          },
                          decoration:
                          kInputButtonStyle.copyWith(hintText: 'Username',fillColor: Colors.white,filled: true),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            const Text('Special Ability :'),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                child: DropdownButtonFormField(
                                  decoration: kInputButtonStyle,
                                  value: specialAbility,
                                  items: specialList.map((item) => DropdownMenuItem<String>(
                                      value: item, child: Text(item))).toList(),
                                  onChanged: (item) => setState(() => specialAbility = item!),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!)
                                ? null
                                : 'Enter valid email';
                          },
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kInputButtonStyle.copyWith(hintText: 'Email',fillColor: Colors.white,filled: true),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                            validator: (value) {
                              return (value?.length)! < 6
                                  ? 'Password should have at least 6 characters'
                                  : null;
                            },
                            controller: passwordCtrl,
                            textAlign: TextAlign.center,
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration:
                            kInputButtonStyle.copyWith(hintText: 'Password',fillColor: Colors.white,filled: true)),
                        const SizedBox(
                          height: 24.0,
                        ),
                        ButtonProperties(
                            colour: Colors.blueAccent,
                            onpressed: () async {
                              setState(() {
                                spinner = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                await _registerUser();
                              } else {
                                setState(() => _autoValidate);
                              }
                              setState(() => spinner = false);
                            },
                            label: 'Register'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Already have an account?',
                                style: TextStyle(color: Colors.black87)),
                            TextButton(
                                onPressed: () {
                                  Navigation.pushNamedAndReplace(
                                      context, LoginScreen.id);
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,color: Colors.white
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _registerUser() async {
    try {
      print(password);
      print(email);


      final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        userData = {
          'firstname': firstname,
          'lastname': lastname,
          'ability': specialAbility,
          'username': username,
          'sender': email,
          'profileImg': 'null',
        };
        final docId=_auth.currentUser!.uid;
        await _firebase
            .collection('users').doc(docId)
            .set(userData);

        Navigation.intentNamed(context, SetAvatarScreen.id);
        await DataManagement.storeStringData(StoredString.userAuthId, _auth.currentUser!.uid);
      }

    } catch (e) {
      print(e);
      _snackBar(e.toString());
    }
  }

  _snackBar(String error){
    final snackBar=SnackBar(
      content: Text(error,style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.redAccent,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
