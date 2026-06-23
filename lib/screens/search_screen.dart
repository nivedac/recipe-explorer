import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/meal_provider.dart';
import 'meal_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  Timer? _debounce;

  List<Meal> results = [];

  bool isLoading = false;

  void search(String value) {

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {

        if (value.isEmpty) {
          setState(() {
            results = [];
          });
          return;
        }

        setState(() {
          isLoading = true;
        });

        final provider =
            Provider.of<MealProvider>(
          context,
          listen: false,
        );

        results =
            await provider.searchMeals(value);

        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Recipes",
        ),
      ),
      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(12),
            child: TextField(
              decoration:
                  const InputDecoration(
                hintText:
                    "Search meal...",
                border:
                    OutlineInputBorder(),
              ),
              onChanged: search,
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )
                : results.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            results.length,
                        itemBuilder:
                            (_, index) {

                          final meal =
                              results[index];

                          return ListTile(
                            leading:
                                Image.network(
                              meal.thumbnail,
                              width: 60,
                            ),
                            title:
                                Text(meal.name),
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
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}