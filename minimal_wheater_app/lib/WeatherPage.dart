import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_wheater_app/Models/weather_model.dart';
import 'package:minimal_wheater_app/Services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController _textController = TextEditingController();
  String cityName = "";
//Api key
  final _weatherService = WeatherService('64c8ef441efaf94c1f2d739bd055e5f1');

  Weather? _weather;
//fetch weather
  _fetchWeather() async {
    final String queryCity =
        cityName.isNotEmpty ? cityName : await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(queryCity);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Hava durumu alınamadı: $e");
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/question.json';

    switch (mainCondition) {
      case 'Clear':
        return 'assets/clearSky.json';
      case 'Clouds':
        return 'assets/few clouds.json';
      case 'Few clouds':
        return 'assets/few clouds.json';
      case 'Scattered clouds':
        return 'assets/scatteredClouds.json';
      case 'Broken clouds':
        return 'assets/broken clouds.json';
      case 'Shower rain':
        return 'assets/rain.json';
      case 'Rain':
        return 'assets/rain.json';
      case 'Thunderstorm':
        return 'assets/thunderstorm.json';
      case 'Snow':
        return 'assets/snowy.json';
      case 'Mist':
        return 'assets/misty.json';
      default:
        return 'assets/question.json';
    }
  }

  @override
  void dispose() {
    _textController.dispose(); // Bellek sızıntısını önler
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 84, 79, 141),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              _weather?.cityName ?? "Loading City...",
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Space Grotesk',
                  color: Colors.white),
            ),
            Text(
              '${_weather?.temperature.round()} °C',
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Space Grotesk',
                  color: Colors.white),
            ),
            Text('${_weather?.mainCondition}',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Space Grotesk',
                    color: const Color.fromARGB(255, 202, 202, 202))),
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition ?? ""),
              width: 200, // Genişliği artır
              height: 200, // Yüksekliği artır
              fit: BoxFit.cover, // Tüm alanı kaplasın
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: "Search City",
                    hintText: "Searhc Here",
                    labelStyle: TextStyle(
                        fontFamily: 'Space Grotesk',
                        color: Colors.white), // Label yazısını beyaz yap
                    hintStyle: TextStyle(
                        fontFamily: 'Space Grotesk',
                        color: Colors.white70), // Placeholder rengini beyaz yap

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.white, width: 2), // Kenarları beyaz yap
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.white, width: 2), // Normalde beyaz
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 3), // Odaklanınca beyaz kalın
                    ),
                  ),
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Space Grotesk'),
                  onChanged: (value) {
                    setState(() {
                      cityName =
                          value; // Kullanıcının girdiği şehir adı değişkenine atanıyor
                    });
                  } // Kullanıcının yazdığı metni beyaz yap
                  ),
            ),
            ElevatedButton(
              onPressed: _fetchWeather,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15), // Butonun boyutunu artır
                backgroundColor: Colors.white, // Arkaplan rengini beyaz yap
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Yuvarlak kenarlar
                ),
                elevation: 5, // Gölgelendirme efekti ekle
              ),
              child: Text(
                "Update",
                style: TextStyle(
                  fontSize: 20, // Yazıyı büyüt
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Yazı rengini siyah yap
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
