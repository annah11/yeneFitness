import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CircleAvatar(radius: 48, child: const Icon(Icons.person, size: 48)),
            const SizedBox(height: 12),
            const Text('Hana',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Height'), Text('170 cm')]),
                  const SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Weight'), Text('62 kg')]),
                  const SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Goals'), Text('Lose weight')]),
                ]),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Theme'),
              trailing: Switch(
                  value: state.isDarkMode,
                  onChanged: (_) => state.toggleTheme()),
            )
          ],
        ),
      ),
    );
  }
}
