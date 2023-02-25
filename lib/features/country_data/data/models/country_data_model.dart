import '../../domain/entities/country_data.dart';

class CountryDataModel extends CountryData {
  const CountryDataModel(
      {required super.unemployment,
      required super.population,
      required super.capital,
      required super.forestedArea,
      required super.region,
      required super.tourists})
      : super();

  factory CountryDataModel.fromJson(Map<String, dynamic> json) {
    return CountryDataModel(
      unemployment: json["unemployment"],
      population: json["population"],
      capital: json["capital"],
      forestedArea: json["forested_area"],
      region: json["region"],
      tourists: json["tourists"],
    );
  }

  Map<String, dynamic> toJson() => {
    "unemployment": unemployment,
    "population": population,
    "capital": capital,
    "forestedArea": forestedArea,
    "region": region,
    "tourists": tourists,
  };
}
