import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/home/home_services/WeatherAPIProvider.dart';

part 'homebloc_event.dart';
part 'homebloc_state.dart';

class HomeblocBloc extends Bloc<HomeblocEvent, HomeblocState> {
  final WeatherService _weatherService;
  HomeblocBloc(this._weatherService) : super(HomeblocLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      final activity = await _weatherService.getWeatherApi();
      emit(HomeLoadedState(activity));
    });
  }
}
