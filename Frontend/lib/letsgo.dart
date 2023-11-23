// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtoimage/choose.dart';
import 'package:foodtoimage/Models/UIHelper.dart';
import 'package:foodtoimage/Models/userModel.dart';
import 'package:foodtoimage/showimage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LetsGo extends StatefulWidget {

  const LetsGo({Key? key}) : super(key: key);

  @override
  State<LetsGo> createState() => _LetsGoState();
}

class _LetsGoState extends State<LetsGo> {

  TextEditingController emailcontroller = TextEditingController();

  void checkValues() {
    String email = emailcontroller.text.trim();


    if (email == "") {
      Fluttertoast.showToast(msg: 'Please Enter your Valid Email!!');
    }
    else {
      submit(email);
    }
  }

  void submit(String email) async {
    UserCredential? credential;
    UIHelper.showLoadingDialog(context, "We are getting you in>>");
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: 'ftimage@123');
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      UIHelper.showAlertDialog(context, "An Error Occured", ex.message.toString());
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(ex.code.toString())));
    }


    if (credential != null) {
      // UIHelper.showLoadingDialog(context, "We are getting you in>>");
      String uid = credential.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection(
          'users').doc(uid).get();
      UserModel userModel = UserModel.fromMap(
          userData.data() as Map<String, dynamic>);

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChooseImage(
                userModel: userModel, firebaseUser: credential!.user!);
          })
      );
      //   });
      // }
    }}


    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/8.jpg'),
              fit: BoxFit.cover,
              opacity: 0.7, // Default: 0.5

            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Container(
              //
              //   padding: EdgeInsets.only(left: 30, top: 30),
              //   child: Text('Hi,\nWelcome', style: TextStyle(
              //       color: Colors.black, fontSize: 35
              //
              //   ),)
              //   ,
              //
              // ),
              // Container(
              //   padding: EdgeInsets.only(left: 190, top: 100),
              //   child: Icon(Icons.waving_hand, color: Colors.yellow, size: 30,
              //   ),
              // ),

              Container(
                padding: EdgeInsets.only(left: 30,right: 20, top: 250),
                child: Text(
                  'Kindly use the same email which you already used for this App',
                  style: TextStyle(
                    color: Colors.white, fontSize: 16,
                  ),),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.39, right: 30, left: 30),
                  child: Column(
                    children: [

                      TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.white54,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // Center(
                      //
                      //   child: Container(
                      //     child: DropDownFormField(
                      //
                      //       titleText: 'Are You Researcer?' ,
                      //       hintText: 'Please select one',
                      //       value: valueChose,
                      //       onChanged: (newValue){
                      //           setState(() {
                      //             valueChose = newValue;
                      //           });
                      //         },
                      //
                      //     ),
                      //   ),
                      // )
                      //       Center(
                      //
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(0.0),
                      //     child: Container(
                      //
                      //       decoration: BoxDecoration(
                      //         color: Colors.white30,
                      //         border: Border.all(color: Colors.black),
                      //         borderRadius: BorderRadius.circular(10)
                      //       ),
                      //       child: DropdownButton(
                      //
                      //                 hint: Text('  Are You A Reseracher '),
                      //                 dropdownColor: Colors.white,
                      //                 icon: Icon(Icons.arrow_drop_down),
                      //                 iconSize: 36,
                      //                 iconEnabledColor: Colors.black,
                      //                 isExpanded: true,
                      //                 value: valueChose,
                      //                 underline: Container(),
                      //                 onChanged: (newValue){
                      //                   setState(() {
                      //                     valueChose = newValue;
                      //                   });
                      //                 },
                      //
                      //                 items: listitem.map((valueItem) {
                      //                   return DropdownMenuItem(
                      //                     value: valueItem,
                      //                       child: Text(valueItem),
                      //                   );
                      //                 }).toList(),
                      //               ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(onPressed: () {
                        checkValues();
                        // Navigator.pushNamed(context, 'choose');
                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,


                            fixedSize: Size(200, 50),
                            textStyle: TextStyle(fontSize: 19),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.brown))
                        ),

                        child: Text('SUBMIT'),


                      )


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

}


