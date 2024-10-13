import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              color: Colors.black,
              icon: Icon(state.isFollowingUser ? Icons.directions_sharp : Icons.directions_off_rounded, color: Colors.black),
              onPressed: () => mapBloc.add(OnStartFollowingUserEvent()),
            );
          },
        ),
      ),
    );
  }
}