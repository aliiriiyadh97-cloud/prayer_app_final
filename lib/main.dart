import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مواقيت الصلاة',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const PrayerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final baghdad = Coordinates(33.3152, 44.3661);
    final params = CalculationMethod.muslimWorldLeague().getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(baghdad, params);

    String formatTime(DateTime? time) {
      if (time == null) return '--:--';
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة - بغداد'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTile('الفجر', formatTime(prayerTimes.fajr)),
          _buildTile('الشروق', formatTime(prayerTimes.sunrise)),
          _buildTile('الظهر', formatTime(prayerTimes.dhuhr)),
          _buildTile('العصر', formatTime(prayerTimes.asr)),
          _buildTile('المغرب', formatTime(prayerTimes.maghrib)),
          _buildTile('العشاء', formatTime(prayerTimes.isha)),
        ],
      ),
    );
  }

  Widget _buildTile(String name, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        trailing: Text(time, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
