import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   super.initState();
  //   print("This is init state");
  // }
  //
  // @override
  // void setState(fn) {
  //   super.setState(fn);
  //   print("Set state called");
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   print("Widget Destroyed");
  // }

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    var city_name = ["Mumbai", "Delhi", "Chennai", "Dhar", "Indore", "London"];
    final _random = Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    String air = ((info?["air_speed_value"]).toString());
    String temp = (((info?["temp_value"]).toString()));

    if(temp == "NA"){

      print("NA");
    }else
      {
        temp = (((info?["temp_value"]).toString()).substring(0,4));
        air = (((info?["air_speed_value"]).toString()).substring(0,4));
      }
    String icon = (info?["icon_value"]).toString();
    String getcity = info?["city_value"];

    String des = info?["desc_value"];
    String hum = info?["hum_value"];


    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade500, Colors.blue.shade400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Text(
                'Mausam App',
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade600, Colors.blue.shade300],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if((searchController.text).replaceAll("  ", "") == ""){
                              print("blank search");
                            }else {
                              Navigator.pushReplacementNamed(
                                  context, "/loading", arguments: {
                                "searchCity": searchController.text.toString(),
                              });
                            }
        
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://openweathermap.org/img/wn/${icon}@2x.png",
                              ),
                              SizedBox(width: 20), // spacing between image and text
                              Expanded( // This avoids overflow
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$des",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "In $getcity",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
        
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(WeatherIcons.thermometer),
                                  SizedBox(width: 25,),
                                  Text("Temperature",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w700),)
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$temp",style: TextStyle(fontSize: 90),),
                                  Text("C",style: TextStyle(fontSize: 30),)
                                ],
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.day_windy),
                                  SizedBox(width: 25,),
                                  Text("Air Speed",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              SizedBox(height: 30,)
                              ,
                              Text("$air",style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("km/hr")
                            ],
                          ),
                          height: 190,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: EdgeInsets.all(26),
                          height: 190,
                          child:  Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                  SizedBox(width: 21,),
                                  Text("Humidity",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              SizedBox(height: 30,)
                              ,
                              Text("$hum",style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("Percent")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.only(top: 4,bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Made By Manish"),
                        Text("Data Provided By Openweathermap.org"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
