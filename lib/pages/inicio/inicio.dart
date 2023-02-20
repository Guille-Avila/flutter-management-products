import 'package:flutter/material.dart';

// ignore: camel_case_types
class inicio extends StatelessWidget {
  const inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      //padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welcome!',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Admin your bussines easily',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
