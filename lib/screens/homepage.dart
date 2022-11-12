import 'package:country_details/model/country_model.dart';
import 'package:country_details/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 24),
      child: FutureBuilder<List<CountriesModel>>(
          future: countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text("List is empty");
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore",
                        style: GoogleFonts.elsieSwashCaps(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      const Icon(CupertinoIcons.sun_max)
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Image.network(
                                "${snapshot.data?[index].flags?.png}",
                                width: 40,
                                height: 40,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${snapshot.data?[index].name?.common}",
                                    style: TextStyle(
                                        fontFamily: "Axiforma",
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    snapshot.data?[index].capital != null
                                        ? "${snapshot.data?[index].capital[0]}"
                                        : "",
                                    style: TextStyle(
                                        fontFamily: "Axiforma",
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Text("erroe");
          }),
    ));
  }
}
