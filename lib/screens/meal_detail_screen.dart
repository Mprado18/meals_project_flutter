import 'package:flutter/material.dart';
import 'package:meals_project/model/meal.dart';

class MealDetail extends StatelessWidget {
  const MealDetail({super.key});

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 316,
      height: 264,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 231, 229, 97),
        border: Border.all(color: Color.fromARGB(255, 184, 182, 66)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(meal.imageUrl, fit: BoxFit.cover),
              ),
              _createSectionTitle(context, 'Ingredientes'),
              _createSectionContainer(
                ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Card(
                        color: const Color.fromARGB(255, 119, 65, 180),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            meal.ingredients[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _createSectionTitle(context, 'Passos'),
              _createSectionContainer(
                ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(meal.steps[index]),
                        ),
                        if (meal.steps[index] != meal.steps.last) Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(meal.title);
        },
        child: Icon(Icons.star),
      ),
    );
  }
}
