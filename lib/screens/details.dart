import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_details/model/country_model.dart';
import 'package:country_details/services/service.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails(
      {super.key, required this.index, required this.countryName});

  final int index;
  final String? countryName;

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
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
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
        title: FutureBuilder<List<CountriesModel>>(
          future: countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text("List is empty");
              }
              // if(snapshot.data[widget.index])
              return Text(
                "${snapshot.data?[widget.index].name?.common}",
                style: TextStyle(
                    fontFamily: "Axiforma",
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 25),
              );
            } else {
              return Text("error");
            }
          },
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          // child: Text("${widget.index}"),
          child: FutureBuilder<List<CountriesModel>>(
            future: countries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Text("List is empty");
                }
                // if(snapshot.data[widget.index])
                return Column(
                  children: [
                    CarouselSlider(
                      items: [
                        Image.network(
                          "${snapshot.data?[widget.index].flags?.png}",
                        ),
                        Image.network(
                            "${snapshot.data?[widget.index].coatOfArms?.png}")
                      ],
                      options: CarouselOptions(
                        pageSnapping: true,
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 24),
                    CountryDetailRow(
                      field: "Population",
                      jsonLocation:
                          "${snapshot.data?[widget.index].population}",
                    ),
                    CountryDetailRow(
                        field: "Region",
                        jsonLocation: "${snapshot.data?[widget.index].region}"),
                    CountryDetailRow(
                        field: "Capital",
                        jsonLocation:
                            "${snapshot.data?[widget.index].capital == null ? "" : snapshot.data?[widget.index].capital[0]}"),
                    SizedBox(height: 24),
                    CountryDetailRow(
                        field: "Official Language",
                        jsonLocation:
                            "${snapshot.data?[widget.index].languages!.ara}"),
                    // CountryDetailRow(field: "Religion", jsonLocation: "${snapshot.data?[widget.index].}")
                  ],
                );
              } else {
                return Text("error");
              }
            },
          ),
        ),
      ),
    );
  }
}

class CountryDetailRow extends StatelessWidget {
  const CountryDetailRow({
    Key? key,
    required this.field,
    required this.jsonLocation,
  }) : super(key: key);

  final String field;
  final String jsonLocation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$field:",
          style: const TextStyle(
              fontFamily: "Axiforma",
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          jsonLocation,
          style: const TextStyle(
              fontFamily: "Axiforma",
              fontSize: 16,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
