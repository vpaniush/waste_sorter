class WasteLabels {
  static const List<String> labelsList = <String>[
    'cardboard',
    'glass',
    'metal',
    'paper',
    'plastic',
    'trash',
  ];

  static Map<String, int> labelsMap() => Map<String, int>.fromIterable(
        labelsList,
        key: (item) => item,
        value: (item) => 0,
      );
}
