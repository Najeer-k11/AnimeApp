import 'dart:async';

import 'package:animecrunch/search/Data/searchProvider.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/item.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitEvent>(initEvent);
    on<SearchFetchEvent>(fetchEvent);
  }

  FutureOr<void> initEvent(SearchInitEvent event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }

  FutureOr<void> fetchEvent(SearchFetchEvent event, Emitter<SearchState> emit) async {
    final SearchProvider sp = SearchProvider();
    List<Item> data = [];
    emit(SearchFetching());
    data = await sp.getSearch(event.query);
    emit(SearchLoaded(data: data));
  }
}
