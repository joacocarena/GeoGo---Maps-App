import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/screens/screens.dart';

import '../blocs/blocs.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted // if gps and permissions OK, then:
            ? const MapScreen() // show MapScreen (home)
            : const GpsAccessScreen(); // else, show GpsAccessScreen
        },
      )
   );
  }
}