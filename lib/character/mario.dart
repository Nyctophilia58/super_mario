import 'dart:math';
import 'package:flutter/material.dart';

class Mario extends StatelessWidget {

  final direction;
  final midrun;
  final size;

  const Mario({
    super.key,
    this.direction,
    this.midrun,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return Container(
        width: size,
        height: size,
        child: midrun
            ? Image.asset('lib/assets/images/running_mario.png')
            : Image.asset('lib/assets/images/standing_mario.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midrun
              ? Image.asset('lib/assets/images/running_mario.png')
              : Image.asset('lib/assets/images/standing_mario.png'),
        ),
      );
    }
  }
}