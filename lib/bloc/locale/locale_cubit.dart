import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocaleCubit extends Cubit<Locale> {
  final GetStorage dataStorage;

  LocaleCubit(this.dataStorage) : super(const Locale('en')) {
    _init();
  }

  Future<void> _init() async {
    final savedLang = dataStorage.read('languageCode');
    if (savedLang != null) {
      emit(Locale(savedLang));
    } else {
      final deviceLang = PlatformDispatcher.instance.locale.languageCode;
      if (deviceLang == 'pl' || deviceLang == 'en' || deviceLang == 'hi') {
        emit(Locale(deviceLang));
      } else {
        emit(const Locale('en')); // domyślny język międzynarodowy
      }
    }
  }

  void changeLocale(String langCode) {
    emit(Locale(langCode));
    dataStorage.write('languageCode', langCode);
  }
}
