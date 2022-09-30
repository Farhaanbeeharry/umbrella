import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:umbrella/common/Poppins.font.dart';
import 'package:umbrella/models/side_nav_day_model.dart';
import 'package:umbrella/widgets/side_nav_day_widget.dart';

class HomepageWeb extends StatefulWidget {
  const HomepageWeb({Key? key}) : super(key: key);

  @override
  State<HomepageWeb> createState() => _HomepageWebState();
}

class _HomepageWebState extends State<HomepageWeb> {
  late String selectedId;
  List<SideNavDayModel> sideNavWidgetList = [
    SideNavDayModel(day: "Day 1", isSelected: true)
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    selectedId = sideNavWidgetList.first.id;
    super.initState();
  }

  onClick(SideNavDayModel data) {
    setState(() {
      selectedId = data.id;
      for (var item in sideNavWidgetList) {
        item.isSelected = item.id == selectedId;
      }
    });
  }

  onDelete(int index, SideNavDayModel data) {
    setState(() {
      if (data.id == selectedId) {
        if (index == 0) {
          onClick(sideNavWidgetList[index + 1]);
        } else {
          onClick(sideNavWidgetList[index - 1]);
        }
      }
      sideNavWidgetList.removeAt(index);
    });
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
                  SizedBox(
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
                              children: sideNavWidgetList
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => SideNavDayWidget(
                                        index: e.key,
                                        listSize: sideNavWidgetList.length,
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
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.625,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1875,
                    height: MediaQuery.of(context).size.height * 0.64,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '04:02',
                          style: TextStyle(
                            fontFamily: Poppins.bold,
                            fontSize: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '29 Sep 2022',
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
                      String newDay = 'Day ${sideNavWidgetList.length + 1}';
                      setState(() {
                        for (var item in sideNavWidgetList) {
                          item.isSelected = false;
                        }
                        sideNavWidgetList
                            .add(SideNavDayModel(day: newDay, isSelected: true));
                        selectedId = sideNavWidgetList.last.id;
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent + 50.0,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);
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
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            borderOnForeground: true,
                            child: InkWell(
                              splashColor: const Color(0xff91001e),
                              onTap: () {},
                              child: const SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.menu,
                                ),
                              ),
                            ),
                          ),
                        )
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
