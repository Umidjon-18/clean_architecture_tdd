part of 'country_data_bloc.dart';

abstract class CountryDataState extends Equatable {
  const CountryDataState();

  @override
  List<Object> get props => [];
}

class Initial extends CountryDataState {}

class Loading extends CountryDataState {}

class Loaded extends CountryDataState {
  final CountryData countryData;
  const Loaded({required this.countryData});

  @override
  List<Object> get props => [countryData];
}

class Error extends CountryDataState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
