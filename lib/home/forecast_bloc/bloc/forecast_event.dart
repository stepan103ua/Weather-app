part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class LoadForecastApiEvent extends ForecastEvent {
  @override
  List<Object> get props => [];
}
