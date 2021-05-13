import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_sorter/domain/repositories/stats_repository.dart';
import 'package:waste_sorter/domain/repositories/waste_sorting_repository.dart';

import 'sorter_event.dart';
import 'sorter_state.dart';

class SorterBloc extends Bloc<SorterEvent, SorterState> {
  final _imagePicker = ImagePicker();
  final WasteSortingRepository _repository;
  final StatsRepository _statsRepository;

  SorterBloc(this._repository, this._statsRepository) : super(SorterInitial());

  @override
  Stream<SorterState> mapEventToState(SorterEvent event) async* {
    if (event is LoadSorter) {
      yield* _mapLoadSorter(event);
    } else if (event is ClassifyImage) {
      yield* _mapPickImageFromCamera(event);
    }
  }

  Stream<SorterState> _mapLoadSorter(LoadSorter event) async* {
    yield SorterLoaded();
  }

  Stream<SorterState> _mapPickImageFromCamera(ClassifyImage event) async* {
    final currentState = state;
    if (currentState is SorterLoaded) {
      final image = await _imagePicker.getImage(source: event.imageSource);
      final sortResult = await _repository.classify(image.path);
      final label = sortResult.first.label;
      _statsRepository.updateStats(label);
      yield currentState.copyWith(
        image: File(image.path),
        sortResult: label,
      );
    }
  }
}
