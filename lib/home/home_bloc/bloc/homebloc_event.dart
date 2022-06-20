part of 'homebloc_bloc.dart';

abstract class HomeblocEvent extends Equatable {
  const HomeblocEvent();

  @override
  List<Object> get props => [];
}

class LoadApiEvent extends HomeblocEvent {
  @override
  List<Object> get props => [];
}
