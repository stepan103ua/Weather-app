part of 'homebloc_bloc.dart';

abstract class HomeblocState extends Equatable {
  const HomeblocState();

  @override
  List<Object> get props => [];
}

class HomeblocLoadingState extends HomeblocState {}

class HomeLoadedState extends HomeblocState {
  final WeatherAPI weather;

  const HomeLoadedState(this.weather);

  @override
  List<Object> get props => [weather];
}
