import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather/constants/contant.dart';
import 'package:weather/goggle.dart';
import 'package:weather/view_model/forecast_vm.dart';
class WeatherSearch extends StatefulWidget {
  const WeatherSearch({super.key});

  @override
  State<WeatherSearch> createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  final ForecastVM cs = Get.find<ForecastVM>();
  final TextEditingController _controller = TextEditingController();
  String currentSearch = "";

  @override
  void initState() {
    super.initState();
    cs.vmGetForecastData(); // Fetch initial data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForecastVM>(builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFA500), Color(0xffFFFFFF)],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    'Weather',
                    style: myStyle(35, Colors.white, FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 380,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70,
                      ),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded),
                          hintText: currentSearch.isEmpty ? 'Search for a city' : currentSearch,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentSearch = value; // Update the current search input
                          });
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            cs.vmGetForecastDataByCity(value); // Fetch data by city
                            _controller.clear(); // Clear the input
                            setState(() {
                              currentSearch = ""; // Reset the search input after submission
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Center(child: customWidget()),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget customWidget() {
    if (cs.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (cs.forecastData.isEmpty) {
      return Center(
        child: Text("No data found"),
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: cs.forecastData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final forecast = cs.forecastData[index];
          return Container(
            height: 120,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "${iconStartPoint}${forecast.icon}${iconEndPoint}"),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${double.parse(forecast.temperature).toInt()}°C',
                            style: myStyle(30, Colors.white, FontWeight.bold),
                          ),
                          Text(
                            Jiffy.parse("${forecast.dateTime}")
                                .format(pattern: 'MMMM do yyyy'),
                            style: myStyle(15, Colors.black, FontWeight.bold),
                          ),
                          Text(
                            Jiffy.parse("${forecast.dateTime}")
                                .format(pattern: 'h:mm:ss a'),
                            style: myStyle(15, Colors.black, FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      );
    }
  }
}
