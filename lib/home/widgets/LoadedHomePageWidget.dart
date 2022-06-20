import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/home/forecast_bloc/bloc/forecast_bloc.dart';
import 'package:weather_app/home/home_services/WeatherAPIProvider.dart';

import '../main.dart';
import 'ForecastForOneDayWidget.dart';
import 'ForecastForWeekBodyWidget.dart';
import 'WeatherStatusWidget.dart';

class LoadedHomePage extends StatelessWidget {
  const LoadedHomePage({
    Key? key,
    required this.height,
    required this.width,
    required this.weather,
  }) : super(key: key);
  final WeatherAPI weather;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    var forecastBloc = ForecastBloc(
      RepositoryProvider.of<WeatherService>(context),
    );
    return BlocProvider(
      create: (context) => forecastBloc..add(LoadForecastApiEvent()),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: WeatherStatus(
                    height: height,
                    weather: weather,
                    width: width,
                  )),
              Expanded(
                flex: 5,
                child: BlocBuilder<ForecastBloc, ForecastState>(
                  builder: (context, state) {
                    if (state is ForecastLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ForecastLoadedState) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ForecastBodyWidget(
                                width: width, height: height, state: state),
                          ),
                          Expanded(
                            flex: 3,
                            child: ForecastForWeekBodyWidget(
                                width: width, height: height, state: state),
                          )
                        ],
                      );
                    }
                    return const Center(
                      child: Text("error"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
