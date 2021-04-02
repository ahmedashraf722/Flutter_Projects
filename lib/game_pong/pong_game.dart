import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_projects/game_pong/ball.dart';
import 'package:flutter_projects/game_pong/bat.dart';
import 'package:flutter_projects/game_pong/loading_pong.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

enum Direction { up, down, left, right }

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width;
  double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  double diameter = 50;
  int score = 0;
  Animation<double> animation;
  AnimationController controller;

  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  double increment = 5;

  double randX = 1;
  double randY = 1;

  @override
  void initState() {
    playQRScannerSound();
    posX = 0;
    posY = 0;
    Future.delayed(Duration(seconds: 2), () {
      controller = AnimationController(
        vsync: this,
        duration: Duration(hours: 400),
      );

      animation = Tween<double>(begin: 0, end: 100).animate(controller);
      animation.addListener(() {
        safeSetState(() {
          (hDir == Direction.right)
              ? posX += ((increment * randX).round())
              : posX -= ((increment * randX).round());
          (vDir == Direction.down)
              ? posY += ((increment * randY).round())
              : posY -= ((increment * randY).round());
        });
        checkBorders(diameter);
      });
      controller.forward();
    });
    // controller.repeat();
    super.initState();
  }

  playQRScannerSound() async {
    await AssetsAudioPlayer.newPlayer().open(
      Audio("assets/ponn.wav"),
      autoStart: true,
      forceOpen: true,
      loopMode: LoopMode.single,
    );
  }

  checkBorders(double d) {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - d && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    //check the bat position as well
    if (posY >= height - d - batHeight && vDir == Direction.down) {
      if (posX >= (batPosition - d) && posX <= (batPosition + batWidth + d)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score = score + 10;
        });
      } else {
        controller.stop();
        showMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }

  double randomNumber() {
    // number between 0.5 and 1.5;
    var random = new Random();
    int myNum = random.nextInt(601);
    return (75 + myNum) / 100;
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Game Over',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text('Would you like to play again?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
                child: Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Loading()),
                      (route) => true);
                  // dispose();
                },
                child: Text("No"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffefcf),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Score: ' + score.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff864000),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          height = constraints.maxHeight;
          width = constraints.maxWidth;
          batWidth = width / 3;
          batHeight = height / 25;
          return Stack(
            children: [
              Positioned(
                child: Ball(),
                top: posY,
                left: posX,
              ),
              Positioned(
                bottom: 6,
                left: batPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails update) =>
                      moveBat(update),
                  child: Bat(
                    batWidth,
                    batHeight,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
