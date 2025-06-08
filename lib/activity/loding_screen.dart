import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/api_services.dart';
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? temp;
  String? hum;
  String? desc;
  String? air_speed;
  String? main;
  String ? icon;
  String ? city_name;

  void startapp(String? city_name) async {
    Api_Services instance = Api_Services(location:city_name, cityname: 'Jaipur');
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    desc = instance.description;
    air_speed = instance.airSpeed;
    main = instance.main;
    icon=instance.icon;
    city_name=instance.cityname;
    Future.delayed(const Duration(seconds:4),(){

      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'temp_value': temp,
        "hum_value": hum,
        "Air_speed_value": air_speed,
        "desc_value": desc,
        "main_value": main,
        "icon_value":icon,
        "city_value":city_name
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final search = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};

    if (search.isNotEmpty && search["searchtext"] != null) {
      city_name = search["searchtext"];
    }

    startapp(city_name);
    return Scaffold(
      backgroundColor: Colors.indigoAccent.shade200,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset("images/logo.png"),
                const Text("Nature Mausam",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight:FontWeight.bold),),
                const Text("by Balram Singh"),
                const SizedBox(
                  height: 20,
                ),
                const SpinKitChasingDots(
              color: Colors.red,
              size: 80.0,
            ),
              ],
            ),
    );
  }
}
