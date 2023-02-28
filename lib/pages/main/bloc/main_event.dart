part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainGetLastEvent extends MainEvent {}

class MainGetDateEvent extends MainEvent {
  final DateTime date;

  MainGetDateEvent(this.date);
}
