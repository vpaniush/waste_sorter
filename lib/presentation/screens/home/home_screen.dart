import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/presentation/screens/sorter/sorter_screen.dart';
import 'package:waste_sorter/presentation/screens/stats/stats_screen.dart';
import 'package:waste_sorter/presentation/widgets/ws_app_bar.dart';
import 'package:waste_sorter/presentation/widgets/ws_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: WsAppBar.build(title: 'Waste Sorter'),
        body: _body(context),
      );

  Widget _body(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WSButton(
              onPressed: () => _navigateTo(context, SorterScreen()),
              title: 'Sort waste',
            ),
            SizedBox(height: 20.h),
            WSButton(
              onPressed: () => _navigateTo(context, StatsScreen()),
              title: 'View statistics',
            ),
          ],
        ),
      );

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
