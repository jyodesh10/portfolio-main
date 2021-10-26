import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:portfolio/about.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({Key? key}) : super(key: key);

  @override
  _BackgroundAnimationState createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: 200,
            speedOfParticles: 1,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: Colors.white.withAlpha(150),
            awayAnimationDuration: Duration(milliseconds: 600),
            maxParticleSize: 8,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              Colors.cyan.withAlpha(210),
              Colors.grey.withAlpha(210),
              Colors.amber.withAlpha(210),
              Colors.green.withAlpha(210)
            ],
            awayAnimationCurve: Curves.easeInOutBack,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 90,
            connectDots: false,

            //not recommended
          ),
        ],
      ),
    );
  }
}
