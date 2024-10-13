import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/ui/ui.dart';

import '../blocs/blocs.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {

    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.my_location_rounded),
          onPressed: () {
            
            final userLoc = locationBloc.state.lastKnownPosition;

            if (userLoc == null) {
              final snackToUse = CustomSnackbar(msg: 'No location found'); 
              ScaffoldMessenger.of(context).showSnackBar(snackToUse);
              return;
            }

            mapBloc.moveCamera(userLoc);

          },
        ),
      ),
    );
  }
}