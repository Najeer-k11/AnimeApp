import 'dart:async';

import 'package:animecrunch/home/data/dataProvider.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/item.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(fetchEvent);
  }


  FutureOr<void> fetchEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    final DataProvider dataProvider = DataProvider();
    List<Item> values = [];
    List<Item> randoms = [];
    emit(HomeLoading());
    values = await dataProvider.getData();
    randoms = await dataProvider.getRand();
    emit(HomeLoaded(data: values,rand: randoms));
  }
}
