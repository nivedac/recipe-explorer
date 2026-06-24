
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/theme_provider.dart';
// import '../providers/meal_provider.dart';
// import '../widgets/loading_indicator.dart';
// import '../widgets/meal_card.dart';
// import 'favorites_screen.dart';
// import 'meal_detail_screen.dart';
// import 'search_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String selectedCategory = "Beef";
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() async {
//       final provider = Provider.of<MealProvider>(context, listen: false);

//       await provider.loadCategories();
//       await provider.loadMeals("Beef");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Recipe Explorer"),
//         actions: currentIndex == 0
//             ? [
//                 IconButton(
//                   icon: const Icon(Icons.brightness_6),
//                   onPressed: () {
//                     Provider.of<ThemeProvider>(
//                       context,
//                       listen: false,
//                     ).toggleTheme();
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const SearchScreen()),
//                     );
//                   },
//                 ),
//               ]
//             : [],
//       ),

//       body: currentIndex == 0
//           ? Consumer<MealProvider>(
//               builder: (_, provider, __) {
//                 if (provider.isLoading) {
//                   return const LoadingIndicator();
//                 }

//                 if (provider.error != null) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.wifi_off, size: 80),

//                         const SizedBox(height: 16),

//                         Text(provider.error!, textAlign: TextAlign.center),

//                         const SizedBox(height: 16),

//                         ElevatedButton(
//                           onPressed: () async {
//                             await provider.loadCategories();

//                             await provider.loadMeals(selectedCategory);
//                           },
//                           child: const Text("Retry"),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return RefreshIndicator(
//                   onRefresh: () async {
//                     await provider.loadMeals(selectedCategory);
//                   },
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 100,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: provider.categories.length,
//                           itemBuilder: (_, index) {
//                             final category = provider.categories[index];

//                             return GestureDetector(
//                               onTap: () async {
//                                 setState(() {
//                                   selectedCategory = category.name;
//                                 });

//                                 await provider.loadMeals(category.name);
//                               },
//                               child: Container(
//                                 width: 90,
//                                 margin: const EdgeInsets.all(8),
//                                 child: Column(
//                                   children: [
//                                     CircleAvatar(
//                                       backgroundImage: NetworkImage(
//                                         category.image,
//                                       ),
//                                     ),

//                                     const SizedBox(height: 5),

//                                     Text(
//                                       category.name,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                       Expanded(
//                         child: GridView.builder(
//                           itemCount: provider.meals.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                               ),
//                           itemBuilder: (_, index) {
//                             final meal = provider.meals[index];

//                             return MealCard(
//                               meal: meal,
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) =>
//                                         MealDetailScreen(mealId: meal.id),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             )
//           : const FavoritesScreen(),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (value) {
//           setState(() {
//             currentIndex = value;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorites",
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/meal_card.dart';
import '../widgets/error_view.dart';
import 'favorites_screen.dart';
import 'meal_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  String selectedCategory = "Beef";
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final provider =
        Provider.of<MealProvider>(
      context,
      listen: false,
    );

    await provider.loadCategories();

    if (!mounted) return;

    await provider.loadMeals(
      "Beef",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          "Recipe Explorer",
        ),
        actions: currentIndex == 0
            ? [

                IconButton(
                  icon: const Icon(
                    Icons.brightness_6,
                  ),
                  onPressed: () {
                    Provider.of<
                        ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme();
                  },
                ),

                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SearchScreen(),
                      ),
                    );
                  },
                ),
              ]
            : [],
      ),

      body: currentIndex == 0
          ? Consumer<MealProvider>(
              builder:
                  (_, provider, __) {

                if (provider.isLoading) {
                  return const LoadingIndicator();
                }

                if (provider.error != null) {
                  return ErrorView(
                    message:
                        provider.error!,
                    onRetry:
                        () async {

                      await provider
                          .loadCategories();

                      await provider
                          .loadMeals(
                        selectedCategory,
                      );
                    },
                  );
                }

                return RefreshIndicator(
                  onRefresh:
                      () async {

                    await provider
                        .loadMeals(
                      selectedCategory,
                    );
                  },

                  child: Column(
                    children: [

                      SizedBox(
                        height: 110,
                        child:
                            ListView.builder(
                          scrollDirection:
                              Axis.horizontal,
                          itemCount:
                              provider
                                  .categories
                                  .length,
                          itemBuilder:
                              (_, index) {

                            final category =
                                provider.categories[
                                    index];

                            return GestureDetector(
                              onTap:
                                  () async {

                                setState(() {
                                  selectedCategory =
                                      category
                                          .name;
                                });

                                await provider
                                    .loadMeals(
                                  category.name,
                                );
                              },

                              child:
                                  Container(
                                width:
                                    100,
                                margin:
                                    const EdgeInsets.all(
                                  8,
                                ),

                                child:
                                    Column(
                                  children: [

                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(
                                        category
                                            .image,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          5,
                                    ),

                                    Text(
                                      category
                                          .name,
                                      textAlign:
                                          TextAlign
                                              .center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Expanded(
                        child:
                            GridView.builder(
                          itemCount:
                              provider
                                  .meals
                                  .length,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2,
                          ),

                          itemBuilder:
                              (_, index) {

                            final meal =
                                provider
                                    .meals[index];

                            return MealCard(
                              meal:
                                  meal,

                              onTap:
                                  () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            MealDetailScreen(
                                      mealId:
                                          meal.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const FavoritesScreen(),

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex:
            currentIndex,

        onTap: (value) {
          setState(() {
            currentIndex =
                value;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon:
                Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label:
                "Favorites",
          ),
        ],
      ),
    );
  }
}