class Meal {
  final String id;
  final String name;
  final String type; // breakfast, lunch, dinner
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final bool eaten;

  Meal({
    required this.id,
    required this.name,
    required this.type,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.eaten = false,
  });

  Meal copyWith({
    String? id,
    String? name,
    String? type,
    int? calories,
    int? protein,
    int? carbs,
    int? fat,
    bool? eaten,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      eaten: eaten ?? this.eaten,
    );
  }

  static List<Meal> sampleData() {
    return [
      Meal(
        id: 'm1',
        name: 'Oatmeal with Fruits',
        type: 'Breakfast',
        calories: 350,
        protein: 12,
        carbs: 60,
        fat: 6,
      ),
      Meal(
        id: 'm2',
        name: 'Grilled Chicken Salad',
        type: 'Lunch',
        calories: 450,
        protein: 35,
        carbs: 30,
        fat: 15,
      ),
      Meal(
        id: 'm3',
        name: 'Salmon and Veggies',
        type: 'Dinner',
        calories: 600,
        protein: 40,
        carbs: 40,
        fat: 20,
      ),
    ];
  }
}
