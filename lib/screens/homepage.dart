import 'package:country_details/model/country_model.dart';
import 'package:country_details/screens/details.dart';
import 'package:country_details/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
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
            var trial = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (trial == null) {
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
                      IconButton(
                          icon: const Icon(Icons.lightbulb),
                          onPressed: () {
                            Get.isDarkMode
                                ? Get.changeTheme(Theme.of(context))
                                : Get.changeTheme(ThemeData.dark());
                          })
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        searchParameter = _searchController.text;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: "Search Country",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.globe),
                        label: const Text("EN"),
                        style: const ButtonStyle(),
                      ),
                      OutlinedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return const Contains();
                                }).then((value) => setState(
                                  () {
                                    final filter = trial
                                        .where((country) => trial.any(
                                            (regionSelected) =>
                                                // ignore: unrelated_type_equality_checks
                                                country.region ==
                                                regionSelected))
                                        .toList();
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filter.length,
                                        itemBuilder: (context, index) {
                                          if (trial[index]
                                                  .name
                                                  ?.common!
                                                  .toLowerCase()
                                                  .contains(_searchController
                                                      .text
                                                      .toLowerCase()) ==
                                              true) {
                                            return Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: ListTile(
                                                leading: SizedBox(
                                                  width: 45,
                                                  height: 40,
                                                  child: Image.network(
                                                    "${filter[index].flags?.png}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                title: Text(
                                                  "${filter[index].name?.common}",
                                                  style: const TextStyle(
                                                      fontFamily: "Axiforma",
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                subtitle: Text(
                                                  filter[index].capital != null
                                                      ? "${trial[index].capital[0]}"
                                                      : "",
                                                  style: const TextStyle(
                                                      fontFamily: "Axiforma",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                onTap: (() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CountryDetails(
                                                                index: index,
                                                                countryName:
                                                                    filter[index]
                                                                        .name
                                                                        ?.common!,
                                                              )));
                                                }),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        });
                                  },
                                ));
                          },
                          icon: const Icon(CupertinoIcons.color_filter),
                          label: const Text("Filter"))
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: trial.length,
                      itemBuilder: (context, index) {
                        if (trial[index].name?.common!.toLowerCase().contains(
                                _searchController.text.toLowerCase()) ==
                            true) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: ListTile(
                              leading: SizedBox(
                                width: 45,
                                height: 40,
                                child: Image.network(
                                  "${trial[index].flags?.png}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                "${trial[index].name?.common}",
                                style: const TextStyle(
                                    fontFamily: "Axiforma",
                                    fontWeight: FontWeight.w900),
                              ),
                              subtitle: Text(
                                trial[index].capital != null
                                    ? "${trial[index].capital[0]}"
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
                                              countryName:
                                                  trial[index].name?.common!,
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
