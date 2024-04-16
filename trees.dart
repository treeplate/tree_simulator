import 'items.dart';
import 'players.dart';

Tree plantSapling(Player source) {
  if (source.inv[Item.sapling] == null || source.inv[Item.sapling]! < 1) {
    throw StateError("Cannot plant tree without a sapling!");
  }
  Tree tree = Tree._(0, 0);
  _trees.add(tree);
  source.removeItem(Item.sapling, 1);
  return tree;
}

List<Tree> _trees = [];

/// [print]s its argument
void log(String str) {
  print(str);
}

int _treeTicks = 0;
int get treeTicks => _treeTicks;

void growTrees() {
  for (Tree tree in _trees) {
    tree._grow();
  }
  _treeTicks++;
}

/// A source of [Wood].
class Tree {
  int _woodItems;
  int _leafItems;
  Tree._(this._woodItems, this._leafItems);
  int get woodItems => _woodItems;
  int get leafItems => _leafItems;
  bool _choppedDown = false;
  bool get choppedDown => _choppedDown;
  void _grow() {
    if (choppedDown) return;
    _woodItems = 5;
    _leafItems = 56;
  }

  void chop() {
    _woodItems = 0;
    _leafItems = 0;
    _choppedDown = true;
  }

  String toString() => "Tree (wood $woodItems, leaves $leafItems)";
}
