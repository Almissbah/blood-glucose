import 'package:blood_glucose/injection.dart';
import 'package:blood_glucose/presentation/bloc/samples_bloc.dart';
import 'package:blood_glucose/presentation/ui/glucose_chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(Env.prod);
  await Future.delayed(Duration(seconds: 1));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: GlucoseChartScreen.routeName,
        routes: {
          GlucoseChartScreen.routeName: (context) =>
              BlocProvider<SamplesBloc>.value(
                value: getIt<SamplesBloc>(),
                child: GlucoseChartScreen(),
              ),
        });
  }
}
