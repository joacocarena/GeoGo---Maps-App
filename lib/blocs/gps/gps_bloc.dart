import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription; // suscription to GPS Service

  GpsBloc() : super(const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {
    
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      isGpsEnabled: event.isGpsEnabled,
      isGpsPermissionGranted: event.isGpsPermissionGranted
    )));
  
    _init();

  }

  // methods to initialize geolocator:
  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([_checkGpsStatus(), _isPermissionGranted()]);

    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0], 
      isGpsPermissionGranted: gpsInitStatus[1]
    ));
  }

  // method to obtain if location permission is granted or not:
  Future<bool> _isPermissionGranted() async {
    return await Permission.location.isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) { // initializing the suscription to the GPS Service
      final isEnabled = (event.index == 1) ? true : false;
      
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled, 
        isGpsPermissionGranted: state.isGpsPermissionGranted
      ));
    
    });
    
    return isEnable;
  }

  // method to request GPS access by tapping the button (gps_access_screen.dart)
  Future<void> requestGpsAccess() async {

    final status = await Permission.location.request(); // requesting permission to the GPS

    switch (status) {
      case PermissionStatus.granted: // when permission is granted
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings(); // this will open the phone settings (method from permission_handler)
        break;
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel(); // deleting the suscription
    return super.close();
  }
}