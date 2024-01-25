part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class DetailFetchEvent extends DetailEvent {
  final String id;
  DetailFetchEvent({required this.id});
}
