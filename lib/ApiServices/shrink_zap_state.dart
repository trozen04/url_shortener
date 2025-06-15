part of 'shrink_zap_bloc.dart';

@immutable
sealed class ShrinkZapState {}

final class ShrinkZapInitial extends ShrinkZapState {}

final class ShrinkZapLoading extends ShrinkZapState {}

class ShrinkZapSuccess extends ShrinkZapState {
  final String message;
  final Map<String, dynamic> responseData;
  final String webpageTitle;

  ShrinkZapSuccess(this.message, this.responseData, this.webpageTitle);
}

final class ShrinkZapError extends ShrinkZapState {
  final String message;
  ShrinkZapError(this.message);
}