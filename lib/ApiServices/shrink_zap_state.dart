part of 'shrink_zap_bloc.dart';

@immutable
sealed class ShrinkZapState {}

final class ShrinkZapInitial extends ShrinkZapState {}

final class ShrinkZapLoading extends ShrinkZapState {}

final class ShrinkZapSuccess extends ShrinkZapState {
  final String message;
  final responseData;
  ShrinkZapSuccess(this.message, this.responseData);
}

final class ShrinkZapError extends ShrinkZapState {
  final String message;
  ShrinkZapError(this.message);
}