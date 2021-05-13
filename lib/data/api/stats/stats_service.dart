abstract class StatsService {
  Future<Map<String, int>> getStats();

  Future<void> updateStats(String wasteType);
}
