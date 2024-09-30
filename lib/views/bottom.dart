
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather/views/forecast_view.dart';
import 'package:weather/views/search.dart';
import 'package:weather/views/weather_view.dart';
class PracticeBottomNavBar extends StatefulWidget {
  const PracticeBottomNavBar({super.key});
  @override
  State<PracticeBottomNavBar> createState() => _PracticeBottomNavBarState();}
class _PracticeBottomNavBarState extends State<PracticeBottomNavBar> {
  List list = [
    WeatherView(),
    ForecastView(),
    WeatherSearch()
  ];
  List<Icon> allItems = [
    Icon(Icons.home,color: Colors.white,),
    Icon(Icons.menu,color: Colors.white,),
    Icon(Icons.search_sharp,color: Colors.white,),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xffffbf00),
        color:Color(0xfff4d35e).withOpacity(0.5) ,
        buttonBackgroundColor:Color(0xff000000).withOpacity(0.4),
        index: _currentIndex,
        onTap: (int index){
          _currentIndex = index;
          setState(() {
          });
        },
        items: allItems,
      ),
    );  }
}