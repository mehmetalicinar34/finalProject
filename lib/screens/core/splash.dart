import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/core/themes.dart';
import 'package:flutter_advanced_dev/screens/core/cache.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Map<String, dynamic> pageConfig = {};
  bool configLoaded = false;

  loadData() async {
    CacheSystem cs = CacheSystem();
    final pageConfig = await cs.getSplashConfig();

    setState(() {
      this.pageConfig = pageConfig;
      configLoaded = true;
    });

    Future.delayed(Duration(milliseconds: pageConfig["duration"]), () {
      context.go("/boarding");
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return !configLoaded
    ? const SizedBox()
    : Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: pageConfig["backgroundColor"].isNotEmpty
                ? HexColor(pageConfig["backgroundColor"])
                : null,
          ),
          child: Stack(
            children: [
              Center(
                child: Image.network(pageConfig["logo"]),
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
