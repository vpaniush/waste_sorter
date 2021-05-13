import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsInitial extends StatsState {}

class StatsLoaded extends StatsState {
  final Map<String, int> stats;

  StatsLoaded(this.stats);

  @override
  List<Object> get props => [stats];
}
