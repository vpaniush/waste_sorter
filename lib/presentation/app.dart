import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waste_sorter/data/api/auth/firebase_auth_service.dart';
import 'package:waste_sorter/data/api/stats/firebase_stats_service.dart';
import 'package:waste_sorter/data/api/waste_sorting/tflite_waste_sorting_service.dart';
import 'package:waste_sorter/domain/blocs/app_bloc/bloc.dart';
import 'package:waste_sorter/domain/blocs/auth_bloc/bloc.dart';
import 'package:waste_sorter/domain/blocs/sorter_bloc/bloc.dart';
import 'package:waste_sorter/domain/blocs/stats_bloc/bloc.dart';
import 'package:waste_sorter/domain/repositories/stats_repository.dart';
import 'package:waste_sorter/domain/repositories/user_repository.dart';
import 'package:waste_sorter/domain/repositories/waste_sorting_repository.dart';
import 'package:waste_sorter/presentation/screens/auth/auth_screen.dart';
import 'package:waste_sorter/presentation/styles/design_config.dart';

import 'screens/home/home_screen.dart';

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
              buildWhen: (previous, current) =>
                  (previous is AppInitial) && (current is AppLoaded),
              builder: (context, state) {
                if (state is AppLoaded) {
                  return _materialApp(state);
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
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            FirebaseAuthService(),
          ),
        ),
        RepositoryProvider<StatsRepository>(
          create: (context) => StatsRepository(
            FirebaseStatsService(),
          ),
        ),
      ];

  _blocProviders() => [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(
            wasteSortingRepository:
                RepositoryProvider.of<WasteSortingRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          )..add(LoadApp()),
        ),
        BlocProvider<SorterBloc>(
          create: (context) => SorterBloc(
            RepositoryProvider.of<WasteSortingRepository>(context),
            RepositoryProvider.of<StatsRepository>(context),
          )..add(LoadSorter()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider<StatsBloc>(
          create: (context) => StatsBloc(
            RepositoryProvider.of<StatsRepository>(context),
          ),
        ),
      ];

  Widget _materialApp(AppLoaded state) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: state.isSignedIn
            ? HomeScreen()
            : AuthScreen(AuthScreenType.signIn),
      );
}
