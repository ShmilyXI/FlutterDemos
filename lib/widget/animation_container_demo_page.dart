import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimationContainerDemoPage extends StatefulWidget {
  const AnimationContainerDemoPage({Key? key}) : super(key: key);

  @override
  _AnimationContainerDemoPageState createState() =>
      _AnimationContainerDemoPageState();
}

class _AnimationContainerDemoPageState
    extends State<AnimationContainerDemoPage> {
  // 定义需要执行的滑动效果数值
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadius _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimationContainerDemoPage Demo")),
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(color: _color, borderRadius: _borderRadius),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            final random = math.Random();

            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                random.nextInt(256), 1);
            _borderRadius =
                BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}
