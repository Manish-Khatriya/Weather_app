import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import '../Worker/worker.dart';
import 'package:permission_handler/permission_handler.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String city = "Indore";
  late String temp;
  late String hum;
  late String air_speed;
  late String desc;
  late String main;
  late String icon;


  void startApp(String city) async{
    Worker instance = Worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    desc = instance.decsription;
    main = instance.main;
    icon = instance.icon;


    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return; // Prevents error if widget is disposed

      Navigator.pushReplacementNamed(context, "/home", arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "desc_value": desc,
        "main_value": main,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }
  Future<void> saveToFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.txt');
    await file.writeAsString('Hello Manish!');
    print("File saved at: ${file.path}");
  }
  Future<void> requestStoragePermission() async {
    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    requestStoragePermission().then((_) {
      saveToFile();
      startApp(city);  // 👈 Only run API after permissions
    });
  }



  @override
  Widget build(BuildContext context) {

    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    if(search?.isNotEmpty ?? false){
      city = search?["searchCity"];
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,),
              Image.asset("assets/images/mlogo.png",height: 240,width: 240,),
              Text("Mausam App",
                style: TextStyle(
                    fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white),),
              SizedBox(height: 10,),
              Text("Made By Manish",
                style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.w400,color: Colors.white),),
          SizedBox(height: 30,),
          SpinKitWave(
            color: Colors.white,
            size: 50.0,
          )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade300,
    );
  }
}
