import 'package:flutter/material.dart';

createSlideRouteTransition(
    Offset begin, Offset end, Curve curve, Widget route) {
  return PageRouteBuilder(
      pageBuilder: (context, __, ___) => route,
      transitionsBuilder: (context, animation, _, child) {
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
