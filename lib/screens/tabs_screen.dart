import 'package:flutter/material.dart';
import 'package:meals_project/components/main_drawer.dart';
import 'package:meals_project/screens/categories_screen.dart';
import 'package:meals_project/screens/favorites_food.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  final List<Map<String, Object>> _screens = [
    {'title': 'Lista de categorias', 'screen': CategoriesScreen()},
    {'title': 'Meus favoritos', 'screen': FavoritesFoodScreen()},
  ];

  void _selectScren(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_screens[_selectedScreenIndex]['title'] as String),
          // bottom: TabBar(
          //   labelColor: Colors.white60,
          //   unselectedLabelColor: Colors.white,
          //   tabs: [
          //     Tab(icon: Icon(Icons.category), text: 'Categorias'),
          //     Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
          //   ],
          // ),
        ),
        // body: TabBarView(children: [CategoriesScreen(), FavoritesFoodScreen()]),
        drawer: MainDrawer(),
        body: _screens[_selectedScreenIndex]['screen'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white60,
          selectedItemColor: Colors.white,
          currentIndex: _selectedScreenIndex,
          type: BottomNavigationBarType.shifting,
          onTap: _selectScren,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Categorias',
              icon: Icon(Icons.category, semanticLabel: 'Categorias'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Favoritos',
              icon: Icon(Icons.favorite, semanticLabel: 'Favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}
