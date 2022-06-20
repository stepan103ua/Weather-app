import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/home/home_services/WeatherAPIProvider.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherService _weatherService;
  ForecastBloc(this._weatherService) : super(ForecastLoadingState()) {
    on<LoadForecastApiEvent>((event, emit) async {
      final activity = await _weatherService.getForecastWeatherApi();
      emit(ForecastLoadedState(activity));
    });
  }
}
