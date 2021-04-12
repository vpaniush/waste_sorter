import 'package:tflite/tflite.dart';

import 'waste_sorting_service.dart';

class TFliteWasteSortingService implements WasteSortingService {
  @override
  Future<void> load() async {
    final loadRes = await Tflite.loadModel(
      model: 'assets/network/model_unquant.tflite',
      labels: 'assets/network/labels.txt',
    );
    print('\nload result: $loadRes\n');
  }

  @override
  Future<List> classify(String path) async {
    print('\n-----run model on $path-----\n\n');
    return await Tflite.runModelOnImage(
      path: path,
      numResults: 6,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
  }

  @override
  Future<void> close() async {
    await Tflite.close();
  }
}
