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
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

enum Cities {
  montreal,
  toronto,
  halifax,
  calgary,
}

Future<String> getCityWeather(Cities city) {
  return Future.delayed(
    const Duration(
      seconds: 5,
    ),
        () =>
    {
      Cities.montreal: 'French',
      Cities.toronto: 'Sunny',
      Cities.halifax: 'Windy',
      Cities.calgary: 'Snowy',
    }[city] ??
        '404',
  );
}

final currentCityProvider = StateProvider<Cities?>((ref) => null);

final currentWeatherProvider = FutureProvider<String>(
      (ref) {
    var city = ref.watch(currentCityProvider);
    if (city != null) {
      return getCityWeather(city);
    } else {
      return '404';
    }
  },
);

class MyHomePage extends ConsumerWidget {
   const MyHomePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(currentWeatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Weather',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                return const Text('Select a city');
              },
            ),
          ),
          weather.when(
            data: (String data) => Text(data),
            error: (error, stackTrace) => const Text('404'),
            loading: () => const CircularProgressIndicator(),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: Cities.values.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    Cities.values[index].toString(),
                  ),
                  onTap: () {
                    ref
                        .watch(currentCityProvider.notifier)
                        .state =
                    Cities.values[index];
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
