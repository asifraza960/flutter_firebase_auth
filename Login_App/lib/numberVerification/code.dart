import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ui/HomeScreen.dart';

import '../Widgets/RoundButton.dart';

class PhoneNumberVerified extends StatefulWidget {
  String  verificationId;
   PhoneNumberVerified({super.key , required this.verificationId});

  @override
  State<PhoneNumberVerified> createState() => _PhoneNumberVerifiedState();
}

class _PhoneNumberVerifiedState extends State<PhoneNumberVerified> {
  final codeVerifiedController = TextEditingController();
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
                controller: codeVerifiedController,
                decoration: InputDecoration(
                  hintText: "enter the code",
                   border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(
                title: "Confirm",
                onTap: () async{
                  final credential = PhoneAuthProvider.credential(
                      verificationId:widget.verificationId,
                      smsCode: codeVerifiedController.text.toString()
                  );

                    try {
                      await _auth.signInWithCredential(credential);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> Homescreen())
                      );

                  }catch(e){

                  }

                })
          ],
        ),
      ),
    );
  }
}
