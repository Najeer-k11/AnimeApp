part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}


class SearchInitEvent extends SearchEvent {}

class SearchFetchEvent extends SearchEvent {
  final String query;
  SearchFetchEvent({required this.query});
}