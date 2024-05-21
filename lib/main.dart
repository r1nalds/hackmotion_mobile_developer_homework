import 'package:flutter/material.dart';
import 'package:hackmotion_mobile_developer_homework/app.dart';
import 'package:bloc/bloc.dart';
import 'package:hackmotion_mobile_developer_homework/swing_observer.dart';

void main() {
  Bloc.observer = const SwingObserver();
  runApp(const SwingApp());
}