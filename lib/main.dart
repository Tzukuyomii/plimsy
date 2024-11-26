import 'package:flutter/material.dart';
import 'package:plimsy/screens/login.dart';

import 'package:flutter/foundation.dart';

void main() {
  if (kReleaseMode) {
    print("L'app è in modalità Release");
  } else if (kProfileMode) {
    print("L'app è in modalità Profile");
  } else if (kDebugMode) {
    print("L'app è in modalità Debug");
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppLifecycleObserver(),
    );
  }
}

class MyAppLifecycleObserver extends StatefulWidget {
  @override
  _MyAppLifecycleObserverState createState() => _MyAppLifecycleObserverState();
}

class _MyAppLifecycleObserverState extends State<MyAppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Registriamo l'osservatore per il ciclo di vita
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Rimuoviamo l'osservatore quando il widget è distrutto
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      // L'app è andata in background
      print("App in background");
      // Aggiungi operazioni da eseguire quando l'app è in background
    } else if (state == AppLifecycleState.resumed) {
      // L'app è tornata in primo piano
      print("App in primo piano");
      // Aggiungi operazioni da eseguire quando l'app ritorna in primo piano
    } else if (state == AppLifecycleState.detached) {
      // L'app è stata chiusa o uccisa
      print("App è stata chiusa");
      const LoginScreen();
      // Esegui operazioni di cleanup o di salvataggio, se necessario
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen(); // Il tuo widget principale
  }
}
