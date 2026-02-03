import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ui/HomeScreen.dart';
import 'package:myapp/ui/SingupScreen.dart';

import '../Widgets/RoundButton.dart';
import '../numberVerification/phoneNumber.dart';
import '../toast/error.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isLoading = false; // <-- loading state
  final formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  FirebaseAuth _Auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    PasswordController.dispose();
    phoneNumberController.dispose();

  }

  void login() async {
    try {
      final userCredential = await _Auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: PasswordController.text.trim(),
      );

      // Login successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Specific Firebase errors
      if (e.code == 'user-not-found') {
        showError(context, "Email not registered. Please register first.");
      } else if (e.code == 'wrong-password') {
        showError(context, "Incorrect password. Please try again.");
      } else if (e.code == 'invalid-email') {
        showError(context, "Invalid email format. Please check your email.");
      } else {
        showError(context, "Login failed. ${e.message}");
      }
    } catch (e) {
      // Any other error
      showError(context, "Something went wrong. ${e.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Screen",style: TextStyle(
          color: Colors.white
        ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        hintText: "@gmail.com",
                        helperText: "enter email"
                      ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return "Enter valid email";
                          }
                          return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: PasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                          labelText: 'password',
                          border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(title: "Login",
              onTap: () {
              if(formKey.currentState!.validate()){
                login();
              }
              },
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Don't have an account "),
                TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=> SingupScreen())
                      );
                    },
                    child: Text("sing up",style: TextStyle(
                      color: Colors.deepPurple
                    ),)
                ),
              ],
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginNumber()));
              },
              child: Container(
                height: height *0.08,
                width: width*0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black45
                  )

                ),
                child: Center(child: Text("Continue with Number"),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
