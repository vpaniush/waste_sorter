import 'package:waste_sorter/data/models/sort_result.dart';

class TFliteResponseParser {
  static List<SortResult> parse(List data) => data
      .map(
        (res) => SortResult.fromMap(res as Map),
      )
      .toList();
}
