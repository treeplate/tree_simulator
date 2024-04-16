import 'chests.dart';
import 'items.dart';
import 'players.dart';
import 'trees.dart';

// note: no 'implements' or 'extends' allowed in this file

void main() {
  Player player = Player();
  ResourceManager manager = ResourceManager(player);
  manager.collect(Item.chest, 1000);
  print(player.inv);
  print(treeTicks);
}

/// Collects resources.
/// Will take 1 sapling (if available) from [saplingChest], and then some from your inventory.
class ResourceManager {
  ResourceManager(this.player) {
    if ((saplingChest.inv[Item.sapling] ?? 0) >= 1) {
      player.retrieveFromChest(saplingChest, 1, Item.sapling);
    }
  }

  final Player player;
  List<Tree> trees = [];

  /// Called the first time you call [collect].
  void _plantTreeItems() {
    while ((player.inv[Item.sapling] ?? 0) >= 1) {
      trees.add(plantSapling(player));
    }
  }

  /// Assuming you start with no wood and 1 sapling in [saplingChest], and nothing
  /// in your inventory, you will get 2^n saplings and 5((2^n)-1) wood
  /// where n is the smallest possible integer that gives you enough of what you
  /// requested. It will take n treeticks.
  /// 
  /// If you requested chests, you will get [number] chests and the wood number minus [number] * 4
  void collect(Item item, int number) {
    if (item == Item.chest) {
      collect(Item.wood, number * 4);
      while ((player.inv[item] ?? 0) < number) {
        player.craft(Item.chest);
      }
    }
    while ((player.inv[item] ?? 0) < number) {
      //print("growing ${player.inv[Item.sapling]} saplings");
      _plantTreeItems();
      if (trees.length > 0) {
        growTrees();
      }
      //print("tick $treeTicks: chopping ${trees.length} trees");
      for (Tree tree in trees) {
        player.chop(tree);
      }
      trees = [];
    }
  }
}
