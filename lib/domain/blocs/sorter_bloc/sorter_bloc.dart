import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_sorter/domain/repositories/waste_sorting_repository.dart';

import 'sorter_event.dart';
import 'sorter_state.dart';

class SorterBloc extends Bloc<SorterEvent, SorterState> {
  final _imagePicker = ImagePicker();
  final WasteSortingRepository _repository;

  SorterBloc(this._repository) : super(SorterInitial());

  @override
  Stream<SorterState> mapEventToState(SorterEvent event) async* {
    if (event is ClassifyImage) {
      yield* _mapPickImageFromCamera(event);
    }
  }

  Stream<SorterState> _mapPickImageFromCamera(ClassifyImage event) async* {
    final image = await _imagePicker.getImage(source: event.imageSource);
    final sortResult = await _repository.classify(image.path);
    yield SorterLoaded(
      image: File(image.path),
      sortResult: sortResult.toString(),
    );
  }
}
