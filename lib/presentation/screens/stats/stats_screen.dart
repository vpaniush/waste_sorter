import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_sorter/domain/blocs/stats_bloc/bloc.dart';

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
        appBar: _appBar(),
        body: _body(),
      );

  Widget _appBar() => AppBar(title: Text('Statistics'));

  Widget _body() => Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _description(),
              SizedBox(height: 20),
              _chart(),
            ],
          ),
        ),
      );

  Widget _description() =>
      Text('Here is your all-time statistics by waste types.');

  Widget _chart() => Container(
        padding: EdgeInsets.only(top: 100, left: 5, right: 5),
        color: Colors.grey[300],
        child: StatsChart(),
      );
}
