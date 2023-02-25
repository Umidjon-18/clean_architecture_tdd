import 'package:alice/alice.dart';
import 'package:clean_architecture_tdd/features/country_data/presentation/bloc/country_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/country_data/presentation/pages/country_data_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: di.sl<Alice>().getNavigatorKey(),
      title: 'Country Data App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<CountryDataBloc>(),
          ),
        ],
        child: const CountryDataPage(),
      ),
    );
  }
}
