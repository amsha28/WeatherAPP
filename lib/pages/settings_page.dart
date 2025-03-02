import 'package:flutter/material.dart';
import 'dart:math'; // Untuk membuat prediksi cuaca dummy

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isWeatherAlertEnabled = false; // State untuk notifikasi cuaca buruk
  bool isCelsius = true; // State untuk unit suhu

  // Fungsi AI Weather Insights Dummy
  String getAIWeatherInsight() {
    List<String> insights = [
      "\u2602 Bring an umbrella, 80% chance of rain",
      "\ud83e\udde5 Wear warm clothes, today's temperature is 10\u00b0C!",
      "\ud83d\udd76\ufe0f It's sunny, don't forget to wear sunscreen!",
      "\ud83c\udf2c\ufe0f Strong winds today, be careful outside!",
      "\ud83d\udd25 High temperature today, make sure to drink plenty of water!",
    ];
    return insights[Random().nextInt(insights.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Temperature Unit \uD83C\uDF21\uFE0F'),
            subtitle: const Text('Celsius / Fahrenheit'),
            trailing: Switch(
              value: isCelsius,
              onChanged: (bool value) {
                setState(() {
                  isCelsius = value;
                });
              },
            ),
          ),
          const Divider(), // Garis pemisah
          // CUSTOM WEATHER ALERTS
          ListTile(
            title: const Text('Weather Alerts \uD83C\uDF29\uFE0F'),
            subtitle: const Text('Get Notified For Extreme Weather Conditions'),
            trailing: Switch(
              value: isWeatherAlertEnabled,
              onChanged: (bool value) {
                setState(() {
                  isWeatherAlertEnabled = value;
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Weather Alerts Enabled!')),
                    );
                  }
                });
              },
            ),
          ),
          const Divider(), // Garis pemisah
          // AI WEATHER INSIGHTS
          ListTile(
            title: const Text('AI WEATHER INSIGHTS \uD83E\uDD16'),
            subtitle: const Text('Get Smart Weather Recommendations'),
            trailing: const Icon(Icons.lightbulb_outline),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('AI WEATHER INSIGHT \uD83E\uDD16'),
                    content: Text(getAIWeatherInsight()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('ABOUT \u2139\uFE0F'),
            subtitle: const Text('View App & Developer Information'),
            trailing: const Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "WEATHER APP",
                applicationVersion: "1.0",
                applicationLegalese: "\u00a9 2025 UCA.3TI02.K9",
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      "This app provides real-time weather information based on your location. Developed with Flutter for a better experience.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
