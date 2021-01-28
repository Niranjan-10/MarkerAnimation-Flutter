import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:marker_animation/screens/map_animation.dart';
import 'package:marker_animation/screens/map_socket_.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapSocketConnection(),
    );
  }
}

class JwtTokenPayloadFetch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String yourToken =
        "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJjdUh4ZjlDM3dUWllkVDJva2d1Z0VqdFByeHpiZ0N6VmFJWTFVekdXckhBIn0.eyJleHAiOjE2MTA5NDg3OTksImlhdCI6MTYxMDk0ODYxOSwianRpIjoiZWMxNDJhOTUtNmMwMi00OWZhLThhMjQtODAzYWZiZTUzNTFmIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDkwL2F1dGgvcmVhbG1zL3Njb3JwaW91c19mbGVldCIsImF1ZCI6WyJyZWFsbS1tYW5hZ2VtZW50IiwiYWNjb3VudCJdLCJzdWIiOiI1YjYzZDkxMS1hMWExLTQwYWEtYmEzMC1hNzNjMTE4ODU3YjciLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmdib290LW1pY3Jvc2VydmljZSIsInNlc3Npb25fc3RhdGUiOiI2NDM3MzI1Zi03NjZhLTRlODYtYmI2Yy04MDEyOGMzNThlNWUiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIioiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIlJPTEVfVVNFUiIsIm9mZmxpbmVfYWNjZXNzIiwiUk9MRV9BRE1JTiIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsicmVhbG0tbWFuYWdlbWVudCI6eyJyb2xlcyI6WyJ2aWV3LXJlYWxtIiwidmlldy1pZGVudGl0eS1wcm92aWRlcnMiLCJtYW5hZ2UtaWRlbnRpdHktcHJvdmlkZXJzIiwiaW1wZXJzb25hdGlvbiIsInJlYWxtLWFkbWluIiwiY3JlYXRlLWNsaWVudCIsIm1hbmFnZS11c2VycyIsInF1ZXJ5LXJlYWxtcyIsInZpZXctYXV0aG9yaXphdGlvbiIsInF1ZXJ5LWNsaWVudHMiLCJxdWVyeS11c2VycyIsIm1hbmFnZS1ldmVudHMiLCJtYW5hZ2UtcmVhbG0iLCJ2aWV3LWV2ZW50cyIsInZpZXctdXNlcnMiLCJ2aWV3LWNsaWVudHMiLCJtYW5hZ2UtYXV0aG9yaXphdGlvbiIsIm1hbmFnZS1jbGllbnRzIiwicXVlcnktZ3JvdXBzIl19LCJzcHJpbmdib290LW1pY3Jvc2VydmljZSI6eyJyb2xlcyI6WyJST0xFX1VTRVIiLCJ1bWFfcHJvdGVjdGlvbiIsImFkbWluIiwiUk9MRV9BRE1JTiIsInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiU3JpZGhhciBQYXJpZGEiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJzcmlkaGFyIiwiZ2l2ZW5fbmFtZSI6IlNyaWRoYXIiLCJmYW1pbHlfbmFtZSI6IlBhcmlkYSIsImVtYWlsIjoic3BhcmlkYUBhc2ljemVuLmNvbSJ9.E6FQ5IWl6fLw4egUQ3fHULe6zz7edFFrfftZ8MSZ5WmCLRZMmCgF8GUssQEpSltj_3kW-FK8lGVzJNoU0RCsPmf4XWqHgxvFpTWIX6miHFF2cmkbtA3Ry35q3CUeFzilDfOPeSFi5KvvAeGjK6oBadKAlvKKNQbArzfGhQOAeJLcBNNOD9XMxPBRxvZksG9t1bCEu9kmsMuJgb-GNiCT3gIyHyKCd6qIVRfzhZ5ekrCepiX2xQd1-0HkJ24ZalZk7LeztWDp_3D6Xha_j4YrpxLq9gPuDK9frhHPoL9N76E-2rx5Z12N0VOJlfPaBiymbWh50qRp1y14jkKvCeJ_7w";
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    print(decodedToken);
    // var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(1610868011000.toString(), true);
    var date = DateTime.fromMillisecondsSinceEpoch(1610868011000);
    var format = DateFormat.yMMMEd().format(date);
    var time = TimeOfDay.fromDateTime(date);
    print(format.toString());
    print(time.hour);
    print(time.minute);

    return Scaffold(
      body: Container(),
    );
  }
}
