import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_sorter/domain/repositories/stats_repository.dart';

import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsRepository _repository;

  StatsBloc(this._repository) : super(StatsInitial());

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is LoadStats) {
      yield* _mapLoadStats(event);
    }
  }

  Stream<StatsState> _mapLoadStats(LoadStats event) async* {
    final stats = await _repository.getStats();
    yield StatsLoaded(stats);
  }
}
