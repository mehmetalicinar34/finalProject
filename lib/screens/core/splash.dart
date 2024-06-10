import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  loadData() async {
    Future.delayed(const Duration(milliseconds: 2000), () {
      context.go("/boarding");
    });
  }


  @override
  void initState() {
    // TODO: implement initState  
    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Image.network(
                    "https://img.freepik.com/free-vector/supermarket-logo-concept_23-2148467758.jpg?w=740&t=st=1718042567~exp=1718043167~hmac=0e32fa93204ecb46376b529a2d79980216b26aa30dc931c4a1fd7b254b958038"),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 28.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
