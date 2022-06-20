part of 'forecast_bloc.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastLoadingState extends ForecastState {}

class ForecastLoadedState extends ForecastState {
  final ForecastWeather forecast;

  const ForecastLoadedState(this.forecast);

  @override
  List<Object> get props => [forecast];
}
