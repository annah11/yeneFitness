import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> posts = [
    {'user': 'Alex', 'text': 'Completed a 5k run today!', 'likes': 12},
    {'user': 'Maya', 'text': 'Healthy salmon recipe coming up.', 'likes': 8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: posts.length,
        itemBuilder: (ctx, i) {
          final p = posts[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(p['user'][0])),
              title: Text(p['user']),
              subtitle: Text(p['text']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${p['likes']}'),
                  const SizedBox(width: 8),
                  IconButton(
                      onPressed: () => setState(() => p['likes']++),
                      icon: const Icon(Icons.thumb_up)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('New Post'),
              content: const TextField(
                  decoration: InputDecoration(hintText: 'Share something...')),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'))
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
