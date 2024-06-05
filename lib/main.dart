import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

enum Cities {
  montreal,
  toronto,
  halifax,
  calgary,
}

// List<String> weather = ['French Fries', 'Sunny', 'Windy', 'Snowy'];

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Weather',
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {

        },
        child: ListView.builder(
          itemCount: Cities.values.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                Cities.values[index].toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}
