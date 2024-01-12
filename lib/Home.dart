import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http ;
import 'package:google_fonts/google_fonts.dart';
class HomeP extends StatefulWidget {
  const HomeP({super.key});

  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
 double tempCelsius = 0.0; // Initialize with a default value
  double tempFahrenheit = 0.0;// Temperature in Fahrenheit
  var description='.';
  var currently='.';
  int humidity=0;
  double windSpeed=0;
  var cityname='.';
  double feels_like=0;
  double feels_likef=0;
  double temp_max=0;
  double temp_maxf=0;
  double temp_min=0;
  double temp_minf=0;
  int pressure=0;
  int visibility=0;
  var country;
 // Define a mapping between weather conditions and image asset paths
  Map<String, String> weatherConditionToIcon = {
    'Clear': 'assets/images/clear.png',
    'Clouds': 'assets/images/clouds.png',
    'Rain': 'assets/images/rain.png',
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

    double temperatureKelvin = results['main']['temp'];
    this.tempCelsius = kelvinToCelsius(temperatureKelvin);
    this.tempFahrenheit = kelvinToFahrenheit(temperatureKelvin);
  
  double feelsKelvin = results['main']['feels_like'];
    this.feels_like = kelvinToCelsius(feelsKelvin);
    this.feels_likef = kelvinToFahrenheit(feelsKelvin);
  
   double HKelvin = results['main']['temp_max'];
    this.temp_max = kelvinToCelsius(HKelvin);
    this.temp_maxf= kelvinToFahrenheit(HKelvin);

 double LKelvin = results['main']['temp_min'];
    this.temp_min = kelvinToCelsius(LKelvin);
    this.temp_minf= kelvinToFahrenheit(LKelvin);

double speed=results['wind']['speed'];
this.windSpeed=mstokm(speed);

int visibility=results['visibility'];
this.visibility=mtokm(visibility);

    setState(() {
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
    //  this.windSpeed = results['wind']['speed'];
      this.cityname = results['name'];
     //this.visibility=results['visibility'];
     this.pressure = results['main']['pressure'];
     this.country =results['sys']['country'];
    });
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double kelvinToFahrenheit(double kelvin) {
    return (kelvin - 273.15) * 9/5 + 32;
  }
   double mstokm(double ms){
    return ms * 3.6;
   }
   int mtokm (int m){
    return m ~/1000;
   }
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255,118,156,236),
body:SingleChildScrollView(child: 
 Stack(children: [
  Positioned(
    top: 60,
    left: 10,
    child: Icon(Icons.map,size: 25,color: Colors.white,)),
    Positioned(
      top: 60,
      left: 350,
      child: Icon(Icons.menu,size: 25,color: Colors.white,)),
      Container(
margin: EdgeInsets.only(top: 60),
       child:Center(
      child: Text('$cityname',style:GoogleFonts.ubuntu(fontSize:25,color:Colors.white,fontWeight: FontWeight.w500))
         //TextStyle(fontSize:30,color: Colors.white,fontWeight: FontWeight.bold),
         )
         ),
         Container(
          margin: EdgeInsets.only(top: 150,left:130),
           
          child: Image.asset('assets/images/icon2.png')),
         Container(
            margin: EdgeInsets.only( top: 300),
           child:Center(
            child: Text('$currently',style:GoogleFonts.ubuntu(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold))
           )  ),
            Container(
              margin: EdgeInsets.only(top: 335),
             child:Center(
              child: Text('${tempCelsius.round()}°',style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold,color:Colors.white),))),
                Container(
                margin: EdgeInsets.only(top: 420),
              child:Center( 
                child: Text('$description',style: TextStyle(fontSize: 20,color: Colors.white),))),
             Container(
                  margin: EdgeInsets.only(top:460,left: 20),
                height: 350,
                width: 355,
                decoration: BoxDecoration(
                  color: Color.fromARGB(158, 46, 81, 157),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                )),
                
                Positioned(
                  top:470,
                  left: 30,
                child:Text('Feels Like: ${feels_like.round()}°C ',style:TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold))),
              
              Positioned(
                top: 520,
                left: 30,
                child: Text('H: ${temp_max.round()}°C',style: TextStyle(fontSize:25 ,color:Colors.white,fontWeight: FontWeight.bold),),),
                Positioned(
                  top:520 ,
                  left: 150,
                  child: Text('L: ${temp_min.round()}°C',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white),)),
                 Positioned(
                  top:570,
                  left: 30,
                  child: Text('Wind Speed: ${windSpeed.round()}km/h',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),),
              Positioned(
                top: 620,
                left: 30,
                child: Text('Humidity: ${humidity}%',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
                Positioned(
                  top: 670,
                  left: 30,
                  child: Text('Pressure: ${pressure}hpa',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))),
                    Positioned(
                  top: 720,
                  left: 30,
                  child: Text('Visibility: ${visibility}km/h',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))),
                    Positioned(
                  top: 770,
                  left: 30,
                  child: Text('Country: $country',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))),
                  
                  Container(
                    margin: EdgeInsets.only(top: 830),
                    
                    child: Center(child:
                  Text('Weather data provided by OpenWeatherMap',
    style: TextStyle(fontSize: 12, color: Colors.white))))
             // Container(
              //margin: EdgeInsets.only(top: 650,left:20),
               // height: 300,
                //width: 355,
            //    decoration: BoxDecoration(
              //    color: Color.fromARGB(158, 46, 81, 157),
             //     borderRadius: BorderRadius.all(Radius.circular(15))
         //       ),
           //   )
],),)

    );
  }
}