import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return !state.isGpsEnabled
                  ? const _EnableGPSMessage()
                  : const _AccessButton();
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('GPS Access must be provided', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300)),
        MaterialButton(
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          child: const Text('Request Access', style: TextStyle(color: Colors.white)),
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.requestGpsAccess(); // llamo al metodo
          }
        )
      ],
    );
  }
}

class _EnableGPSMessage extends StatelessWidget {
  const _EnableGPSMessage();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'GPS must be activated',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}