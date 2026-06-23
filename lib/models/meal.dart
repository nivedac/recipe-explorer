// class Meal {
//   final String id;
//   final String name;
//   final String thumbnail;

//   final String? category;
//   final String? area;
//   final String? instructions;
//   final String? image;

//   Meal({
//     required this.id,
//     required this.name,
//     required this.thumbnail,
//     this.category,
//     this.area,
//     this.instructions,
//     this.image,
//   });

//   factory Meal.fromJson(
//       Map<String, dynamic> json) {
//     return Meal(
//       id: json['idMeal'] ?? '',
//       name: json['strMeal'] ?? '',
//       thumbnail:
//           json['strMealThumb'] ?? '',
//       category: json['strCategory'],
//       area: json['strArea'],
//       instructions:
//           json['strInstructions'],
//       image: json['strMealThumb'],
//     );
//   }
// }
class Meal {
  final String id;
  final String name;
  final String thumbnail;

  final String? category;
  final String? area;
  final String? instructions;
  final String? image;
  final String? youtube;

  final List<Map<String, String>> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category,
    this.area,
    this.instructions,
    this.image,
    this.youtube,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty) {
        ingredients.add({
          'ingredient': ingredient.toString(),
          'measure': measure?.toString() ?? '',
        });
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      image: json['strMealThumb'],
      youtube: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}