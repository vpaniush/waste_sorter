import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:waste_sorter/domain/repositories/user_repository.dart';
import 'package:waste_sorter/domain/repositories/waste_sorting_repository.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final WasteSortingRepository wasteSortingRepository;
  final UserRepository userRepository;

  AppBloc({
    @required this.wasteSortingRepository,
    @required this.userRepository,
  }) : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is LoadApp) {
      yield* _mapLoadApp(event);
    }
  }

  Stream<AppState> _mapLoadApp(LoadApp event) async* {
    await wasteSortingRepository.load();
    final isSignedIn = await userRepository.isSignedIn();
    yield AppLoaded(isSignedIn: isSignedIn);
  }

  @override
  Future<void> close() async {
    await wasteSortingRepository.close();
    return super.close();
  }
}
