import 'package:flutter/material.dart';
import 'package:umbrella/models/weather_model.dart';
import 'package:umbrella/widgets/weather_widget.dart';

import '../common/poppins_fonts.dart';

class SelectWeatherWidget extends StatefulWidget {
  final WeatherModel data;
  final void Function(String, String, String) onWeatherChange;

  SelectWeatherWidget({super.key, required this.data, required this.onWeatherChange});

  @override
  State<SelectWeatherWidget> createState() => _SelectWeatherWidgetState();
}

class _SelectWeatherWidgetState extends State<SelectWeatherWidget> {
  Map<String, bool> weatherAM = {
    "Clear": false,
    "Sunny": false,
    "Windy": false,
    "Cloudy": false,
    "Rainy": false,
    "Thunderstorm": false
  };
  Map<String, bool> weatherPM = {
    "Clear": false,
    "Sunny": false,
    "Windy": false,
    "Cloudy": false,
    "Rainy": false,
    "Thunderstorm": false
  };

  List<Widget> getWeatherWidgetList(String choice) {
    List<Widget> widgetList = [];
    widgetList.add(const SizedBox(
      width: 10.0,
    ));
    widgetList.add(Text(
      choice,
      style: TextStyle(
        fontFamily: Poppins.regular,
        color: const Color(0xFF727272),
      ),
    ));
    if (choice == "AM") {
      weatherAM.forEach((key, value) {
        widgetList.add(const Spacer());
        widgetList.add(WeatherWidget(
            id: widget.data.id,
            selected: widget.data.weatherAM ?? '',
            timeOfTheDay: "AM",
            label: key,
            onClick: widget.onWeatherChange));
      });
      return widgetList;
    } else if (choice == "PM") {
      weatherPM.forEach((key, value) {
        widgetList.add(const Spacer());
        widgetList.add(WeatherWidget(
            id: widget.data.id,
            selected: widget.data.weatherPM ?? '',
            timeOfTheDay: "PM",
            label: key,
            onClick: widget.onWeatherChange));
      });
      return widgetList;
    } else {
      return widgetList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.58,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: getWeatherWidgetList("AM"),
            ),
          ),
          Container(
            height: 1.0,
            color: const Color(0xFF727272),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: getWeatherWidgetList("PM"),
            ),
          ),
        ],
      ),
    );
  }
}
