import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      child: App(),
      supportedLocales: [
        Locale('en'),
        Locale('uk'),
      ],
      path: 'assets/translations',
    ),
  );
}
