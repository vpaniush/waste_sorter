import 'package:waste_sorter/data/api/stats/stats_service.dart';

class StatsRepository {
  final StatsService _service;

  StatsRepository(this._service);

  Future<Map<String, int>> getStats() => _service.getStats();

  Future<void> updateStats(String wasteType) => _service.updateStats(wasteType);
}
