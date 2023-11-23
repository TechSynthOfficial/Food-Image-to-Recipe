import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodtoimage/choose.dart';
import 'package:foodtoimage/Models/Firebasehelper.dart';
import 'package:foodtoimage/Models/userModel.dart';
import 'package:foodtoimage/starter.dart';

import 'login.dart';

class StartLogin extends StatefulWidget {
  const StartLogin({Key? key}) : super(key: key);

  @override
  State<StartLogin> createState() => _StartLoginState();
}

class _StartLoginState extends State<StartLogin> {
  @override
  void initState(){
    Timer(const Duration(seconds:2), () {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return mainPage();
          }));
      // Navigator.push(
      //      context,
      //      MaterialPageRoute(builder: (context){
      //    return MyLogin();
      //  }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/1.jpg'),fit: BoxFit.cover,
            ),
          ),
        )
    );

  }
}
