import 'dart:convert';
import 'package:http/http.dart' as http;

class Api_Services {
  String? location; // Location name
  String? temp;
  String? airSpeed;
  String? humidity;
  String? description;
  String? main;
  String? icon;
  String ? cityname;

//Constructor
  Api_Services({required this.cityname, String? location});

  //Method
  Future<void> getData() async {
    try {
      if (cityname == null || cityname!.isEmpty) {
        throw Exception("Location is required.");
      }

      String apiKey = "ce75828b18247f814f744eb8f8ec165a"; // Your API key
      String url = "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey&units=metric";

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        print(data);
        // Get temperature and humidity
        Map<String, dynamic>? tempData = data['main'];
        if (tempData != null) {
          temp = tempData['temp'].toString();
          humidity = tempData['humidity'].toString();
        }

        // Get wind speed
        Map<String, dynamic>? windData = data['wind'];
        if (windData != null) {
          airSpeed = windData['speed'].toString();
        }

        // Get weather description
        List<dynamic>? weatherList = data['weather'];
        if (weatherList != null && weatherList.isNotEmpty) {
          Map<String, dynamic> weatherMainData = weatherList[0];
          main = weatherMainData['main'];
          description = weatherMainData['description'];
          icon=weatherMainData['icon'].toString();
        }
      } else {
        throw Exception("Failed to fetch weather data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      temp = "No data";
      humidity = "No data found";
      airSpeed =  "No data found";
      main = "No data found";
      description ="No data found";
      icon="04d";
      cityname="Enter city name";
    }
  }
}
