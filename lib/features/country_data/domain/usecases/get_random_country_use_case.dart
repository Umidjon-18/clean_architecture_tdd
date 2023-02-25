import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country_data.dart';
import '../repositories/country_data_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomCountryUseCase implements UseCase<CountryData, String> {
  final CountryDataRepository countryDataRepository;

  GetRandomCountryUseCase({required this.countryDataRepository});

  @override
  Future<Either<Failure, CountryData>> call(String countryName) async {
    return await countryDataRepository.getRandomCountryData(countryName);
  }
}
