import 'dart:developer';

import 'constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Details>?> getDetails() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Details> detail = detailsFromJson(response.body);
        return detail;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
