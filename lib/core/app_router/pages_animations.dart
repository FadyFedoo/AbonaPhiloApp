import 'package:flutter/material.dart';

FadeTransition fadeTransition({required animation, required child}) =>
    FadeTransition(opacity: animation, child: child);

SlideTransition sideTransitionFromDownToUp(
        {required animation, required child}) =>
    SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        )),
        child: child);

SlideTransition sideTransitionFromDownToUpWithFadeTransition(
        {required animation, required child}) =>
    SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        )),
        child: FadeTransition(opacity: animation, child: child));

SlideTransition sideTransitionFromUpToDown(
        {required animation, required child}) =>
    SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        )),
        child: child);

SlideTransition sideTransitionFromLtoR({required animation, required child}) =>
    SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        )),
        child: child);

SlideTransition sideTransitionFromRtoL({required animation, required child}) =>
    SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        )),
        child: child);
