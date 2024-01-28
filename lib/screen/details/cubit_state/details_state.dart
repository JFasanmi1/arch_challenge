part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class SingleCoreLoading extends DetailsState {}

class SingleCoreSuccess extends DetailsState {}

class SingleCoreError extends DetailsState {
  final String message;

  SingleCoreError(this.message);
}
