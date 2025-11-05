import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final cat in ['Cardio', 'Strength', 'Yoga', 'Stretching']) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(cat, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...state.workouts.where((w) => w.category == cat).map((w) => Card(
                  child: ListTile(
                    leading: SizedBox(width: 56, child: Image.asset(w.asset, fit: BoxFit.cover)),
                    title: Text(w.title),
                    subtitle: Text('${w.durationMinutes} min • ${w.difficulty}'),
                    trailing: w.completed
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : ElevatedButton(onPressed: () => state.completeWorkout(w.id, w.calories), child: const Text('Done')),
                  ),
                ))
          ]
        ],
      ),
    );
  }
}
