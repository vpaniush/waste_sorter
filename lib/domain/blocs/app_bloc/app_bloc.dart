import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:waste_sorter/domain/repositories/waste_sorting_repository.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final WasteSortingRepository wasteSortingRepository;

  AppBloc({@required this.wasteSortingRepository}) : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is LoadApp) {
      yield* _mapLoadApp(event);
    }
  }

  Stream<AppState> _mapLoadApp(LoadApp event) async* {
    await wasteSortingRepository.load();
    yield AppLoaded();
  }

  @override
  Future<void> close() async {
    await wasteSortingRepository.close();
    return super.close();
  }
}
