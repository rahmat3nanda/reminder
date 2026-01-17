part of '../navigate.dart';

class CupertinoNoSwipePageRoute<T> extends CupertinoPageRoute<T> {
  CupertinoNoSwipePageRoute({required super.builder});

  @override
  bool get popGestureEnabled => false;
}
