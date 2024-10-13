import 'package:dio/dio.dart';

const String accesToken = 'pk.eyJ1Ijoiam9hY29jYXJlbmEiLCJhIjoiY20wYjN1b2hoMDR0cTJrcHRhcHR6ajA5eSJ9.W7__Scr8vnaunOAcxcpdoA';

class PlacesInterceptor extends Interceptor {
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': accesToken,
      'language': 'es,en',
    });
    super.onRequest(options, handler);
  }

}