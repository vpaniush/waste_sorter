import 'package:waste_sorter/data/api/waste_sorting/waste_sorting_service.dart';
import 'package:waste_sorter/data/models/sort_result.dart';

class WasteSortingRepository {
  final WasteSortingService _service;

  WasteSortingRepository(this._service);

  Future<void> load() => _service.load();

  Future<List<SortResult>> classify(String path) => _service.classify(path);

  Future<void> close() => _service.close();
}
