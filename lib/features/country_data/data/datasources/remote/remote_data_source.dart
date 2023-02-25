import 'dart:convert';

import 'package:alice/alice.dart';
import 'package:clean_architecture_tdd/injection_container.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/country_data_model.dart';
import 'package:http/http.dart' as http;

abstract class CountryDataRemoteDataSource {
  Future<CountryDataModel> fetchConcreteCountryData(String countryName);
  Future<CountryDataModel> fetchRandomCountryData(String countryName);
}

class CountryDataRemoteDataSourceImpl implements CountryDataRemoteDataSource {
  final http.Client client;

  CountryDataRemoteDataSourceImpl({required this.client});

  @override
  Future<CountryDataModel> fetchConcreteCountryData(String countryName) => _fetchCountry(countryName);

  @override
  Future<CountryDataModel> fetchRandomCountryData(String countryName) => _fetchCountry(countryName);

  Future<CountryDataModel> _fetchCountry(String country) async {
    var responseData = await client.get(
      Uri.parse("https://api.api-ninjas.com/v1/country?name=$country"),
      headers: {"Content-Type": "application/json", "X-Api-Key": "zH2ELOPqshLZe4FwBFapJQ==LaofbTo78gza0ly5"},
    );
    sl<Alice>().onHttpResponse(responseData);

    if (responseData.statusCode == 200) {
      if (jsonDecode(responseData.body).isNotEmpty) {
        return CountryDataModel.fromJson(jsonDecode(responseData.body)[0]);
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
