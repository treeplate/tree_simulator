import 'items.dart';

final Map<Item, Map<Item, int>> _recipes = {
  Item.chest: {Item.wood: 4}
};
Map<Item, Map<Item, int>> get recipes => _recipes.map((key, value) =>
    MapEntry(key, value.map((key, value) => MapEntry(key, value))));
