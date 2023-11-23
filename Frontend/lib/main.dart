import 'package:flutter/material.dart';
import 'package:foodtoimage/Models/Firebasehelper.dart';
import 'package:foodtoimage/Models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodtoimage/letsgo.dart';
import 'package:foodtoimage/showimage.dart';
import 'package:foodtoimage/login.dart';
import 'start.dart';
import 'startlogin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? currentUser= FirebaseAuth.instance.currentUser;
  if(currentUser!=null){
    UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
    if(thisUserModel!=null){
      runApp(MainLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else{
      runApp(MyApp());
    }

  }
  else{
    runApp(MyApp());}
  // debugShowCheckedModeBanner: false,
  // // home: StartScreen(),
  // initialRoute: 'start',
  // routes: {
  //   'start': (context) => StartScreen(),
  //   'login': (context) => MyLogin(),
  //   // 'choose': (context) => ChooseImage(userMode,firebaseUser),
  //   'showimage': (context) => ShowImage(),
  // }


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StartScreen(),
        initialRoute: 'startlogin',
        routes: {
          'startlogin': (context) => StartLogin(),
          'login': (context) => MyLogin(),
          // 'choose': (context) => ChooseImage(userMode,firebaseUser),
          // 'showimage': (context) => ShowImage(),
          'letsgo': (context) => LetsGo(),
        }
    );
  }
}
class MainLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MainLoggedIn({super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StartScreen(),
        initialRoute: 'start',
        routes: {
          'start': (context) => StartScreen(userModel: userModel, firebaseUser: firebaseUser),
          'login': (context) => MyLogin(),
          // 'choose': (context) => ChooseImage(userMode,firebaseUser),
          // 'showimage': (context) => ShowImage(),
          'letsgo': (context) => LetsGo(),
        }
    );
  }
}