import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                meal.thumbnail,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(8),
              child: Text(
                meal.name,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}