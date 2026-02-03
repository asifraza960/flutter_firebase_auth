import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Widgets/RoundButton.dart';

import '../toast/error.dart';
import 'code.dart';

class LoginNumber extends StatefulWidget {
  const LoginNumber({super.key});

  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  final phoneVerified = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: TextFormField(
                controller: phoneVerified,
                decoration: InputDecoration(
                  hintText: "+92 405 5795 960"
                ),
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(
                title: "Send",
                onTap: (){
                  _auth.verifyPhoneNumber(
                    phoneNumber: phoneVerified.text,
                      verificationCompleted:(_){},
                      verificationFailed: (e) {
                        showError(context, e.toString() ?? " Failed");
                      },
                      codeAutoRetrievalTimeout: (e){
                        showError(context, e.toString() ?? "time out");

                      },
                    codeSent: (String verificationId, int? token){

                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PhoneNumberVerified(verificationId:verificationId)));

                    },
                  );

                })
          ],
        ),
      ),
    );
  }
}
