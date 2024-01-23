import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobigic/screens/gridsize.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobigic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  late String poweredByText = '';
  late Timer _textTimer;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EnterGridSizeScreen()),
      ),
    );
    // Logo Animation
    _logoController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _textTimer = Timer.periodic(const Duration(milliseconds: 65), (timer) {
      setState(() {
        if (poweredByText.length < 48) {
          poweredByText =
              'Created By Vishal Pandey'.substring(0, poweredByText.length + 1);
        } else {
          _textTimer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textTimer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/splash.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),

          // White Faded Blur Overlay
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.01),
          ),

          // Powered By
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 16,
            right: 16,
            child: Center(
              child: Text(
                poweredByText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (screenWidth >= 280 && screenWidth <= 540)
                      ? MediaQuery.of(context).size.width * 0.038
                      : MediaQuery.of(context).size.width * 0.015,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
