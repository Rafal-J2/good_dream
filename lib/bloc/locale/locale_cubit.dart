import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocaleCubit extends Cubit<Locale> {
  final GetStorage dataStorage;

  LocaleCubit(this.dataStorage) : super(const Locale('pl')) {
    _init();
  }

  Future<void> _init() async {
    final langCode = dataStorage.read('languageCode') ?? 'pl';
    emit(Locale(langCode));
  }

  void changeLocale(String langCode) {
    emit(Locale(langCode));
    dataStorage.write('languageCode', langCode);
  }
}
