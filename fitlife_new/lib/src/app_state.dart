import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/workout.dart';
import 'models/meal.dart';

class AppState extends ChangeNotifier {
  bool isDarkMode = false;
  int caloriesBurnedToday = 0;
  int workoutsCompletedToday = 0;
  int dailyCalorieGoal = 2000;
  int dailyActivityGoal = 500; // example active calories goal

  List<Workout> workouts = [];
  List<Meal> meals = [];

  int streak = 0;

  AppState() {
    _initDefaults();
  }

  void _initDefaults() {
    workouts = Workout.sampleData();
    meals = Meal.sampleData();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    dailyCalorieGoal = prefs.getInt('dailyCalorieGoal') ?? dailyCalorieGoal;
    streak = prefs.getInt('streak') ?? 0;
    notifyListeners();
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.setInt('dailyCalorieGoal', dailyCalorieGoal);
    await prefs.setInt('streak', streak);
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    saveToPrefs();
    notifyListeners();
  }

  void completeWorkout(String id, int calories) {
    workouts = workouts.map((w) {
      if (w.id == id) {
        w = w.copyWith(completed: true);
        caloriesBurnedToday += calories;
        workoutsCompletedToday += 1;
      }
      return w;
    }).toList();
    saveToPrefs();
    notifyListeners();
  }

  void eatMeal(String id) {
    meals = meals.map((m) {
      if (m.id == id) {
        m = m.copyWith(eaten: true);
      }
      return m;
    }).toList();
    saveToPrefs();
    notifyListeners();
  }

  void updateDailyGoals({int? calorieGoal, int? activityGoal}) {
    if (calorieGoal != null) dailyCalorieGoal = calorieGoal;
    if (activityGoal != null) dailyActivityGoal = activityGoal;
    saveToPrefs();
    notifyListeners();
  }
}
