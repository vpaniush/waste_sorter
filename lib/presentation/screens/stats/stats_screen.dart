import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/domain/blocs/stats_bloc/bloc.dart';
import 'package:waste_sorter/presentation/widgets/ws_app_bar.dart';

import 'local_widgets/stats_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StatsBloc>(context).add(LoadStats());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: WsAppBar.build(title: 'Statistics'),
        body: _body(),
      );

  Widget _body() => Padding(
        padding: EdgeInsets.all(15.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _description(),
              SizedBox(height: 20.h),
              _chart(),
            ],
          ),
        ),
      );

  Widget _description() => Text(
        'Here is your all-time statistics by waste types.',
        style: TextStyle(fontSize: 16.sp),
      );

  Widget _chart() => Container(
        padding: EdgeInsets.only(top: 100.h, left: 5.w, right: 5.w),
        color: Colors.grey[300],
        child: StatsChart(),
      );
}
