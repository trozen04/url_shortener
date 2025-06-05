part of 'shrink_zap_bloc.dart';

@immutable
sealed class ShrinkZapEvent {}

class ShrinkZapEventHandler extends ShrinkZapEvent {
  String url;
  ShrinkZapEventHandler({required this.url});
}
