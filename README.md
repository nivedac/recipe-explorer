# Recipe Explorer

Recipe Explorer is a Flutter application that allows users to browse, search, view details, and save favorite recipes using TheMealDB API.

## Features

* Browse meals by category
* Search meals with 500ms debounce
* View detailed recipe information
* Ingredients with measurements
* Favorite/Unfavorite meals
* Persistent favorites using SharedPreferences
* Pull-to-refresh support
* Error handling with Retry button
* Dark Mode support
* Responsive UI

## State Management

Provider

## Why Provider?

Provider is lightweight, easy to learn, and suitable for medium-sized Flutter applications. It helps separate business logic from UI and keeps the application scalable and maintainable.

## API Used

TheMealDB API

https://www.themealdb.com/api/json/v1/1/

## Packages Used

* provider
* dio
* shared_preferences

## Project Structure

lib/

├── models/

│ ├── meal.dart

│ └── category.dart

├── services/

│ └── api_service.dart

├── providers/

│ ├── meal_provider.dart

│ ├── favorite_provider.dart

│ └── theme_provider.dart

├── screens/

│ ├── splash_screen.dart

│ ├── home_screen.dart

│ ├── search_screen.dart

│ ├── meal_detail_screen.dart

│ └── favorites_screen.dart

└── widgets/

├── meal_card.dart

├── loading_indicator.dart

└── error_view.dart

## Setup Instructions

```bash
flutter pub get
flutter run
```

## Build Release APK

```bash
flutter build apk --release
```

## Screenshots

### Home Screen

![Home Screen](screenshots/home.png)

### Meal Detail Screen

![Meal Detail Screen](screenshots/details.png)

### Favorites Screen

![Favorites Screen](screenshots/favorites.png)


### Search Screen

![Search Screen](screenshots/search.png)

### Dark/Light Mode

![Dark Mode](screenshots/light_mode.png)

## APK Download

https://drive.google.com/file/d/1TcoIKGY0qtZXvHzYOSimEQ5k0uOdJj3S/view?usp=sharing

## Known Limitations

* Internet connection is required to fetch meal data.
* Favorites store only meal IDs locally.
* Data availability depends on TheMealDB API.

## Flutter Analyze

Successfully passes:

```bash
flutter analyze
```

with zero issues.

## Author

Nived T
