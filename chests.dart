import 'items.dart';
import 'players.dart';

final Chest saplingChest = Chest._().._inv[Item.sapling] = 1;

class Chest {
  Map<Item, int> _inv = {};
  Map<Item, int> get inv => Map.fromEntries(_inv.entries);

  void removeItem(Item item, int number) {
    if (number > (_inv[item] ?? 0)) {
      throw StateError(
          "Cannot take away $number ${item}s from a chest when it has ${_inv[item] ?? 0}!");
    }
    _inv[item] = (_inv[item]!) - number;
  }

  void retrieveFromPlayer(
    Player source,
    int number,
    Item item,
  ) {
    if ((source.inv[item] ?? 0) < number) {
      throw StateError(
          "You cannot put $number ${item}s into a chest if you don't have that many ${item}s!");
    }
    source.removeItem(item, number);
    _inv[item] = (_inv[item] ?? 0) + number;
  }

  Chest(Player creator) {
    creator.removeItem(Item.chest, 1);
  }
  Chest._();
}
