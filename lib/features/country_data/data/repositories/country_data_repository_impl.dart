import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote/remote_data_source.dart';
import '../models/country_data_model.dart';
import '../../domain/entities/country_data.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/country_data_repository.dart';
import 'package:dartz/dartz.dart';

typedef _ConcreteOrRandomChooser = Future<CountryDataModel> Function();

class CountryDataRepositoryImpl implements CountryDataRepository {
  final NetworkInfo networkInfo;
  final CountryDataLocalDataSource localDataSource;
  final CountryDataRemoteDataSource remoteDataSource;

  CountryDataRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CountryData>> getConcreteCountryData(String countryName) async {
    return await _fetchCountry(() => remoteDataSource.fetchConcreteCountryData(countryName));
  }

  @override
  Future<Either<Failure, CountryData>> getRandomCountryData(String countryName) async {
    return await _fetchCountry(() => remoteDataSource.fetchRandomCountryData(countryName));
  }

  Future<Either<Failure, CountryData>> _fetchCountry(
    _ConcreteOrRandomChooser concreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        var countryData = await concreteOrRandom();
        await localDataSource.cacheCountryData(countryData);
        return Right(countryData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        var countryData = await localDataSource.getLastCountryData();
        return Right(countryData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
