import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1Ijoiam9hY29jYXJlbmEiLCJhIjoiY20wYjN1b2hoMDR0cTJrcHRhcHR6ajA5eSJ9.W7__Scr8vnaunOAcxcpdoA';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      /*'alternatives': true,
      'geometries': 'polyline6',
      'language': 'es',
      'overview': 'full',
      'steps': true,
      'voice_instructions': true,
      'voice_units': 'metric',*/
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}