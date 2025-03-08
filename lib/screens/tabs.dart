import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/favourites_provider.dart';
import 'package:meal_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
 

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      //final result = await Navigator.of(context).push<Map<Filter, bool>>(
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (BuildContext ctx) {
            return FiltersScreen(
                //    currentFilters: _selectedFilters,
                );
          },
        ),
      );
    
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final availableMeals = ref.watch(filteredMealsProvider);
   
    Widget activePage = CategoriesScreen(
      availabelMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealScreen(
        //meals:_favouriteMeals,
        meals: favouriteMeals,
      );
      activePageTitle = ' My Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favourites")
          ]),
    );
  }
}
