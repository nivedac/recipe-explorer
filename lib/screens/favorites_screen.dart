

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/favorite_provider.dart';
import '../providers/meal_provider.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {

  List<Meal> favoriteMeals = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    final mealProvider =
        Provider.of<MealProvider>(
      context,
      listen: false,
    );

    favoriteMeals.clear();

    for (String id
        in favoriteProvider.favorites) {

      final meal =
          await mealProvider.getMealDetails(
        id,
      );

      if (meal != null) {
        favoriteMeals.add(meal);
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final favoriteProvider =
        Provider.of<FavoriteProvider>(
      context,
    );

    return Scaffold(
      // appBar: AppBar(
      //   title:
      //       const Text("Favorites"),
      // ),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : favoriteMeals.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 100,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Favorites Yet",
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: loadFavorites,
                  child: ListView.builder(
                    itemCount:
                        favoriteMeals.length,
                    itemBuilder:
                        (_, index) {

                      final meal =
                          favoriteMeals[
                              index];

                      return Dismissible(
                        key: Key(meal.id),

                        onDismissed:
                            (_) async {

                          await favoriteProvider
                              .toggleFavorite(
                            meal.id,
                          );

                          setState(() {
                            favoriteMeals
                                .removeAt(
                              index,
                            );
                          });
                        },

                        child: ListTile(
                          leading:
                              CircleAvatar(
                            backgroundImage:
                                NetworkImage(
                              meal.thumbnail,
                            ),
                          ),

                          title: Text(
                            meal.name,
                          ),

                          subtitle: Text(
                            meal.category ??
                                '',
                          ),

                          trailing:
                              const Icon(
                            Icons.favorite,
                            color:
                                Colors.red,
                          ),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MealDetailScreen(
                                  mealId:
                                      meal.id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}