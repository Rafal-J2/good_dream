import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/theme_mode/theme_mode_cubit.dart';
import 'package:mocktail/mocktail.dart';


class MockGetStorage extends Mock implements GetStorage {
  @override
  Future<void> write(String key, dynamic value) async {
    return Future.value();
  }
}

void main() {
  group('ThemeModeCubit Tests', () {
    late MockGetStorage mockGetStorage;
    late ThemeModeCubit themeModeCubit;

    setUp(() {
      mockGetStorage = MockGetStorage();
      themeModeCubit = ThemeModeCubit(mockGetStorage);
    });

    tearDown(() {
      themeModeCubit.close();
    });

    test('should initialize with system theme mode', () {
      expect(themeModeCubit.state, ThemeMode.system);
    });

    blocTest<ThemeModeCubit, ThemeMode>(
      'should emit ThemeMode.light when changeThemeMode(ThemeMode.light) is called',
      build: () => themeModeCubit,
      act: (cubit) => cubit.changeThemeMode(ThemeMode.light),
      expect: () => [ThemeMode.light],
    );
  });
}

