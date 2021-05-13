import 'package:waste_sorter/data/models/sort_result.dart';

abstract class WasteSortingService {
  Future<void> load();

  Future<List<SortResult>> classify(String path);

  Future<void> close();
}
