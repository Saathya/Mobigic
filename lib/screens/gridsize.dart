// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic/screens/alphabets.dart';

class EnterGridSizeScreen extends StatefulWidget {
  const EnterGridSizeScreen({super.key});

  @override
  State<EnterGridSizeScreen> createState() => _EnterGridSizeScreenState();
}

class _EnterGridSizeScreenState extends State<EnterGridSizeScreen> {
  int m = 0;
  int n = 0;

  int _backButtonPressCount = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_backButtonPressCount == 1) {
          // If back button is pressed twice, exit the app
          SystemNavigator.pop();
          return true;
        } else {
          // Show a message or perform any other action on the first back button press
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
            ),
          );

          // Increment the back button press count
          _backButtonPressCount++;

          // Cancel the back button press by returning false
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Enter Grid Size',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color to white
                borderRadius: BorderRadius.circular(
                    12.0), // Optional: Add border radius for a rounded appearance
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 18),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          m = int.tryParse(value) ?? 0;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter number of rows (m)',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 18),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          n = int.tryParse(value) ?? 0;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter number of columns (n)',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EnterAlphabetsScreen(m: m, n: n),
                        ),
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
