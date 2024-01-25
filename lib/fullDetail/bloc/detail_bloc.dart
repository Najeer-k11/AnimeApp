import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../detailProvider/detailProvider.dart';
import '../model/detailAnime.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<DetailFetchEvent>(fetchEvent);
  }

  FutureOr<void> fetchEvent(DetailFetchEvent event, Emitter<DetailState> emit) async {
    Data data;
    DetailProvider dp = DetailProvider();
    emit(DetailLoading());
    data = await dp.getDetails(event.id);
    emit(DetailLoaded(detail: data));
  }
}
