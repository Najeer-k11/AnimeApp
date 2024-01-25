part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchFetching extends SearchState{}

class SearchLoaded extends SearchState {
  final List<Item> data;
  SearchLoaded({required this.data});
}


