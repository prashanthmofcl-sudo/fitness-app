import 'package:flutter/material.dart';

class ExerciseArtwork extends StatelessWidget {
  const ExerciseArtwork({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth = constraints.maxWidth;
        final column = index % 3;
        final row = index ~/ 3;

        return ClipRect(
          child: Stack(
            children: [
              Positioned(
                left: -column * cellWidth,
                top: -row * cellWidth,
                width: cellWidth * 3,
                height: cellWidth * 2,
                child: Image.asset(
                  'assets/images/workout_plan_exercises.png',
                  fit: BoxFit.fill,
                  excludeFromSemantics: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
