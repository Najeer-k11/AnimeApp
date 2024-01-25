part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{}

class HomeLoaded extends HomeState{
  final List<Item> data;
  final List<Item> rand;
  HomeLoaded({required this.data,required this.rand});
}