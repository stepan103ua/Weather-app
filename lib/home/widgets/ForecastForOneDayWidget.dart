import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home/forecast_bloc/bloc/forecast_bloc.dart';

class ForecastBodyWidget extends StatelessWidget {
  const ForecastBodyWidget({
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
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "24 Hours",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: width,
            height: height * 0.20,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: height * 0.1,
                    width: width * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          DateFormat("j")
                              .format(state.forecast.hourlyData[index]["date"]),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        /*Container(
                          width: height * 0.05,
                          height: height * 0.05,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.yellowAccent, Colors.pink],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.yellow,
                                    blurRadius: 10)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(180))),
                        ),*/
                        SizedBox(
                          width: width * 0.2,
                          height: height * 0.1,
                          child: Image.asset(
                              state.forecast.hourlyData[index]["icon"]
                                  .toString(),
                              fit: BoxFit.contain),
                        ),
                        Text(
                          '${state.forecast.hourlyData[index]["temperature"].toStringAsFixed(1)}°'
                              .toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: width * 0.02,
                  );
                },
                itemCount: state.forecast.hourlyData.length),
          ),
        ],
      ),
    );
  }
}
