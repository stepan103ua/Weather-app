import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/home/home_bloc/bloc/homebloc_bloc.dart';
import 'package:weather_app/home/home_services/WeatherAPIProvider.dart';

import '../main.dart';
import 'LoadedHomePageWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homeBloc = HomeblocBloc(
      RepositoryProvider.of<WeatherService>(context),
    );
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => homeBloc..add(LoadApiEvent()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(54, 62, 74, 255),
        body: BlocBuilder<HomeblocBloc, HomeblocState>(
          builder: (context, state) {
            if (state is HomeblocLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return LoadedHomePage(
                height: height,
                width: width,
                weather: state.weather,
              );
            }

            return const Center(
              child: Text("Error"),
            );
          },
        ),
      ),
    );
  }
}
