import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _pages = const [
    HomeContent(),
    // placeholders for other tabs handled via navigation bar
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  void _onNavTap(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
    switch (idx) {
      case 1:
        Navigator.pushNamed(context, '/workouts');
        break;
      case 2:
        Navigator.pushNamed(context, '/nutrition');
        break;
      case 3:
        Navigator.pushNamed(context, '/community');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'Nutrition'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final double progress =
        ((state.caloriesBurnedToday / state.dailyActivityGoal).clamp(0, 1))
            .toDouble();

    // Gallery assets (images and videos). Add new filenames to assets/images and assets/videos as needed.
    final gallery = [
      'assets/images/hero.png',
      'assets/images/cardio.png',
      'assets/videos/intro.mp4',
      'assets/images/strength.png',
      'assets/images/yoga.png',
      'assets/images/stretching.png',
      'assets/images/meal.png',
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Welcome back', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 6),
                    Text('Hana',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ],
                ),
                CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blueAccent,
                    child: const Icon(Icons.person, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 10,
                            color: Colors.white70),
                        Center(
                            child: Text('${(progress * 100).toInt()}%',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Daily Activity',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text('${state.caloriesBurnedToday} cal burned',
                            style: const TextStyle(color: Colors.white)),
                        Text('${state.workoutsCompletedToday} workouts',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Motivation',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                        '"The only bad workout is the one that didn\'t happen."'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today\'s Meals',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...state.meals.map((m) => ListTile(
                          leading: Icon(Icons.restaurant),
                          title: Text(m.name),
                          subtitle: Text(
                              '${m.calories} cal — ${m.protein}P ${m.carbs}C ${m.fat}F'),
                          trailing: Checkbox(
                              value: m.eaten,
                              onChanged: (_) => state.eatMeal(m.id)),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Gallery section: large grid tiles, responsive
            Text('Gallery', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: LayoutBuilder(builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 480 ? 2 : 1);
                  return GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 16 / 10,
                    children: gallery.map((path) {
                      final isVideo = path.toLowerCase().endsWith('.mp4') || path.toLowerCase().endsWith('.mov');
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ImageViewerScreen(path: path, isVideo: isVideo)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (isVideo)
                                // video thumbnail placeholder
                                Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.videocam, size: 48)))
                              else
                                Image.asset(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.broken_image)))),
                              if (isVideo)
                                Container(
                                  color: Colors.black26,
                                  child: const Center(child: Icon(Icons.play_circle_fill, size: 56, color: Colors.white)),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class ImageViewerScreen extends StatefulWidget {
  final String path;
  final bool isVideo;
  const ImageViewerScreen({Key? key, required this.path, this.isVideo = false}) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  VideoPlayerController? _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      if (widget.path.startsWith('assets/')) {
        _controller = VideoPlayerController.asset(widget.path)
          ..initialize().then((_) {
            setState(() {
              _initialized = true;
            });
            _controller?.play();
          });
      } else if (widget.path.startsWith('http')) {
        _controller = VideoPlayerController.network(widget.path)
          ..initialize().then((_) {
            setState(() {
              _initialized = true;
            });
            _controller?.play();
          });
      } else {
        _controller = VideoPlayerController.file(File(widget.path))
          ..initialize().then((_) {
            setState(() {
              _initialized = true;
            });
            _controller?.play();
          });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, elevation: 0),
      backgroundColor: Colors.black,
      body: Center(
        child: widget.isVideo
            ? _initialized && _controller != null
                ? AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!))
                : const CircularProgressIndicator()
            : InteractiveViewer(
                child: Image.asset(widget.path, fit: BoxFit.contain, errorBuilder: (c, e, s) => Container(color: Colors.grey[900], child: const Center(child: Icon(Icons.broken_image, color: Colors.white)))),
              ),
      ),
      floatingActionButton: widget.isVideo && _controller != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    _controller!.play();
                  }
                });
              },
              child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
            )
          : null,
    );
  }
}
