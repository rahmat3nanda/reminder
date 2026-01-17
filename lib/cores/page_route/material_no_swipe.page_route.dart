part of '../navigate.dart';

class MaterialNoSwipePageRoute<T> extends MaterialPageRoute<T> {
  MaterialNoSwipePageRoute({required super.builder});

  @override
  bool get hasScopedWillPopCallback => true;
}
