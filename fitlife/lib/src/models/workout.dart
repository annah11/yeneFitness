class Workout {
  final String id;
  final String title;
  final int durationMinutes;
  final String difficulty;
  final String category;
  final String asset;
  final int calories;
  final bool completed;

  Workout({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.difficulty,
    required this.category,
    required this.asset,
    required this.calories,
    this.completed = false,
  });

  Workout copyWith({
    String? id,
    String? title,
    int? durationMinutes,
    String? difficulty,
    String? category,
    String? asset,
    int? calories,
    bool? completed,
  }) {
    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      asset: asset ?? this.asset,
      calories: calories ?? this.calories,
      completed: completed ?? this.completed,
    );
  }

  static List<Workout> sampleData() {
    return [
      Workout(
        id: 'w1',
        title: 'Morning Cardio Burn',
        durationMinutes: 20,
        difficulty: 'Medium',
        category: 'Cardio',
        asset: 'assets/images/cardio.png',
        calories: 150,
      ),
      Workout(
        id: 'w2',
        title: 'Full Body Strength',
        durationMinutes: 35,
        difficulty: 'Hard',
        category: 'Strength',
        asset: 'assets/images/strength.png',
        calories: 300,
      ),
      Workout(
        id: 'w3',
        title: 'Sunrise Yoga Flow',
        durationMinutes: 25,
        difficulty: 'Easy',
        category: 'Yoga',
        asset: 'assets/images/yoga.png',
        calories: 100,
      ),
    ];
  }
}
