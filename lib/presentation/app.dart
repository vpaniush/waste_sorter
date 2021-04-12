import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/data/api/waste_sorting/tflite_waste_sorting_service.dart';
import 'package:waste_sorter/domain/blocs/app_bloc/bloc.dart';
import 'package:waste_sorter/domain/blocs/sorter_bloc/bloc.dart';
import 'package:waste_sorter/domain/repositories/waste_sorting_repository.dart';
import 'package:waste_sorter/presentation/styles/design_config.dart';

import 'screens/sorter/sorter_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: DesignConfig.size,
        allowFontScaling: true,
        builder: () => MultiRepositoryProvider(
          providers: _repositoryProviders(),
          child: MultiBlocProvider(
            providers: _blocProviders(),
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state is AppLoaded) {
                  return _materialApp();
                }
                return Container();
              },
            ),
          ),
        ),
      );

  _repositoryProviders() => [
        RepositoryProvider<WasteSortingRepository>(
          create: (context) => WasteSortingRepository(
            TFliteWasteSortingService(),
          ),
        ),
      ];

  _blocProviders() => [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(
            wasteSortingRepository:
                RepositoryProvider.of<WasteSortingRepository>(context),
          )..add(LoadApp()),
        ),
        BlocProvider<SorterBloc>(
          create: (context) => SorterBloc(
            RepositoryProvider.of<WasteSortingRepository>(context),
          ),
        ),
      ];

  Widget _materialApp() => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SorterScreen(),
      );
}
