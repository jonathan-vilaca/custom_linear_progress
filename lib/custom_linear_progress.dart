// ignore_for_file: public_member_api_docs, sort_constructors_first
library custom_linear_progress;

import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  ///Int or double values ​​between 0 and 100
  final num percent;

  ///Progress bar color
  final Color colorProgressGradient;

  ///Background bar color
  final Color backgroundColor;

  ///Progress bar height
  final double? height;

  ///Radius border progress bar
  final double? radius;

  ///Default is false;
  final bool gradient;

  ///Milliseconds delayed animation
  final int duration;

  ///Animated color
  final bool animated;

  const CustomProgressBar({
    required this.percent,
    required this.colorProgressGradient,
    required this.backgroundColor,
    Key? key,
    this.height,
    this.radius,
    this.gradient = false,
    this.duration = 750,
    this.animated = false,
  }) : super(key: key);

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double getPercentProgress(dynamic value, double width) {
    double _total = double.parse(width.toString());
    double _percent = double.parse(value.toString());
    var _percentProgress = (_percent * _total) / 100;
    return _percentProgress;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, bc) {
      return Stack(
        children: [
          Container(
            width: bc.maxWidth,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: SizedBox(height: widget.height ?? size.width * .05),
          ),
          widget.animated
              ? ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(stops: [
                      _animation.value - 0.2,
                      _animation.value + 0.2
                    ], colors: [
                      widget.colorProgressGradient.withOpacity(0.5),
                      widget.colorProgressGradient,
                    ]).createShader(bounds);
                  },
                  child: ProgressBarrCustom(
                    colorProgressGradient: widget.colorProgressGradient,
                    duration: widget.duration,
                    height: widget.height,
                    maxWidth: bc.maxWidth,
                    percent: widget.percent,
                  ),
                )
              : ProgressBarrCustom(
                  colorProgressGradient: widget.colorProgressGradient,
                  duration: widget.duration,
                  height: widget.height,
                  maxWidth: bc.maxWidth,
                  percent: widget.percent,
                ),
        ],
      );
    });
  }
}

class ProgressBarrCustom extends StatefulWidget {
  final num percent;
  final double maxWidth;
  final Color colorProgressGradient;
  final double? height;
  final int duration;

  const ProgressBarrCustom({
    Key? key,
    required this.percent,
    required this.maxWidth,
    required this.colorProgressGradient,
    required this.height,
    required this.duration,
  }) : super(key: key);

  @override
  State<ProgressBarrCustom> createState() => _ProgressBarrCustomState();
}

class _ProgressBarrCustomState extends State<ProgressBarrCustom> {
  double getPercentProgress(dynamic value, double width) {
    double _total = double.parse(width.toString());
    double _percent = double.parse(value.toString());
    var _percentProgress = (_percent * _total) / 100;
    return _percentProgress;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      width: getPercentProgress(widget.percent, widget.maxWidth),
      duration: Duration(milliseconds: widget.duration),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          widget.colorProgressGradient.withOpacity(0.5),
          widget.colorProgressGradient,
        ]),
        borderRadius: widget.percent.toInt() >= 100
            ? const BorderRadius.all(Radius.circular(4))
            : const BorderRadius.only(
                bottomLeft: Radius.circular(4), topLeft: Radius.circular(4)),
      ),
      child: SizedBox(
        height: widget.height ?? size.width * .05,
      ),
    );
  }
}
