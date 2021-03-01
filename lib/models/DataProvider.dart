import 'package:flutter/cupertino.dart';
import 'package:good_dream/models/ViewModels.dart';


class DataProvider extends ChangeNotifier {

  List<ViewModels> _items = [];

  void add(ViewModels item) {
    _items.add(item);
    print(_items);
    notifyListeners();
  }


  void remove(ViewModels item) {
    _items.remove(item);
    notifyListeners();
  }


  int get count {
    return _items.length;
  }

  List<ViewModels> get basketItems {
    return _items;
  }


  // counter to piano

  List<ViewModels> _items2 = [];

  void add2(ViewModels item) {
    _items2.add(item);
    notifyListeners();
  }


  void remove2(ViewModels item) {
    _items2.remove(item);
    notifyListeners();
  }


  int get count2 {
    return _items2.length;
  }

  List<ViewModels> get basketItems2 {
    return _items2;
  }

}
