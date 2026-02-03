import 'package:flutter/material.dart';
import 'package:myapp/firebase_services/splash_Services.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final SplashServices _splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashServices.isLogin(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Firebase Auth",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 20,),
            CircularProgressIndicator(
            )
          ],
        ),
      ),
    );
  }
}
