import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/home/home_services/WeatherAPIProvider.dart';

import 'widgets/HomePage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(fontFamily: "Arial"),
    home: MultiRepositoryProvider(providers: [
      RepositoryProvider(
        create: (context) => WeatherService(),
      )
    ], child: const HomePage()),
  ));
}
