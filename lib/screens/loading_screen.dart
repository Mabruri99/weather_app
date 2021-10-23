import 'package:flutter/material.dart';
import 'package:flutter_7/screens/location_screen.dart';
import 'package:flutter_7/services/networking.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '4ce82873983722f3156e0fee1212c7f9';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      NetworkHelper networkHelper = NetworkHelper(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');

      final weatherData = await networkHelper.getData();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => LocationScreen(
                    weatherData: weatherData,
                  )));
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('error'),
                content: Text(
                    'Please Turn on Your Internet Connection and then Location Gps'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Okay'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitSpinningLines(
        color: Colors.white,
        size: 500,
      )),
    );
  }
}
