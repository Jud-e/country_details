import 'package:country_details/model/country_model.dart';
import 'package:country_details/services/service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<CountriesModel>> countries;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    countries = Service().getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Title"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<CountriesModel>>(
            future: countries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Text("List is empty");
                }
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Text("${snapshot.data?[index].name?.common}");
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Text("erroe");
            }));
  }
}
