import 'package:flutter/material.dart';
import 'package:meals_project/data/dummy_data.dart';
import 'package:meals_project/model/meal.dart';
import 'package:meals_project/model/settings.dart';
import 'package:meals_project/screens/categories_meals_screen.dart';
import 'package:meals_project/screens/meal_detail_screen.dart';
import 'package:meals_project/screens/settings_screen.dart';
import 'package:meals_project/screens/tabs_screen.dart';
import 'package:meals_project/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _availableMeals = dummyMeals.where((meal) {
        return [
          !settings.isGlutenFree || meal.isGlutenFree,
          !settings.isLactoseFree || meal.isLactoseFree,
          !settings.isVegan || meal.isVegan,
          !settings.isVegetarian || meal.isVegetarian,
        ].every((condition) => condition);
      }).toList();
    });
  }

  void _toggleFavoriteMeal(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas de comida',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 69, 20, 126),
          brightness: Brightness.light,
        ),
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 69, 20, 126),
          ).primary,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 69, 20, 126),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      // home: CategoriesScreen(),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) =>
            MealDetail(_toggleFavoriteMeal, isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(settings, _filterMeals),
      },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       return CategoriesMealsScreen();
      //     },
      //   );
      // },
    );
  }
}
