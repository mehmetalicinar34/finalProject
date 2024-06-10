import 'package:flutter/material.dart';

import '../client/login.dart';

class BoardingScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> _imageUrls = [
    "https://img.freepik.com/free-vector/visual-data-concept-illustration_114360-1912.jpg?t=st=1718040094~exp=1718043694~hmac=9346ad111192c9a2bcc7270efb1b59cc838598edb74a700355d151e5d179bdd6&w=740", 

    "https://img.freepik.com/free-vector/sync-concept-illustration_114360-1029.jpg?t=st=1718040095~exp=1718043695~hmac=5d3884470632a0c8127e8c11f141712a57e219bf2d09a2ce1fce532c7e5b7f49&w=740",
    
    
  ];
  final List<String> _descriptions = [
    "MAKE ORDER",
    "CHOOSE PAYMENT",
    "FAST DELIVERY",
  ];

  BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              return BoardingPage(
                imageUrl: _imageUrls[index],
                description: _descriptions[index],
              );
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoardingPage extends StatelessWidget {
  final String imageUrl;
  final String description;

  const BoardingPage(
      {super.key, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
