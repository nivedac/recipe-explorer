class Meal {
  final String id;
  final String name;
  final String thumbnail;

  final String? category;
  final String? area;
  final String? instructions;
  final String? image;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category,
    this.area,
    this.instructions,
    this.image,
  });

  factory Meal.fromJson(
      Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail:
          json['strMealThumb'] ?? '',
      category: json['strCategory'],
      area: json['strArea'],
      instructions:
          json['strInstructions'],
      image: json['strMealThumb'],
    );
  }
}