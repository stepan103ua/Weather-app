import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/home/home_services/WeatherAPIProvider.dart';

class WeatherStatus extends StatelessWidget {
  const WeatherStatus({
    Key? key,
    required this.height,
    required this.weather,
    required this.width,
  }) : super(key: key);
  final WeatherAPI weather;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weather.city}, ${weather.country}",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.02)),
                  Text(
                    weather.temperatureInC.toStringAsFixed(1) + '°',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.02)),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(66, 54, 84, 255),
                    ),
                    child: Center(
                      child: Text(
                        weather.weatherDescription,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.3,
            child: Image.asset(
              weather.getIconPath(),
              fit: BoxFit.contain,
            ),
          )
          /*Container(
            width: height * 0.15,
            height: height * 0.15,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.pink],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.lightBlue,
                      blurRadius: 40)
                ],
                borderRadius: BorderRadius.all(Radius.circular(180))),
          )*/
        ],
      ),
    );
  }
}
