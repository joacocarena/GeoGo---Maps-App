import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarkerSTART() async {
  return await BitmapDescriptor.asset(
    const ImageConfiguration(
      devicePixelRatio: 2.5
    ), 
    'assets/custom-pin.png'
  ); 
}

Future<BitmapDescriptor> getAssetImageMarkerEND() async {
  final resp = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(responseType: ResponseType.bytes)
  );

  final imageCodec = await ui.instantiateImageCodec(resp.data, targetHeight: 150, targetWidth: 150);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  if (data == null) return BitmapDescriptor.defaultMarker;

  return BitmapDescriptor.bytes(data.buffer.asUint8List());
}