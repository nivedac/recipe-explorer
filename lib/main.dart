import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/meal_provider.dart';
import 'providers/favorite_provider.dart';
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Explorer',
      home: const SplashScreen(),
    );
  }
}