library custom_linear_progress;

import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  ///Int or double values ​​between 0 and 100
  final num percent;

  ///Progress bar color
  final Color colorProgress;

  ///Background bar color
  final Color backgroundColor;

  ///Progress bar height
  final double? height;

  ///Radius border progress bar
  final double? radius;

  ///Default is false;
  final bool gradient;

  ///Milliseconds delayed animation
  final int delayed;

  const CustomProgressBar({
    required this.percent,
    required this.colorProgress,
    required this.backgroundColor,
    Key? key,
    this.height,
    this.radius,
    this.gradient = false,
    this.delayed = 750,
  }) : super(key: key);

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
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
          AnimatedContainer(
            width: getPercentProgress(widget.percent, bc.maxWidth),
            duration: Duration(milliseconds: widget.delayed),
            decoration: BoxDecoration(
              color: widget.gradient ? null : widget.colorProgress,
              gradient: !widget.gradient
                  ? null
                  : LinearGradient(
                      colors: [
                        widget.colorProgress.withOpacity(0.5),
                        widget.colorProgress,
                      ],
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(widget.radius ?? 4),
              ),
            ),
            child: SizedBox(
              height: widget.height ?? size.width * .05,
            ),
          ),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.radius ?? 4),
              ),
            ),
            child: SizedBox(
              height: widget.height ?? size.width * .05,
            ),
          ),
        ],
      );
    });
  }
}
