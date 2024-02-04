import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String welcomeMessage(int hours) {
    if (hours >= 1 && hours <= 12) {
      return "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      return "Good Afternoon";
    } else if (hours >= 16 && hours <= 19) {
      return "Good Evening";
    } else if (hours >= 19 && hours <= 24) {
      return "Good Night";
    } else {
      return "Welcome";
    }
  }

  Widget getWeatherIcons(int weatherCode, double height, double width) {
    switch (weatherCode) {
      case > 200 && <= 300:
        return Image.asset(
          'assets/thunder.png',
          height: height,
          width: width,
        );
      case >= 300 && < 400:
        return Image.asset(
          'assets/rain.png',
          height: height,
          width: width,
        );
      case >= 500 && < 600:
        return Image.asset(
          'assets/heavyrain.png',
          height: height,
          width: width,
        );
      case >= 600 && < 700:
        return Image.asset(
          'assets/snow.png',
          height: height,
          width: width,
        );
      case >= 700 && < 800:
        return Image.asset(
          'assets/dizzy.png',
          height: height,
          width: width,
        );
      case == 800:
        return Image.asset(
          'assets/sunny.png',
          height: height,
          width: width,
        );
      case > 800 && <= 804:
        return Image.asset(
          'assets/lightcloudy.png',
          height: height,
          width: width,
        );
      default:
        return Image.asset(
          'assets/lightcloudy.png',
          height: height,
          width: width,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaData = MediaQuery.of(context);
    final height = (mediaData.size.height) / 100;
    final width = (mediaData.size.width) / 100;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 1.2 * kToolbarHeight, 30, 20),
        child: SizedBox(
          // height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.orangeAccent),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSuccess) {
                    return Container(
                      color: Colors.transparent,
                      // width: width * 100,
                      // height: height * 100,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 8,
                            width: width * 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '📍 ${state.weather.areaName}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 1.7,
                                      fontWeight: FontWeight.w300),
                                ),
                                // const SizedBox(height: 8,),
                                Text(
                                  welcomeMessage(DateTime.now().hour)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 2.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          getWeatherIcons(state.weather.weatherConditionCode!,
                              height * 35, width * 100),
                          SizedBox(
                            height: height * 8,
                            child: Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 4,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 1,
                          ),
                          SizedBox(
                            height: height * 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                  child: Text(
                                    state.weather.weatherMain!.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 2.5,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                // const SizedBox(height: 5,),
                                Center(
                                  child: Text(
                                    DateFormat('EEEE dd *')
                                        .add_jm()
                                        .format(state.weather.date!),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 2,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 2.5,
                          ),
                          SizedBox(
                            height: height * 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/day.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: width * 2,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunrise',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: height * 1.6),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          style: TextStyle(
                                              fontSize: height * 1.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/night.png',
                                          scale: 8,
                                        ),
                                        SizedBox(
                                          width: width * 2,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Sunset',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: height * 1.6),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              DateFormat().add_jm().format(
                                                  state.weather.sunset!),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: height * 1.5),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 3,
                            child: Divider(
                              color: Colors.grey.shade800,
                              thickness: 1,
                            ),
                          ),
                          SizedBox(
                            height: height * 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/maxtemp.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: width * 1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Temp Max',
                                          style: TextStyle(
                                              fontSize: height * 1.6,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${state.weather.tempMax!.celsius!.round()}°C',
                                          style: TextStyle(
                                              fontSize: height * 1.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/mintemp.png',
                                          scale: 8,
                                        ),
                                        SizedBox(
                                          width: width * 1,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Temp Min',
                                              style: TextStyle(
                                                  fontSize: height * 1.6,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              '${state.weather.tempMin!.celsius!.round()}°C',
                                              style: TextStyle(
                                                  fontSize: height * 1.5,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
