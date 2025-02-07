import 'package:flutter/material.dart';
import 'package:minimal_wheater_app/WeatherPage.dart';

/*

 -> stl kısaltma var. 
 final keyword olunca initialize edilmesi lazım her zaman.
-> setState ile ui içerisinde güncellenmesini istediklerimiz güncelleriz. 
@State gibi  her değişkenin başına yazarız ya onun gibi düşün
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
