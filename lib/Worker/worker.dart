import 'dart:convert';
import 'package:http/http.dart';

class Worker{

  late String location;

  Worker({required this.location}){
    location = this.location;

  }



  late String temp;
  late String humidity;
  late String air_speed;
  late String decsription;
  late String main;
  late String icon;

  Future<void> getData() async{

    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=2cad37c006e81203df7156091ef9b892"));

      Map data = jsonDecode(response.body);

      String getLocation = data["name"];

      Map data_main = data["main"];
      double getTemp = data_main["temp"] - 273.15;  // C
      int getHumidity = data_main["humidity"];    // %

      Map data_wind = data["wind"];
      double getAir_speed = data_wind["speed"]/0.27777777777778;  //km/hr

      List data_weather = data["weather"];
      Map data_weather_list = data_weather[0];
      String getDescription = data_weather_list["description"];
      String getMain = data_weather_list["main"];
      // String getIcon = data_weather_list["icon"].toString();


      temp = getTemp.toString();
      humidity = getHumidity.toString();
      air_speed = getAir_speed.toString();
      decsription = getDescription;
      main = getMain;
      location = getLocation;
      icon = data_weather_list["icon"].toString();



    }catch(e){
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      decsription = "Can't Find Data";
      main = "NA";
      location = "NA";
      icon = "09d";
    }


  }

}