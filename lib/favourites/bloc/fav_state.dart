part of 'fav_bloc.dart';


abstract class FavState {}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavLoaded extends FavState{
  List<Item> data;
  FavLoaded({required this.data});
}

class FavDel extends FavState{}