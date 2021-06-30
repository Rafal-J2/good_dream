import 'package:flutter/cupertino.dart';
import 'package:good_dream/models/ViewModels.dart';

class DataProvider extends ChangeNotifier {

  List<ViewModels> _items = [];
  void add(ViewModels item) {
    _items.add(item);
   // print(_items);
    notifyListeners();
  }

  void remove(ViewModels item) {
    _items.remove(item);
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  // counter to piano
  int get count2 {
    return _items2.length;
  }

  List<ViewModels> _items2 = [];

  void add2(ViewModels item) {
    _items2.add(item);
    notifyListeners();
  }

  void remove2(ViewModels item) {
    _items2.remove(item);
    notifyListeners();
  }

  List<ViewModels> get basketItems2 {
    return _items2;
  }

  List<ViewModels> get basketItems {
    return _items;
  }

  List<ViewModels> _items3 = [];

   add3(ViewModels item) {
    _items3.add(item);
    notifyListeners();
  }

  List<ViewModels> get basketItems3 {
    return _items3;

  }
}
