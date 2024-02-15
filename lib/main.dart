import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/home/cubit/home_view_cubit.dart';
import 'package:weather_app/presentation/bloc/home/view/home_view.dart';


void main() {
  runApp(const BlocWeatherApp());
}

class BlocWeatherApp extends StatelessWidget {
  const BlocWeatherApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create:(context)=>HomeViewCubit() ,
        child:const HomeView(),
        ),
    );
  }
}

