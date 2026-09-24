class WorkoutExercise {
  const WorkoutExercise({
    required this.name,
    required this.details,
    required this.imageIndex,
    this.reps = 15,
  });

  final String name;
  final String details;
  final int imageIndex;
  final int reps;
}
