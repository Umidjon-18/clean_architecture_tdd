import '../error/failure.dart';

class InputChecker {
  bool inputTextChecker(String inputString) {
    var countryName = inputString.trim();
    RegExp regex = RegExp(r'\d');
    if (countryName.isEmpty) return false;
    return !regex.hasMatch(countryName);
  }
}

class InvalidCountryFailure extends Failure {}
