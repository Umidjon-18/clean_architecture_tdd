import 'package:alice/alice.dart';
import 'package:clean_architecture_tdd/core/network/network_info.dart';
import 'package:clean_architecture_tdd/core/util/input_checker.dart';
import 'package:clean_architecture_tdd/features/country_data/data/datasources/local/local_data_source.dart';
import 'package:clean_architecture_tdd/features/country_data/data/datasources/remote/remote_data_source.dart';
import 'package:clean_architecture_tdd/features/country_data/data/repositories/country_data_repository_impl.dart';
import 'package:clean_architecture_tdd/features/country_data/domain/repositories/country_data_repository.dart';
import 'package:clean_architecture_tdd/features/country_data/domain/usecases/get_concrete_country_use_case.dart';
import 'package:clean_architecture_tdd/features/country_data/domain/usecases/get_random_country_use_case.dart';
import 'package:clean_architecture_tdd/features/country_data/presentation/bloc/country_data_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Country Data
  sl.registerFactory(
    () => CountryDataBloc(
      concreteCountryUseCase: sl(),
      randomCountryUseCase: sl(),
      inputChecker: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetConcreteCountryUseCase(countryDataRepository: sl()));
  sl.registerLazySingleton(() => GetRandomCountryUseCase(countryDataRepository: sl()));
  sl.registerLazySingleton<CountryDataRepository>(
    () => CountryDataRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CountryDataLocalDataSource>(() => CountryDataLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CountryDataRemoteDataSource>(() => CountryDataRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton(() => InputChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<Alice>(Alice(showInspectorOnShake: true));
}
