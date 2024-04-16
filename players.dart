import 'chests.dart';
import 'crafting.dart';
import 'items.dart';
import 'trees.dart';

class Player {
  Map<Item, int> _inv = {};
  Map<Item, int> get inv => Map.fromEntries(_inv.entries);

  void retrieveFromChest(
    Chest source,
    int number,
    Item item,
  ) {
    if ((source.inv[item] ?? 0) < number) {
      throw StateError(
          "You cannot retrieve $number ${item}s from a chest with not that many ${item}s!");
    }
    source.removeItem(item, number);
    _inv[item] = (_inv[item] ?? 0) + number;
  }

  void chop(Tree source) {
    _inv[Item.wood] = (_inv[Item.wood] ?? 0) + source.woodItems;
    _inv[Item.sapling] =
        (_inv[Item.sapling] ?? 0) + (source.leafItems / 20).floor();
    source.chop();
  }

  void craft(Item item) {
    Map<Item, int>? recipe = recipes[item];
    if (recipe == null) {
      throw StateError("Cannot craft something that has no recipe!");
    }
    for (MapEntry<Item, int> entry in recipe.entries) {
      if ((_inv[entry.key] ?? 0) < entry.value) {
        throw StateError(
            "Cannot craft $item; it needs ${entry.value} ${entry.key}s but you only have ${_inv[entry.key] ?? 0}!");
      }
      _inv[entry.key] = _inv[entry.key]! - entry.value;
    }
    _inv[item] = (_inv[item] ?? 0) + 1;
  }

  void putInChest(
    Chest source,
    int number,
    Item item,
  ) {
    source.retrieveFromPlayer(this, number, item);
  }

  void removeItem(Item item, int number) {
    if (number > (_inv[item] ?? 0)) {
      throw StateError(
          "Cannot take away $number ${item}s from a player when they have ${_inv[item] ?? 0}!");
    }
    _inv[item] = (_inv[item]!) - number;
  }
}
