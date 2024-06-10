import 'package:flutter/material.dart';

import '../client/login.dart';

class BoardingScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> _imageUrls = [
    

    
    
    
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
