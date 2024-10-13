import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class BtnUserRoute extends StatelessWidget {
  const BtnUserRoute({super.key});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.roundabout_left_rounded),
          onPressed: () {
            mapBloc.add(OnToggleUserRoute());
          } 
        ),
      ),
    );
  }
}