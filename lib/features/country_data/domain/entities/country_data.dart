import 'package:equatable/equatable.dart';

class CountryData extends Equatable {
  final double unemployment;
  final double population;
  final String capital;
  final double forestedArea;
  final String region;
  final double tourists;

  const CountryData({
    required this.unemployment,
    required this.population,
    required this.capital,
    required this.forestedArea,
    required this.region,
    required this.tourists,
  });
  
  @override
  List<Object?> get props => [capital, region];

  
}
