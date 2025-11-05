import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/app_state.dart';
import 'src/screens/splash_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/workouts_screen.dart';
import 'src/screens/nutrition_screen.dart';
import 'src/screens/progress_screen.dart';
import 'src/screens/community_screen.dart';
import 'src/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FitLifeApp());
}

class FitLifeApp extends StatelessWidget {
  const FitLifeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..loadFromPrefs(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FitLife',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFFFB6F92)),
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFFFB6F92),
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFFB6F92),
                  brightness: Brightness.dark),
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            routes: {
              '/home': (_) => const HomeScreen(),
              '/workouts': (_) => const WorkoutsScreen(),
              '/nutrition': (_) => const NutritionScreen(),
              '/progress': (_) => const ProgressScreen(),
              '/community': (_) => const CommunityScreen(),
              '/profile': (_) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}
