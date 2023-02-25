import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/country_data_model.dart';

abstract class CountryDataLocalDataSource {
  Future<CountryDataModel> getLastCountryData();
  Future<void> cacheCountryData(CountryDataModel cacheData);
}

// ignore: constant_identifier_names
const String CACHED_COUNTRY_DATA = "CACHED_COUNTRY_DATA";

class CountryDataLocalDataSourceImpl implements CountryDataLocalDataSource {
  final SharedPreferences sharedPreferences;

  CountryDataLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<CountryDataModel> getLastCountryData() async {
    var jsonString = sharedPreferences.getString(CACHED_COUNTRY_DATA);
    if (jsonString != null) {
      return Future.value(CountryDataModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }


  @override
  Future<void> cacheCountryData(CountryDataModel cacheData) {
    return sharedPreferences.setString(CACHED_COUNTRY_DATA, jsonEncode(cacheData.toJson()));
    
  }
}
