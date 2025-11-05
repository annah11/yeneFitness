import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final totalCalories = state.meals.fold<int>(0, (s, m) => s + m.calories);

    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text('Daily Goals', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Calories: $totalCalories / ${state.dailyCalorieGoal}'),
                        ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: state.meals.map((m) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.fastfood),
                        title: Text('${m.type}: ${m.name}'),
                        subtitle: Text('${m.calories} cal • ${m.protein}P ${m.carbs}C ${m.fat}F'),
                        trailing: Checkbox(value: m.eaten, onChanged: (_) => state.eatMeal(m.id)),
                      ),
                    )).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
