import 'dart:js';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getSiguiente() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("algo");
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            BigCard(idea: appState.current),
            SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: () {
                  appState.getSiguiente();
                },
                child: Text("Siguiente"))
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final WordPair idea;

  const BigCard({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final TextStyle = tema.textTheme.displayMedium!
        .copyWith(color: tema.colorScheme.onPrimary);

    return Card(
      color: tema.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          idea.asLowerCase, 
          style: TextStyle ,
          semanticsLabel: "${idea.first} ${idea.second}",
        )
      ),
    );
  }
}
