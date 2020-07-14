// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeStore on _ThemeStore, Store {
  Computed<ThemeData> _$currentThemeDataComputed;

  @override
  ThemeData get currentThemeData => (_$currentThemeDataComputed ??=
          Computed<ThemeData>(() => super.currentThemeData,
              name: '_ThemeStore.currentThemeData'))
      .value;
  Computed<String> _$themeStringComputed;

  @override
  String get themeString =>
      (_$themeStringComputed ??= Computed<String>(() => super.themeString,
              name: '_ThemeStore.themeString'))
          .value;

  final _$currentThemeTypeAtom = Atom(name: '_ThemeStore.currentThemeType');

  @override
  ThemeType get currentThemeType {
    _$currentThemeTypeAtom.reportRead();
    return super.currentThemeType;
  }

  @override
  set currentThemeType(ThemeType value) {
    _$currentThemeTypeAtom.reportWrite(value, super.currentThemeType, () {
      super.currentThemeType = value;
    });
  }

  final _$_ThemeStoreActionController = ActionController(name: '_ThemeStore');

  @override
  void toggleCurrentTheme() {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.toggleCurrentTheme');
    try {
      return super.toggleCurrentTheme();
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentThemeType: ${currentThemeType},
currentThemeData: ${currentThemeData},
themeString: ${themeString}
    ''';
  }
}
