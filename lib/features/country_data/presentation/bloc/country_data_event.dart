part of 'country_data_bloc.dart';

abstract class CountryDataEvent extends Equatable {
  const CountryDataEvent();

  @override
  List<Object> get props => [];
}

class ConcreteCountryDataEvent extends CountryDataEvent {
  final String countryName;
  const ConcreteCountryDataEvent({required this.countryName});

  @override
  List<Object> get props => [countryName];
}

class RandomCountryDataEvent extends CountryDataEvent {
  
}
