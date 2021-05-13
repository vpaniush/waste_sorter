import 'package:tflite/tflite.dart';
import 'package:waste_sorter/data/models/sort_result.dart';

import 'tflite_response_parser.dart';
import 'waste_sorting_service.dart';

class TFliteWasteSortingService implements WasteSortingService {
  @override
  Future<void> load() async {
    await Tflite.loadModel(
      model: 'assets/network/model_unquant.tflite',
      labels: 'assets/network/labels.txt',
    );
  }

  @override
  Future<List<SortResult>> classify(String path) async {
    final data = await Tflite.runModelOnImage(
      path: path,
      numResults: 6,
      threshold: 0.75,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    return TFliteResponseParser.parse(data);
  }

  @override
  Future<void> close() async {
    await Tflite.close();
  }
}
