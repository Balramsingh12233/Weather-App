import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cityNames = ["Mumbai", "Jaipur", "Kanpur", "London"];
    final random = Random();
    var randomCity = cityNames[random.nextInt(cityNames.length)];

    final info = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};

    String temp = (info["temp_value"] ?? "N/A").toString();
    String airSpeed = (info["Air_speed_value"] ?? "N/A").toString();
    String humidity = (info["hum_value"] ?? "N/A").toString();
    String icon = (info["icon_value"] ?? "01d").toString();
    String cityName = (info["city_value"] ?? "Unknown").toString();
    String desc = (info["desc_value"] ?? "No description").toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search $randomCity",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.deepPurpleAccent),
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          Navigator.pushNamed(context, "/Loading", arguments: {
                            "searchtext": searchController.text,
                          });
                        }
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              weatherInfoCard(cityName, desc, icon),
              temperatureCard(temp),
              additionalInfoRow(airSpeed, humidity),
              const SizedBox(height: 20),
              const Text('Developed by Balram Singh', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget weatherInfoCard(String city, String desc, String icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/$icon@2x.png',
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported, size: 70, color: Colors.grey),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(desc, style: const TextStyle(fontSize: 16)),
              Text('In $city', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget temperatureCard(String temp) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Column(
        children: [
          const Icon(WeatherIcons.thermometer, size: 60, color: Colors.yellow),
          const SizedBox(height: 10),
          const Text('Temperature', style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(temp, style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
              const Text("°C", style: TextStyle(fontSize: 30)),
            ],
          ),
        ],
      ),
    );
  }

  Widget additionalInfoRow(String airSpeed, String humidity) {
    return Row(
      children: [
        Expanded(
          child: infoCard("Wind Speed", airSpeed, WeatherIcons.wind),
        ),
        Expanded(
          child: infoCard("Humidity", humidity, WeatherIcons.humidity),
        ),
      ],
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.black),
          const SizedBox(height: 5),
          Text("$value%", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
