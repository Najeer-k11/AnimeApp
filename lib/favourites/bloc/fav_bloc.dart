import 'dart:async';

import 'package:animecrunch/favourites/localProvider/localData.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/item.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    on<FavInit>(fetchData);
    on<FavInsert>(insertItem);
    on<FavDelete>(deleteItem);
  }
  LocalData ld = LocalData();
  List<Item> items = [];
  List<Item> adm = [];
  FutureOr<void> fetchData(FavInit event, Emitter<FavState> emit) async {
    emit(FavLoading());
    items = await ld.getLocal();
    emit(FavLoaded(data: items));
  }

  FutureOr<void> insertItem(FavInsert event, Emitter<FavState> emit) async {
    await ld.insertItem(event.it);
  }

  FutureOr<void> deleteItem(FavDelete event, Emitter<FavState> emit) async {
    emit(FavLoading());
    await ld.deleteItem(event.it);
    adm = await ld.getLocal();
    emit(FavLoaded(data: adm));
  }

}
