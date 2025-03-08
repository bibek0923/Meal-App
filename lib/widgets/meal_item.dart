import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final void Function(  Meal meal) onSelectMeal;
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          onSelectMeal( meal);
        },
        child: Stack(
          clipBehavior:
              Clip.hardEdge, //clip off the content going outside of parent

          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fadeInDuration: Duration(milliseconds: 10 ),
                fadeInCurve: Curves.easeInCirc,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ), //very long text lai cut off into 3 dots by Textoverflow.ellepsis
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: /* meal.duration.toString() */
                                  "${meal.duration} min"),
                          SizedBox(width: 12),
                          MealItemTrait(
                            icon: Icons.work,
                            /* label: "${meal.complexity.name}") //accesing type of enum */
                            // label: meal.complexity.name ,
                            //  label: meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1),// we can use the getter instead to keep the code clean
                            label: complexityText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: meal.affordability.name[0].toUpperCase() +
                                  meal.affordability.name.substring(1))
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
