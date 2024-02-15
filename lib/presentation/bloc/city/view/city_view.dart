import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/home/cubit/home_view_cubit.dart';

class CityView extends StatefulWidget {
  const CityView({super.key});

  @override
  State<CityView> createState() => _CityViewState();
}

class _CityViewState extends State<CityView> {
  final TextEditingController _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/city.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context, '');
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: const SizedBox(),
                  ),
                  const Text(
                    'City',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(width: 60),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: TextField(
                        controller: _textController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: const InputDecoration(
                          focusColor: Colors.white,
                          hintText: 'write your city',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          // labelText: 'Password',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_textController.text.isEmpty) {
                          const snackBar = SnackBar(
                            content: Column(
                              children: [
                                Text('Attention!'),
                                Text('You haven\'t put any city'),
                              ],
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          await context.read<HomeViewCubit>().getWeatherByCity(_textController.text);
                          if (!mounted) return;
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('show weather'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}