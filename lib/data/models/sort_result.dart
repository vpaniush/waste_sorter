class SortResult {
  final String label;
  final double confidence;

  SortResult({this.label, this.confidence});

  SortResult.fromMap(Map map)
      : label = (map['label'] as String).split(' ').last,
        confidence = map['confidence'];
}
