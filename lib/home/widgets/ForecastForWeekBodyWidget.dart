import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home/forecast_bloc/bloc/forecast_bloc.dart';

class ForecastForWeekBodyWidget extends StatelessWidget {
  const ForecastForWeekBodyWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.state,
  }) : super(key: key);

  final ForecastLoadedState state;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Text(
            "This week",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: width,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child: Text(
                            DateFormat("EEEE")
                                .format(state.forecast.dates.elementAt(index)),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 23),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.2,
                          child: Image.asset(
                            state.forecast.getIconPath(state
                                .forecast
                                .weatherIconsDaily[
                                    state.forecast.dates.elementAt(index)]
                                .toString()),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  "${state.forecast.maxTemperature[state.forecast.dates.elementAt(index)]?.toStringAsFixed(1)}°",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  "${state.forecast.minTemperature[state.forecast.dates.elementAt(index)]?.toStringAsFixed(1)}°",
                                  style: const TextStyle(
                                      color: Colors.blueGrey, fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 0.04,
                  );
                },
                itemCount: state.forecast.dates.length),
          ),
        ),
      ],
    );
  }
}
