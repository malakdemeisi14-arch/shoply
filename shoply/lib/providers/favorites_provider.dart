import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _ids = {};

  Set<String> get ids => Set.unmodifiable(_ids);
  bool isFav(String id) => _ids.contains(id);

  void toggle(String id) {
    if (!_ids.remove(id)) _ids.add(id);
    notifyListeners();
  }

  void clear() {
    _ids.clear();
    notifyListeners();
  }
}
