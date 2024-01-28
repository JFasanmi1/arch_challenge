part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class CoreListLoading extends HomeState {}

class CoreListSuccess extends HomeState {}

class CoreListError extends HomeState {
  final String message;

  CoreListError(this.message);
}
