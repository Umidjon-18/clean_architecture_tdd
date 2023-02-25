import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country_data.dart';
import 'package:dartz/dartz.dart';

import '../repositories/country_data_repository.dart';

class GetConcreteCountryUseCase implements UseCase<CountryData, String> {
  CountryDataRepository countryDataRepository;
  GetConcreteCountryUseCase({required this.countryDataRepository});
  @override
  Future<Either<Failure, CountryData>> call(String country) async {
    return await countryDataRepository.getConcreteCountryData(country);
  }
}
