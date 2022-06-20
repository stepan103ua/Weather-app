import 'dart:convert';

import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

WeatherAPI fromJsonCurrent(String str) => WeatherAPI.fromJSON(json.decode(str));
ForecastWeather fromJsonForecast(String str) =>
    ForecastWeather.fromJSON(json.decode(str));

class WeatherAPI {
  double temperatureInC = 0;
  double temperatureInF = 0;
  String city = "";
  String country = "";
  String weather = "";
  String weatherIcon = "";
  String weatherDescription = "";
  String iconPath = "images/sun.png";

  String getIconPath() {
    switch (weatherIcon) {
      case "01d":
        return "images/sun.png";
      case "02d":
        return "images/sun-cloud.png";
      case "03d":
        return "images/cloud.png";
      case "04d":
        return "images/cloud.png";
      case "09d":
        return "images/rain.png";
      case "10d":
        return "images/rain-low.png";
      case "11d":
        return "images/cloud-rain-lightning.png";
      case "01n":
        return "images/moon.png";
      case "02n":
        return "images/moon-cloud.png";
      case "03n":
        return "images/cloud.png";
      case "04n":
        return "images/cloud.png";
      case "09n":
        return "images/rain.png";
      case "10n":
        return "images/rain-low.png";
      case "11n":
        return "images/cloud-rain-lightning.png";
      default:
        return "http://openweathermap.org/img/wn/${weatherIcon}@2x.png";
    }
  }

  WeatherAPI.fromJSON(Map<String, dynamic> json) {
    temperatureInC = json["main"]["temp"].toDouble();
    city = json["name"];
    country = json["sys"]["country"];
    weather = json["weather"][0]["main"];
    weatherIcon = json["weather"][0]["icon"];
    print(weatherIcon);
    weatherDescription = json["weather"][0]["description"];
  }
}

class ForecastWeather {
  var weatherForecast = [];
  Set<DateTime> dates = {};
  Map<DateTime, double> maxTemperature = {};
  Map<DateTime, String> weatherIconsDaily = {};
  Map<DateTime, String> weatherIconsHourly = {};
  Map<DateTime, double> minTemperature = {};
  List<Map<String, dynamic>> hourlyData = [];

  String getIconPath(String weatherIcon) {
    switch (weatherIcon) {
      case "01d":
        return "images/sun.png";
      case "02d":
        return "images/sun-cloud.png";
      case "03d":
        return "images/cloud.png";
      case "04d":
        return "images/cloud.png";
      case "09d":
        return "images/rain.png";
      case "10d":
        return "images/rain-low.png";
      case "11d":
        return "images/cloud-rain-lightning.png";
      case "01n":
        return "images/moon.png";
      case "02n":
        return "images/moon-cloud.png";
      case "03n":
        return "images/cloud.png";
      case "04n":
        return "images/cloud.png";
      case "09n":
        return "images/rain.png";
      case "10n":
        return "images/rain-low.png";
      case "11n":
        return "images/cloud-rain-lightning.png";
      default:
        return "http://openweathermap.org/img/wn/${weatherIcon}@2x.png";
    }
  }

  ForecastWeather.fromJSON(Map<String, dynamic> json) {
    List daily = json["daily"];
    for (var i in daily) {
      dates.add(DateTime.fromMillisecondsSinceEpoch(i["dt"] * 1000));
      maxTemperature[dates.last] = i["temp"]["max"].toDouble();
      minTemperature[dates.last] = i["temp"]["min"].toDouble();
      weatherIconsDaily[dates.last] = i["weather"][0]["icon"].toString();
    }
    List hourly = json["hourly"];
    int hours = 0;
    for (var i in hourly) {
      if (hours > 24) break;
      var date = DateTime.fromMillisecondsSinceEpoch(i["dt"] * 1000);
      var temperature = i["temp"].toDouble();
      var icon = i["weather"][0]["icon"].toString();
      icon = getIconPath(icon);
      hourlyData.add({"date": date, "temperature": temperature, "icon": icon});
      hours++;
    }
  }
}

class WeatherService {
  double latitude = 49.842957;
  double longitude = 24.031111;

  Future<void> getLocation() async {
    var permision = await Geolocator.checkPermission();
    if (permision.name == "denied") {
      await Geolocator.requestPermission();
    }
    if (permision.name != "denied") {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position);
    }
  }

  Future<WeatherAPI> getWeatherApi() async {
    await getLocation();
    final response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=6c6663b3cf43fb8dd64a8bb0fbee5c3a'));
    print(latitude.toString() + " " + longitude.toString());
    final activity = fromJsonCurrent(response.body);
    return activity;
  }

  Future<ForecastWeather> getForecastWeatherApi() async {
    final response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&appid=6c6663b3cf43fb8dd64a8bb0fbee5c3a'));
    print(response.statusCode);
    final activity = fromJsonForecast(response.body);
    print("Foreast");
    return activity;
  }
}
