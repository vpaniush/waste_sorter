import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/presentation/styles/design_config.dart';

import 'screens/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: DesignConfig.size,
        allowFontScaling: true,
        builder: () => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen(),
        ),
      );
}
