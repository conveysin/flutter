part of 'homenavigation_cubit.dart';

abstract class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

class HomeNavigationIndexState extends HomeNavigationState {
  HomeNavigationIndexState(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}
