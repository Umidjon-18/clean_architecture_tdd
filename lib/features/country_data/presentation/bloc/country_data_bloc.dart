// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:clean_architecture_tdd/core/constants/countries.dart';
import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/util/input_checker.dart';
import 'package:clean_architecture_tdd/features/country_data/domain/usecases/get_concrete_country_use_case.dart';
import 'package:clean_architecture_tdd/features/country_data/domain/usecases/get_random_country_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/country_data.dart';

part 'country_data_event.dart';
part 'country_data_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - Country name must be only A-Z characters';

class CountryDataBloc extends Bloc<CountryDataEvent, CountryDataState> {
  final GetConcreteCountryUseCase concreteCountryUseCase;
  final GetRandomCountryUseCase randomCountryUseCase;
  final InputChecker inputChecker;
  CountryDataBloc({
    required this.concreteCountryUseCase,
    required this.randomCountryUseCase,
    required this.inputChecker,
  }) : super(Initial()) {
    on<ConcreteCountryDataEvent>((event, emit) async {
      emit(Loading());
      final bool isValid = inputChecker.inputTextChecker(event.countryName);
      if (isValid) {
        final failureOrCountryData = await concreteCountryUseCase(event.countryName.trim());
          failureOrCountryData.fold(
            (failure) => emit(Error(message: _mapToStringMessage(failure))),
            (countryData) => emit(Loaded(countryData: countryData)),
          );
      }else {
        emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      }
    });



    on<RandomCountryDataEvent>((event, emit) async {
      emit(Loading());
      final failureOrCountryData = await randomCountryUseCase(countries[Random.secure().nextInt(1)]);
      failureOrCountryData.fold(
        (failure) => emit(Error(message: _mapToStringMessage(failure))),
        (countryData) => emit(Loaded(countryData: countryData)),
      );
    });
  }
}

String _mapToStringMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return "Unexpected failure";
  }
}
