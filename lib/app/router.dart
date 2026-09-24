import 'package:fitness_app/app/routes.dart';
import 'package:fitness_app/features/auth/screens/forgot_password_screen.dart';
import 'package:fitness_app/features/auth/screens/login_screen.dart';
import 'package:fitness_app/features/auth/screens/signup_screen.dart';
import 'package:fitness_app/features/assessment/screens/personal_info_screen.dart';
import 'package:fitness_app/features/assessment/screens/body_info_screen.dart';
import 'package:fitness_app/features/assessment/screens/goal_selection_screen.dart';
import 'package:fitness_app/features/assessment/screens/fitness_plan_screen.dart';
import 'package:fitness_app/features/assessment/screens/workout_preferences_screen.dart';
import 'package:fitness_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:fitness_app/features/dashboard/screens/log_screen.dart';
import 'package:fitness_app/features/dashboard/screens/notification_screen.dart';
import 'package:fitness_app/features/exercise_library/screens/workout_database_screen.dart';
import 'package:fitness_app/features/nutrition/screens/nutrition_summary_screen.dart';
import 'package:fitness_app/features/nutrition/screens/food_database_screen.dart';
import 'package:fitness_app/features/nutrition/models/food_item.dart';
import 'package:fitness_app/features/nutrition/screens/food_detail_screen.dart';
import 'package:fitness_app/features/profile/screens/favourites_screen.dart';
import 'package:fitness_app/features/profile/screens/profile_screen.dart';
import 'package:fitness_app/features/progress/screens/activity_overview_screen.dart';
import 'package:fitness_app/features/progress/screens/overall_progress_screen.dart';
import 'package:fitness_app/features/settings/screens/settings_screen.dart';
import 'package:fitness_app/features/workout/screens/workout_plan_screen.dart';
import 'package:fitness_app/features/workout/models/workout_exercise.dart';
import 'package:fitness_app/features/workout/screens/current_workout_screen.dart';
import 'package:fitness_app/features/workout/screens/workout_timer_screen.dart';
import 'package:fitness_app/features/workout/screens/workout_detail_screen.dart';
import 'package:fitness_app/features/onboarding/screens/onboarding_one_screen.dart';
import 'package:fitness_app/features/onboarding/screens/onboarding_three_screen.dart';
import 'package:fitness_app/features/onboarding/screens/onboarding_two_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcomePath,
  routes: [
    GoRoute(
      name: AppRoutes.splashName,
      path: AppRoutes.splashPath,
      redirect: (context, state) => AppRoutes.welcomePath,
    ),
    GoRoute(
      name: AppRoutes.welcomeName,
      path: AppRoutes.welcomePath,
      builder: (context, state) => OnboardingOneScreen(
        onNext: () => context.go(AppRoutes.onboardingTwoPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.onboardingTwoName,
      path: AppRoutes.onboardingTwoPath,
      builder: (context, state) => OnboardingTwoScreen(
        onNext: () => context.go(AppRoutes.onboardingThreePath),
      ),
    ),
    GoRoute(
      name: AppRoutes.onboardingThreeName,
      path: AppRoutes.onboardingThreePath,
      builder: (context, state) => OnboardingThreeScreen(
        onGetStarted: () => context.go(AppRoutes.loginPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.loginName,
      path: AppRoutes.loginPath,
      builder: (context, state) => LoginScreen(
        onBack: () => context.go(AppRoutes.onboardingThreePath),
        onLogin: () => context.go(AppRoutes.personalInfoPath),
        onForgotPassword: () => context.go(AppRoutes.forgotPasswordPath),
        onGoogleLogin: () {},
        onSignUp: () => context.go(AppRoutes.signupPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.forgotPasswordName,
      path: AppRoutes.forgotPasswordPath,
      builder: (context, state) => ForgotPasswordScreen(
        onBack: () => context.go(AppRoutes.loginPath),
        onBackToLogin: () => context.go(AppRoutes.loginPath),
        onSendResetLink: () {},
      ),
    ),
    GoRoute(
      name: AppRoutes.signupName,
      path: AppRoutes.signupPath,
      builder: (context, state) => SignupScreen(
        onBack: () => context.go(AppRoutes.loginPath),
        onCreateAccount: () {},
        onLogin: () => context.go(AppRoutes.loginPath),
        onTermsPressed: () {},
      ),
    ),
    GoRoute(
      name: AppRoutes.personalInfoName,
      path: AppRoutes.personalInfoPath,
      builder: (context, state) => PersonalInfoScreen(
        onBack: () => context.go(AppRoutes.loginPath),
        onNext: () => context.go(AppRoutes.bodyInfoPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.bodyInfoName,
      path: AppRoutes.bodyInfoPath,
      builder: (context, state) => BodyInfoScreen(
        onBack: () => context.go(AppRoutes.personalInfoPath),
        onNext: () => context.go(AppRoutes.goalSelectionPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.goalSelectionName,
      path: AppRoutes.goalSelectionPath,
      builder: (context, state) => GoalSelectionScreen(
        onBack: () => context.go(AppRoutes.bodyInfoPath),
        onNext: () => context.go(AppRoutes.resultSummaryPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.workoutTypeName,
      path: AppRoutes.workoutTypePath,
      builder: (context, state) => WorkoutPreferencesScreen(
        onBack: () => context.go(AppRoutes.goalSelectionPath),
        onNext: () => context.go(AppRoutes.resultSummaryPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.resultSummaryName,
      path: AppRoutes.resultSummaryPath,
      builder: (context, state) => FitnessPlanScreen(
        onStartJourney: () => context.go(AppRoutes.dashboardPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.dashboardName,
      path: AppRoutes.dashboardPath,
      builder: (context, state) => DashboardScreen(
        onViewWorkoutPlan: () => context.go(AppRoutes.workoutPlanPath),
        onWorkoutTap: () => context.go(AppRoutes.workoutPath),
        onViewNutrition: () => context.go(AppRoutes.nutritionSummaryPath),
        onNutritionTap: () => context.go(AppRoutes.foodPath),
        onViewActivity: () => context.go(AppRoutes.activityOverviewPath),
        onNotifications: () => context.go(AppRoutes.notificationsPath),
        onFavourites: () => context.go(AppRoutes.favouritesPath),
        onProfile: () => context.go(AppRoutes.profilePath),
        onSettings: () => context.go(AppRoutes.settingsPath),
        onProgressTap: () => context.go(AppRoutes.progressPath),
        onLogTap: () => context.go(AppRoutes.logPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.notificationsName,
      path: AppRoutes.notificationsPath,
      builder: (context, state) =>
          NotificationScreen(onBack: () => context.go(AppRoutes.dashboardPath)),
    ),
    GoRoute(
      name: AppRoutes.favouritesName,
      path: AppRoutes.favouritesPath,
      builder: (context, state) =>
          FavouritesScreen(onBack: () => context.go(AppRoutes.dashboardPath)),
    ),
    GoRoute(
      name: AppRoutes.profileName,
      path: AppRoutes.profilePath,
      builder: (context, state) =>
          ProfileScreen(onBack: () => context.go(AppRoutes.dashboardPath)),
    ),
    GoRoute(
      name: AppRoutes.settingsName,
      path: AppRoutes.settingsPath,
      builder: (context, state) =>
          SettingsScreen(onBack: () => context.go(AppRoutes.dashboardPath)),
    ),
    GoRoute(
      name: AppRoutes.logName,
      path: AppRoutes.logPath,
      builder: (context, state) => LogScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHome: () => context.go(AppRoutes.dashboardPath),
        onWorkout: () => context.go(AppRoutes.workoutPath),
        onNutrition: () => context.go(AppRoutes.foodPath),
        onProgress: () => context.go(AppRoutes.progressPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.workoutName,
      path: AppRoutes.workoutPath,
      builder: (context, state) => WorkoutDatabaseScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHome: () => context.go(AppRoutes.dashboardPath),
        onNutrition: () => context.go(AppRoutes.foodPath),
        onProgress: () => context.go(AppRoutes.progressPath),
        onLog: () => context.go(AppRoutes.logPath),
        onExerciseTap: (exercise) =>
            context.go(AppRoutes.workoutDetailPath, extra: exercise),
      ),
    ),
    GoRoute(
      name: AppRoutes.progressName,
      path: AppRoutes.progressPath,
      builder: (context, state) => OverallProgressScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHome: () => context.go(AppRoutes.dashboardPath),
        onWorkout: () => context.go(AppRoutes.workoutPath),
        onNutrition: () => context.go(AppRoutes.foodPath),
        onLog: () => context.go(AppRoutes.logPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.activityOverviewName,
      path: AppRoutes.activityOverviewPath,
      builder: (context, state) => ActivityOverviewScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHome: () => context.go(AppRoutes.dashboardPath),
        onWorkout: () => context.go(AppRoutes.workoutPath),
        onNutrition: () => context.go(AppRoutes.foodPath),
        onProgress: () => context.go(AppRoutes.progressPath),
        onLog: () => context.go(AppRoutes.logPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.nutritionSummaryName,
      path: AppRoutes.nutritionSummaryPath,
      builder: (context, state) => NutritionSummaryScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHome: () => context.go(AppRoutes.dashboardPath),
        onWorkout: () => context.go(AppRoutes.workoutPath),
        onNutrition: () => context.go(AppRoutes.foodPath),
        onProgress: () => context.go(AppRoutes.progressPath),
        onLog: () => context.go(AppRoutes.logPath),
      ),
    ),
    GoRoute(
      name: AppRoutes.foodName,
      path: AppRoutes.foodPath,
      builder: (context, state) => FoodDatabaseScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHome: () => context.go(AppRoutes.dashboardPath),
        onWorkout: () => context.go(AppRoutes.workoutPath),
        onProgress: () => context.go(AppRoutes.progressPath),
        onLog: () => context.go(AppRoutes.logPath),
        onFoodTap: (food) => context.go(AppRoutes.foodDetailPath, extra: food),
      ),
    ),
    GoRoute(
      name: AppRoutes.foodDetailName,
      path: AppRoutes.foodDetailPath,
      builder: (context, state) {
        final food = state.extra is FoodItem
            ? state.extra! as FoodItem
            : const FoodItem(
                emoji: '🍚',
                name: 'Idli',
                serving: '2 pieces (100 g)',
                calories: '78',
                protein: '4.4 g',
                carbs: '16.8 g',
                fat: '0.6 g',
              );
        return FoodDetailScreen(
          food: food,
          onBack: () => context.go(AppRoutes.foodPath),
          onHome: () => context.go(AppRoutes.dashboardPath),
          onWorkout: () => context.go(AppRoutes.workoutPath),
          onProgress: () => context.go(AppRoutes.progressPath),
          onLog: () => context.go(AppRoutes.logPath),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.workoutDetailName,
      path: AppRoutes.workoutDetailPath,
      builder: (context, state) {
        final exercise = state.extra is WorkoutExercise
            ? state.extra! as WorkoutExercise
            : const WorkoutExercise(
                name: 'Dumbbell Press',
                details: '3 sets  x 15 reps',
                imageIndex: 1,
              );
        return WorkoutDetailScreen(
          exercise: exercise,
          onBack: () => context.go(AppRoutes.workoutPath),
          onStartWorkout: () =>
              context.go(AppRoutes.currentWorkoutPath, extra: exercise),
          onHome: () => context.go(AppRoutes.dashboardPath),
          onWorkout: () => context.go(AppRoutes.workoutPath),
          onNutrition: () => context.go(AppRoutes.foodPath),
          onProgress: () => context.go(AppRoutes.progressPath),
          onLog: () => context.go(AppRoutes.logPath),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.workoutPlanName,
      path: AppRoutes.workoutPlanPath,
      builder: (context, state) => WorkoutPlanScreen(
        onBack: () => context.go(AppRoutes.dashboardPath),
        onHomeTap: () => context.go(AppRoutes.dashboardPath),
        onWorkoutTap: () => context.go(AppRoutes.workoutPath),
        onNutritionTap: () => context.go(AppRoutes.foodPath),
        onProgressTap: () => context.go(AppRoutes.progressPath),
        onLogTap: () => context.go(AppRoutes.logPath),
        onExerciseTap: (exercise) =>
            context.go(AppRoutes.currentWorkoutPath, extra: exercise),
      ),
    ),
    GoRoute(
      name: AppRoutes.currentWorkoutName,
      path: AppRoutes.currentWorkoutPath,
      builder: (context, state) {
        final exercise = state.extra is WorkoutExercise
            ? state.extra! as WorkoutExercise
            : const WorkoutExercise(
                name: 'Push Ups',
                details: '3 sets  x 15 reps',
                imageIndex: 0,
              );
        return CurrentWorkoutScreen(
          exercise: exercise,
          onBack: () => context.go(AppRoutes.workoutPlanPath),
          onRest: () => context.go(AppRoutes.workoutTimerPath, extra: exercise),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.workoutTimerName,
      path: AppRoutes.workoutTimerPath,
      builder: (context, state) {
        final exercise = state.extra is WorkoutExercise
            ? state.extra! as WorkoutExercise
            : const WorkoutExercise(
                name: 'Push Ups',
                details: '3 sets  x 15 reps',
                imageIndex: 0,
              );
        return WorkoutTimerScreen(
          exercise: exercise,
          onBack: () =>
              context.go(AppRoutes.currentWorkoutPath, extra: exercise),
          onHome: () => context.go(AppRoutes.dashboardPath),
          onWorkout: () => context.go(AppRoutes.workoutPath),
          onNutrition: () => context.go(AppRoutes.foodPath),
          onProgress: () => context.go(AppRoutes.progressPath),
          onLog: () => context.go(AppRoutes.logPath),
        );
      },
    ),
  ],
  errorBuilder: (context, state) => const _RouteErrorScreen(),
);

class _RouteErrorScreen extends StatelessWidget {
  const _RouteErrorScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Page not found')));
  }
}
