import 'package:country_details/model/country_model.dart';
import 'package:country_details/screens/details.dart';
import 'package:country_details/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<CountriesModel>> countries;
  var isLoaded = false;

  String searchParameter = "";

  final TextEditingController _searchController = TextEditingController();
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
      minimum: const EdgeInsets.symmetric(horizontal: 20),
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      onChanged: ((value) {
                        setState(() {
                          searchParameter = _searchController.text;
                        });
                      }),
                      textAlign: TextAlign.center,
                      controller: _searchController,
                      decoration: const InputDecoration(
                          iconColor: Colors.grey,
                          filled: true,
                          fillColor: Colors.grey,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          focusedBorder: InputBorder.none,
                          hintText: "Search Country",
                          hintStyle: TextStyle(
                              fontFamily: "Axiforma",
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.network_cell),
                        label: const Text("EN"),
                        style: const ButtonStyle(),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Contains();
                                });
                          },
                          icon: const Icon(Icons.filter),
                          label: const Text("Filter"))
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data?[index].name?.common!
                                .toLowerCase()
                                .contains(
                                    _searchController.text.toLowerCase()) ==
                            true) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: ListTile(
                              leading: SizedBox(
                                width: 45,
                                height: 40,
                                child: Image.network(
                                  "${snapshot.data?[index].flags?.png}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                "${snapshot.data?[index].name?.common}",
                                style: const TextStyle(
                                    fontFamily: "Axiforma",
                                    fontWeight: FontWeight.w900),
                              ),
                              subtitle: Text(
                                snapshot.data?[index].capital != null
                                    ? "${snapshot.data?[index].capital[0]}"
                                    : "",
                                style: const TextStyle(
                                    fontFamily: "Axiforma",
                                    fontWeight: FontWeight.w500),
                              ),
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryDetails(
                                              index: index,
                                              countryName: snapshot
                                                  .data?[index].name?.common!,
                                            )));
                              }),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
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
