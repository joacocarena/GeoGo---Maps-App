import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/helpers/helpers.dart';

import '../blocs/blocs.dart';

class SettedMarker extends StatelessWidget {
  const SettedMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualSettedMarker 
          ? const _SettedMarkerBody() 
          : const SizedBox(); //SizedBox is faster than Container
      }
    );
  }
}

class _SettedMarkerBody extends StatelessWidget {
  const _SettedMarkerBody();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [

          const Positioned(
            top: 70,
            left: 20,
            child: _BackBtn()
          ),

          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: const Icon(Icons.location_on, size: 55)
              ),
            ),
          ),

          Positioned(
            bottom: 60,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 350),
              child: MaterialButton(
                minWidth: size.width-120,
                color: Colors.black,
                elevation: 0,
                height: 45,
                shape: const StadiumBorder(),
                child: const Text('Confirm direction', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                onPressed: () async {
                  
                  final start = locationBloc.state.lastKnownPosition;
                  if (start == null) return;
                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  showLoadingMessage(context);

                  final location = await searchBloc.getTripCoords(start, end);
                  await mapBloc.createRoutePolyline(location);
                  searchBloc.add(OnManualMarkerDesactivatedEvent()); // remove ConfirmBtn and BackBtn when location confirmed
                  
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              ),
            )
          )

        ],
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn();

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () => BlocProvider.of<SearchBloc>(context).add(OnManualMarkerDesactivatedEvent()),
        ),
      ),
    );
  }
}