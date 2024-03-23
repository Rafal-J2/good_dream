import 'package:flutter/material.dart';

class TabService {
  int _currentTabIndex = 0;
  final List<VoidCallback> _listeners = [];

  int get currentTabIndex => _currentTabIndex;

  void changeTab(int index) {
    _currentTabIndex = index;
    _notifyListeners();
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}

