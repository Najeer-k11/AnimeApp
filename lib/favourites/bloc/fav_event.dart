part of 'fav_bloc.dart';

@immutable
abstract class FavEvent {}

class FavInit extends FavEvent {}

class FavDelete extends FavEvent {
  final Item it;
  FavDelete({required this.it});
}

class FavInsert extends FavEvent{
  final Item it;
  FavInsert({required this.it});
}