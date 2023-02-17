import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class Loading extends StatefulWidget
{
  @override
  State<Loading> createState() {
    return _Loading();
  }
}

class _Loading extends State<Loading> {

  @override
  Widget build(BuildContext context) {
      return LoadingAnimationWidget.halfTriangleDot(
        color: cnf.colorMainStreamBlue.toColor(),
        size: 60,
      );
  }
}