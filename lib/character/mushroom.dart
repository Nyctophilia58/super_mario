import 'package:flutter/material.dart';

class MyShroom extends StatelessWidget {

  const MyShroom({
  super.key,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset('lib/assets/images/mushroom.png'),
    );
  }
}