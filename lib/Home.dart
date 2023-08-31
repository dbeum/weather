import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var cityName;

  // Define a mapping between weather conditions and image asset paths
  Map<String, String> weatherConditionToIcon = {
    'Clear': 'assets/clear.png',
    'Clouds': 'assets/images/clouds.png',
    'Rain': 'assets/rain.png',
    // Add more weather conditions and image paths
  };
  Future getWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Handle the case when the user denies the permission
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Fetch weather data based on the current location
    var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=958a8cc7b5f973c4cc23ef8b1d1a623c',
    );
    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    print("Data from API: $results");

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.cityName = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    // Get the image asset path based on the current weather condition
    String weatherIconPath = weatherConditionToIcon[currently] ?? '';
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(100, 57, 152, 189),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                cityName != null
                    ? 'Currently in $cityName' // Use the cityName variable
                    : "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(temp != null ? temp.toString() + "\u00B0" : "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  currently != null ? currently.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            //adds images
            if (weatherIconPath.isNotEmpty)
              Image.asset(
                weatherIconPath,
                width: 50, // Adjust the size as needed
                height: 50,
              ),
          ]),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometer),
                      title: Text(
                        "Temperature",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u00B0"
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(description != null
                          ? description.toString()
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Humidity",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                          humidity != null ? humidity.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "Loading",
                      ),
                    )
                  ],
                )))
      ],
    ));
  }
}
