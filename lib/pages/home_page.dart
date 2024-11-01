import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario/character/jumping_mario.dart';
import 'package:super_mario/character/mushroom.dart';
import 'package:super_mario/components/my_button.dart';
import 'package:super_mario/character/mario.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 50;

  double shroomX = 0.5;
  double shroomY = 1;

  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';

  bool midrun = false;
  bool midjump = false;

  var gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
  );

  void eatShrooms(){
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05){
      setState(() {
        shroomX = 2;
        marioSize = 100;
      });
    }
  }

  void preJump() {
    initialHeight = marioY;
    time = 0;
  }

  void jump() {
    if (midjump == false) {
      midjump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;
          timer.cancel();
          setState(() {
            marioY = 1;
          });
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight(){
    direction = 'right';
    eatShrooms();
    Timer.periodic(const Duration(milliseconds: 50), (timer){
      eatShrooms();
      if (const MyButton().userIsHoldingButton() == true && (marioX + 0.02)< 1){
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      }
      else{
        timer.cancel();
      }
    });
  }

  void moveLeft(){
    direction = 'left';
    eatShrooms();
    Timer.periodic(const Duration(milliseconds: 50), (timer){
      eatShrooms();
      if (const MyButton().userIsHoldingButton() == true && (marioX - 0.02) > -1){
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      }
      else{
        timer.cancel();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children:[
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: const Duration(milliseconds: 0),
                    child: midjump
                      ? JumpingMario(direction: direction, size: marioSize,)
                      : Mario(
                        direction: direction,
                        midrun: midrun,
                        size: marioSize,
                       ),
                  ),
                ),
                Container(
                  alignment: Alignment(shroomX, shroomY),
                  child: const MyShroom()
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "MARIO",
                            style: gameFont,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "0000",
                            style: gameFont,
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Text(
                            "WORLD",
                            style: gameFont,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "1-1",
                            style: gameFont,
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Text(
                            "TIME",
                            style: gameFont,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "9999",
                            style: gameFont,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    icon: Icons.arrow_back,
                    onPressed: moveLeft,
                  ),

                  MyButton(
                    icon: Icons.arrow_upward,
                    onPressed: jump,
                  ),

                  MyButton(
                    icon: Icons.arrow_forward,
                    onPressed: moveRight,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}