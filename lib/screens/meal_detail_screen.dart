// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/meal.dart';
// import '../providers/favorite_provider.dart';
// import '../providers/meal_provider.dart';

// class MealDetailScreen
//     extends StatefulWidget {

//   final String mealId;

//   const MealDetailScreen({
//     super.key,
//     required this.mealId,
//   });

//   @override
//   State<MealDetailScreen> createState() =>
//       _MealDetailScreenState();
// }

// class _MealDetailScreenState
//     extends State<MealDetailScreen> {

//   Meal? meal;

//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {

//     final provider =
//         Provider.of<MealProvider>(
//       context,
//       listen: false,
//     );

//     meal = await provider.getMealDetails(
//       widget.mealId,
//     );

//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     final favoriteProvider =
//         Provider.of<FavoriteProvider>(
//       context,
//     );

//     if (loading) {
//       return const Scaffold(
//         body: Center(
//           child:
//               CircularProgressIndicator(),
//         ),
//       );
//     }

//     if (meal == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text("Meal not found"),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(meal!.name),
//         actions: [
//           IconButton(
//             icon: Icon(
//               favoriteProvider.isFavorite(
//                 meal!.id,
//               )
//                   ? Icons.favorite
//                   : Icons.favorite_border,
//             ),
//             onPressed: () {
//               favoriteProvider
//                   .toggleFavorite(
//                 meal!.id,
//               );
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [

//             Image.network(
//               meal!.image ??
//                   meal!.thumbnail,
//             ),

//             Padding(
//               padding:
//                   const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [

//                   Text(
//                     meal!.name,
//                     style:
//                         const TextStyle(
//                       fontSize: 24,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   Text(
//                     "Category: ${meal!.category ?? ''}",
//                   ),

//                   Text(
//                     "Area: ${meal!.area ?? ''}",
//                   ),

//                   const SizedBox(
//                     height: 20,
//                   ),

//                   const Text(
//                     "Instructions",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   Text(
//                     meal!.instructions ??
//                         '',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/favorite_provider.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({
    super.key,
    required this.mealId,
  });

  @override
  State<MealDetailScreen> createState() =>
      _MealDetailScreenState();
}

class _MealDetailScreenState
    extends State<MealDetailScreen> {

  Meal? meal;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMeal();
  }

  Future<void> loadMeal() async {
    final provider =
        Provider.of<MealProvider>(
      context,
      listen: false,
    );

    meal = await provider.getMealDetails(
      widget.mealId,
    );

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

    if (loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (meal == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Meal not found",
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal!.name),
        actions: [
          IconButton(
            icon: Icon(
              favoriteProvider.isFavorite(
                meal!.id,
              )
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              favoriteProvider
                  .toggleFavorite(
                meal!.id,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Image.network(
              meal!.image ??
                  meal!.thumbnail,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    meal!.name,
                    style:
                        const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Category: ${meal!.category ?? ''}",
                  ),

                  Text(
                    "Area: ${meal!.area ?? ''}",
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount:
                        meal!.ingredients.length,
                    itemBuilder:
                        (_, index) {

                      final ingredient =
                          meal!.ingredients[
                              index];

                      return Card(
                        child: ListTile(
                          leading:
                              const Icon(
                            Icons.restaurant,
                          ),
                          title: Text(
                            ingredient[
                                    'ingredient'] ??
                                '',
                          ),
                          trailing: Text(
                            ingredient[
                                    'measure'] ??
                                '',
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Instructions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    meal!.instructions ??
                        '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}