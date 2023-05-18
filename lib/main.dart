import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/App/my_app.dart';
import 'package:todo/counter_screen/cubit/shard%20_blok_opservers.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
