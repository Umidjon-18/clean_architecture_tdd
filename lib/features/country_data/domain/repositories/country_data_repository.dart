import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/country_data.dart';

abstract class CountryDataRepository {
  Future<Either<Failure, CountryData>> getConcreteCountryData(String countryName);
  Future<Either<Failure, CountryData>> getRandomCountryData(String countryName);
}