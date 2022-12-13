import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  
  final String text;

  const AppBarTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.w700
      ),
    );
  }
}