import 'dart:developer';

import 'constants.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  static String baseUrl = 'https://restcountries.com/v3.1/name/peru';
}

var url = Uri.parse(ApiConstants.baseUrl);

class ApiService {
  Future<List<Details>> getDetails() async {
    // try {
    //   var response = await http.get(url);
    //   if (response.statusCode == 200) {
    //     List<Details> detail = detailsFromJson(response.body);
    //     return detail;
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
    Map<String, String> _getHeaders() => {
          'Content-Type': 'application/json',
        };
    var response = await http.get(url, headers: _getHeaders());
    Future<List<Details>> detail =
        detailsFromJson(response.body) as Future<List<Details>>;
    return detail;
  }
}
