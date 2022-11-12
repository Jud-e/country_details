import 'package:country_details/model/country_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool _isSorted = false;

class Service {
  Future<List<CountriesModel>> getCountries() async {
    var client = http.Client();

    var url = Uri.parse("https://restcountries.com/v3.1/all");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final json1 = json.decode(response.body);
      final List<CountriesModel> services =
          json1.map<CountriesModel>((e) => CountriesModel.fromJson(e)).toList();
      services.sort((a, b) => a.name!.common!.compareTo(b.name!.common!));
      return services;
    } else {
      throw Exception("Failed to load");
    }
  }
}
