// import 'package:flutter/material.dart';

// import '../models/category.dart';
// import '../models/meal.dart';
// import '../services/api_service.dart';

// class MealProvider extends ChangeNotifier {
//   final ApiService api = ApiService();

//   bool isLoading = false;
//   String? error;

//   List<Category> categories = [];
//   List<Meal> meals = [];

//   // Load Categories
//   Future<void> loadCategories() async {
//     try {
//       isLoading = true;
//       error = null;
//       notifyListeners();

//       final response = await api.getCategories();

//       categories = (response.data['categories'] as List)
//           .map((e) => Category.fromJson(e))
//           .toList();
//     } catch (e) {
//       error = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Load Meals By Category
//   Future<void> loadMeals(String category) async {
//     try {
//       isLoading = true;
//       error = null;
//       notifyListeners();

//       final response =
//           await api.getMealsByCategory(category);

//       meals = (response.data['meals'] as List)
//           .map((e) => Meal.fromJson(e))
//           .toList();
//     } catch (e) {
//       error = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Search Meals
//   Future<List<Meal>> searchMeals(
//       String query) async {
//     try {
//       final response =
//           await api.searchMeals(query);

//       if (response.data['meals'] == null) {
//         return [];
//       }

//       return (response.data['meals'] as List)
//           .map((e) => Meal.fromJson(e))
//           .toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   // Get Meal Details
//   Future<Meal?> getMealDetails(
//       String id) async {
//     try {
//       final response =
//           await api.getMealDetails(id);

//       if (response.data['meals'] == null) {
//         return null;
//       }

//       return Meal.fromJson(
//         response.data['meals'][0],
//       );
//     } catch (e) {
//       return null;
//     }
//   }

//   // Refresh Current Category
//   Future<void> refreshMeals(
//       String category) async {
//     await loadMeals(category);
//   }
// }

import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../services/api_service.dart';

class MealProvider extends ChangeNotifier {
  final ApiService api = ApiService();

  bool isLoading = false;
  String? error;

  List<Category> categories = [];
  List<Meal> meals = [];

  Future<void> loadCategories() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await api.getCategories();

      categories =
          (response.data['categories'] as List)
              .map(
                (e) =>
                    Category.fromJson(e),
              )
              .toList();
    } catch (e) {
      error =
          "Unable to load categories.\nCheck your internet connection.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMeals(
      String category) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response =
          await api.getMealsByCategory(
        category,
      );

      meals =
          (response.data['meals'] as List)
              .map(
                (e) =>
                    Meal.fromJson(e),
              )
              .toList();
    } catch (e) {
      error =
          "Unable to load meals.\nCheck your internet connection.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Meal>> searchMeals(
      String query) async {
    try {
      final response =
          await api.searchMeals(query);

      if (response.data['meals'] ==
          null) {
        return [];
      }

      return (response.data['meals']
              as List)
          .map(
            (e) =>
                Meal.fromJson(e),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Meal?> getMealDetails(
      String id) async {
    try {
      final response =
          await api.getMealDetails(id);

      if (response.data['meals'] ==
          null) {
        return null;
      }

      return Meal.fromJson(
        response.data['meals'][0],
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> refreshMeals(
      String category) async {
    await loadMeals(category);
  }
}