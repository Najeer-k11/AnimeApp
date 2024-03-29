import 'package:animecrunch/config/theme.dart';
import 'package:animecrunch/favourites/localProvider/sqlImp.dart';
import 'package:animecrunch/home/blocSetup.dart';
import 'package:animecrunch/home/homebloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode:ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: BlocProvider(
        create: (context) => HomeBloc()..add(HomeInitialEvent()),
        child: const BlocPage(),
      ),
    );
  }
}