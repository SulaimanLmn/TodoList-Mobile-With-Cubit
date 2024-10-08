import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/bloc/nav_bloc.dart';

import 'package:flutter_bloc_test/cubit/nav_cubit.dart';
import 'package:flutter_bloc_test/bloc/todo_bloc.dart';
import 'package:flutter_bloc_test/cubit/todo_cubit.dart';
import 'package:flutter_bloc_test/pages/nav_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavCubit(),
        ),
        BlocProvider(
          create: (_) => TodoCubit(),
        ),
        BlocProvider(
          create: (_) => TodoBloc(),
        ),
        BlocProvider(
          create: (_) => NavBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NavPage(),
      ),
    );
  }
}
