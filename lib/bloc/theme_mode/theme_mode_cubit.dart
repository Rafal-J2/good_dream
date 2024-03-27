import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  final GetStorage dataStorage;

  ThemeModeCubit(this.dataStorage) : super(ThemeMode.system) {
    _init();
  }

  Future<void> _init() async {
    final modeIndex = await dataStorage.read('themeMode') ?? ThemeMode.system.index;
    final mode = ThemeMode.values[modeIndex];
    emit(mode);

  }

  void changeThemeMode(ThemeMode mode) {
    emit(mode);
    dataStorage.write('themeMode', mode.index);
}
}

