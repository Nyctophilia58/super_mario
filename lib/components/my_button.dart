import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final IconData? icon;
  final onPressed;
  static bool holdingButton = false;


  const MyButton({
    super.key,
    this.icon,
    this.onPressed,

  });

  bool userIsHoldingButton(){
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingButton = true;
        onPressed();
      },
      onTapUp: (details) {
        holdingButton = false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.brown[300],
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}