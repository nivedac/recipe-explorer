
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/favorite_provider.dart';
import 'providers/meal_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final favoriteProvider = FavoriteProvider();
  await favoriteProvider.loadFavorites();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MealProvider(),
        ),

        ChangeNotifierProvider.value(
          value: favoriteProvider,
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Recipe Explorer',

          theme: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: Colors.orange,
            useMaterial3: true,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.orange,
            useMaterial3: true,
          ),

          themeMode:
              themeProvider.themeMode,

          home: const SplashScreen(),
        );
      },
    );
  }
}