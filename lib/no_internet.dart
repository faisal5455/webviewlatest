import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Replace 'assets/no_internet.png' with the path to your image
              Container(
                constraints: const BoxConstraints(maxWidth: 330),
                child: Image.asset(
                  'assets/no_internet.jpg',
                  width: width * 0.8,
                  height: width * 0.8,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'You will be redirected to the home screen once the connection is restored.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NoInternetScreen(),
  ));
}
