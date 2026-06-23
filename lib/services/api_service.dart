import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> getCategories() async {
    return await dio.get('categories.php');
  }

  Future<Response> getMealsByCategory(String category) async {
    return await dio.get(
      'filter.php',
      queryParameters: {
        'c': category,
      },
    );
  }

  Future<Response> searchMeals(String query) async {
    return await dio.get(
      'search.php',
      queryParameters: {
        's': query,
      },
    );
  }

  Future<Response> getMealDetails(String id) async {
    return await dio.get(
      'lookup.php',
      queryParameters: {
        'i': id,
      },
    );
  }
}