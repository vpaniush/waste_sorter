abstract class WasteSortingService {
  Future<void> load();

  Future<List> classify(String path);

  Future<void> close();
}
