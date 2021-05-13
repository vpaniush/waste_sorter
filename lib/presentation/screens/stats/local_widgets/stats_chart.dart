import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/domain/blocs/stats_bloc/bloc.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state is StatsLoaded) {
            return _barChart(state);
          }
          return Container();
        },
      );

  Widget _barChart(StatsLoaded state) => BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: _barTouchData(state),
          titlesData: _titlesData(state),
          borderData: _borderData(),
          barGroups: _barGroups(state),
        ),
      );

  BarTouchData _barTouchData(StatsLoaded state) => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipBottomMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData _titlesData(StatsLoaded state) => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
          margin: 20.h,
          getTitles: (value) => _getTitles(value, state),
        ),
        leftTitles: SideTitles(showTitles: false),
      );

  String _getTitles(double value, StatsLoaded state) =>
      state.stats.keys.elementAt(value.toInt()).tr();

  List<BarChartGroupData> _barGroups(StatsLoaded state) {
    final stats = state.stats;
    final List<BarChartGroupData> groups = <BarChartGroupData>[];
    for (int i = 0; i < stats.entries.length; i++) {
      groups.add(
        _barChartGroupData(
          i,
          stats.entries.elementAt(i).value.toDouble(),
        ),
      );
    }
    return groups;
  }

  BarChartGroupData _barChartGroupData(int x, double y) => BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            y: y,
            width: 15.w,
            borderRadius: BorderRadius.zero,
            colors: [Colors.green[400]]
          )
        ],
        showingTooltipIndicators: [0],
      );

  FlBorderData _borderData() => FlBorderData(
        show: true,
        border: Border(bottom: BorderSide()),
      );
}
