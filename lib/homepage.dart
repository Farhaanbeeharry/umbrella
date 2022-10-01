import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umbrella/common/poppins_fonts.dart';
import 'package:umbrella/models/weather_model.dart';
import 'package:umbrella/widgets/select_weather_widget.dart';
import 'package:umbrella/widgets/side_nav_day_widget.dart';

import 'common/shake_effect.dart';

class HomepageWeb extends StatefulWidget {
  const HomepageWeb({Key? key}) : super(key: key);

  @override
  State<HomepageWeb> createState() => _HomepageWebState();
}

class _HomepageWebState extends State<HomepageWeb> {
  bool showingResult = false;
  bool hasError = false;
  int homeUmbrellas = 0;
  int officeUmbrellas = 0;
  late String selectedId;
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  List<WeatherModel> sideNavList = [WeatherModel(day: "Day 1", isSelected: true)];
  final ScrollController _scrollController = ScrollController();

  String formattedTime = DateFormat('kk:mm').format(DateTime.now());
  String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
    selectedId = sideNavList.first.id;
    super.initState();
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat('kk:mm').format(DateTime.now());
    });
  }

  onClick(WeatherModel data) {
    setState(() {
      hasError = false;
      selectedId = data.id;
      for (var item in sideNavList) {
        item.isSelected = item.id == selectedId;
      }
    });
  }

  onDelete(int index, WeatherModel data) {
    setState(() {
      if (data.id == selectedId) {
        if (index == 0) {
          onClick(sideNavList[index + 1]);
        } else {
          onClick(sideNavList[index - 1]);
        }
      }
      sideNavList.removeAt(index);
    });
  }

  Widget getSelectedWeatherWidget() {
    for (var item in sideNavList) {
      if (item.id == selectedId) {
        return SelectWeatherWidget(data: item, onWeatherChange: onWeatherChange);
      }
    }
    return Container();
  }

  String getDayNumber() {
    for (var item in sideNavList) {
      if (selectedId == item.id) return (sideNavList.indexOf(item) + 1).toString();
    }
    return '';
  }

  onWeatherChange(String id, String timeOfTheDay, String label) {
    for (var item in sideNavList) {
      if (item.id == id) {
        setState(() {
          timeOfTheDay == "AM" ? item.weatherAM = label : item.weatherPM = label;
        });
      }
    }
  }

  String getDate() {
    List<String> dateArray = formattedDate.split(" ");
    return '${dateArray[0]} ${dateArray[1][0]}${dateArray[1][1]}${dateArray[1][2]} ${dateArray[2]}';
  }

  void calculateNumberOfUmbrellas() {
    if (checkForEmptyValue()) {
      homeUmbrellas = 0;
      officeUmbrellas = 0;
      for (int i = 0; i < sideNavList.length; i++) {
        if (sideNavList[i].isRainingAM()) {
          if (i == 0) {
            homeUmbrellas++;
          } else if (!sideNavList[i - 1].isRainingPM()) {
            homeUmbrellas++;
          }
        } else if (sideNavList[i].isRainingPM()) {
          if (!sideNavList[i].isRainingAM()) {
            officeUmbrellas++;
          }
        }
      }
      showingResult = true;
    }
  }

  bool checkForEmptyValue() {
    for (int i = 0; i < sideNavList.length; i++) {
      if (sideNavList[i].weatherAM == null || sideNavList[i].weatherPM == null) {
        onClick(sideNavList[i]);
        hasError = true;
        _scrollController.animateTo(
            ((_scrollController.position.maxScrollExtent + 50.0) / sideNavList.length) *
                i,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn);
        _shakeKey.currentState?.shake();
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_web.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showingResult
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1875,
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 50.0,
                                  ),
                                  Text(
                                    'Umbrella',
                                    style: TextStyle(
                                      fontFamily: Poppins.bold,
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1875,
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 50.0,
                                  ),
                                  Text(
                                    'Umbrella',
                                    style: TextStyle(
                                      fontFamily: Poppins.bold,
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 50.0,
                                  ),
                                  Container(
                                    width: 145.0,
                                    height: 2.0,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    children: sideNavList
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => SideNavDayWidget(
                                              index: e.key,
                                              listSize: sideNavList.length,
                                              data: e.value,
                                              onClick: onClick,
                                              onDelete: onDelete),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: showingResult
                        ? MediaQuery.of(context).size.width * 0.325 / 2
                        : 0.0,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: AnimatedContainer(
                          width: showingResult
                              ? MediaQuery.of(context).size.width * 0.30
                              : MediaQuery.of(context).size.width * 0.625,
                          height: MediaQuery.of(context).size.height * 0.64,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(11, 24, 30, 0.8),
                                Color.fromRGBO(12, 27, 30, 0.5),
                              ],
                            ),
                          ),
                          duration: const Duration(milliseconds: 150),
                          child: showingResult
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 35.0,
                                        ),
                                        Text(
                                          'Results',
                                          style: TextStyle(
                                            fontFamily: Poppins.bold,
                                            color: Colors.white,
                                            fontSize: 32.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Number of umbrella(s) at home: ',
                                                style: TextStyle(
                                                  fontFamily: Poppins.regular,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                homeUmbrellas.toString(),
                                                style: TextStyle(
                                                  fontFamily: Poppins.bold,
                                                  color: Colors.white,
                                                  fontSize: 32.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 1.0,
                                          color: const Color(0xFF727272),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Number of umbrella(s) in office: ',
                                                style: TextStyle(
                                                  fontFamily: Poppins.regular,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                officeUmbrellas.toString(),
                                                style: TextStyle(
                                                  fontFamily: Poppins.bold,
                                                  color: Colors.white,
                                                  fontSize: 32.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showingResult = false;
                                                });
                                              },
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                  fontFamily: Poppins.light,
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '     |     ',
                                              style: TextStyle(
                                                fontFamily: Poppins.thin,
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  WeatherModel newWeather = WeatherModel(
                                                      day: "Day 1", isSelected: true);
                                                  sideNavList.clear();
                                                  sideNavList.add(newWeather);
                                                  selectedId = newWeather.id;
                                                  showingResult = false;
                                                });
                                              },
                                              child: Text(
                                                'Start over',
                                                style: TextStyle(
                                                  fontFamily: Poppins.light,
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 50.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 35.0, left: 70.0),
                                          child: ShakeWidget(
                                            key: _shakeKey,
                                            // 5. configure the animation parameters
                                            shakeCount: 5,
                                            shakeOffset: 10,
                                            shakeDuration:
                                                const Duration(milliseconds: 500),
                                            child: Text(
                                              'Day ${getDayNumber()} > Select Weather',
                                              style: TextStyle(
                                                fontFamily: Poppins.regular,
                                                color: hasError
                                                    ? Colors.red
                                                    : const Color(0xFF727272),
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    getSelectedWeatherWidget()
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: showingResult
                        ? MediaQuery.of(context).size.width * 0.325 / 2
                        : 0.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1875,
                    height: MediaQuery.of(context).size.height * 0.64,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(
                            fontFamily: Poppins.bold,
                            fontSize: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          getDate(),
                          style: TextStyle(
                            fontFamily: Poppins.regular,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      String newDay = 'Day ${sideNavList.length + 1}';
                      setState(() {
                        for (var item in sideNavList) {
                          item.isSelected = false;
                        }
                        sideNavList.add(WeatherModel(day: newDay, isSelected: true));
                        selectedId = sideNavList.last.id;
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent + 50.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      });
                    },
                    child: Container(
                      width: 210.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 5.0),
                              child: Text(
                                'Add more day',
                                style: TextStyle(
                                    fontFamily: Poppins.regular,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Calculate number of umbrella(s)',
                          style: TextStyle(
                            fontFamily: Poppins.regular,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              calculateNumberOfUmbrellas();
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 70.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
