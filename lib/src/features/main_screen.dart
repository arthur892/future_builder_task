import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: initiate controllers
  }

  TextEditingController searchZip = TextEditingController();
  Future<String>? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: searchZip,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Postleitzahl"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      cityName = getCityFromZip(searchZip.text);
                    });
                  },
                  child: const Text("Suche"),
                ),
                const SizedBox(height: 32),
                FutureBuilder(
                  future: cityName,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Error");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return Text(
                          "Suche nach ${searchZip.text}: ${snapshot.data}",
                          style: Theme.of(context).textTheme.labelLarge);
                    }
                    return Text("Noch keine PLZ gesucht",
                        style: Theme.of(context).textTheme.labelLarge);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: dispose controllers
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
