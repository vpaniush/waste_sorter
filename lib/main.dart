import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'presentation/app.dart';

void main() {
  runApp(
    EasyLocalization(
      child: App(),
      supportedLocales: [
        Locale('uk', 'UA'),
      ],
      path: 'assets/translations',
    ),
  );
}
