import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/presentation/bloc/city/view/city_view.dart';
import 'package:weather_app/presentation/bloc/home/cubit/home_view_cubit.dart';
import 'package:weather_app/presentation/bloc/home/cubit/home_view_cubit_state.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          child: BlocBuilder<HomeViewCubit, HomeViewCubitState>(
            builder: (context, state) {
              if (state is HomeViewCubitInitial) {
                return _progressIndicator();
              } else if (state is HomeViewCubitError) {
                return _error(state);
              } else {
                return _contentWithData(context, state as HomeViewCubitSuccess);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _progressIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.white,
    ));
  }

  Widget _error(HomeViewCubitError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Code: ${state.statusCode}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Error: ${state.error}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentWithData(BuildContext context, HomeViewCubitSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 18.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () async {
                  await context.read<HomeViewCubit>().getWeatherByLocation();
                },
                icon: SvgPicture.asset(
                  'assets/vectors/geo.svg',
                  height: 45,
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
                label: const SizedBox(),
              ),
              TextButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return BlocProvider<HomeViewCubit>.value(
                        value: BlocProvider.of<HomeViewCubit>(context),
                        child: const CityView(),
                      );
                    }),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/vectors/city.svg',
                  height: 45,
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
                label: const SizedBox(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            state.weatherModel.main?.temp?.toStringAsFixed(2) ?? 'N/A',
            style: const TextStyle(
              fontSize: 56,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 40,
          ),
          child: Text(
            state.weatherModel.weather?[0].description ?? 'Description',
            style: const TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}