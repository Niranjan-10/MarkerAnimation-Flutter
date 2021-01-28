import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/lat_lng_interpolation.dart';
import 'package:flutter_animarker/models/lat_lng_delta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_animation/Model/vehicle.dart';
import 'package:marker_animation/services/google_map_services.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class MapSocketConnection extends StatefulWidget {
  @override
  _MapSocketConnectionState createState() => _MapSocketConnectionState();
}

class _MapSocketConnectionState extends State<MapSocketConnection> {

  LatLngInterpolationStream _latLngStream = LatLngInterpolationStream(
    movementDuration: Duration(milliseconds: 2000),
  );

  StreamSubscription<LatLngDelta> subscription;

  StompClient client;
  StompClient stompClient;
  Map newResult;
  double latitude;
  double longitude;
  Completer<GoogleMapController> _controller = Completer();


  LatLng initialPositin;//19.450285, 84.673330
  LatLng currentPositin;
  GoogleMapServices _googleMapsServices = GoogleMapServices();
  List<LatLng> result = <LatLng>[];
  MarkerId sourceId = MarkerId("SourcePin");
  LatLng lastPosition;
  MarkerId markerId;


  List<Vehicle> vehicleData = List<Vehicle>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  final Map<MarkerId, Marker> _markers = Map<MarkerId, Marker>();

  bool isAlreadySubscribeToVehicle = false;
  var unsubscribeFn;

  Vehicle currentVehicle;

  BitmapDescriptor pinLocationIcon;

  void createMaprker() async {
    pinLocationIcon =  await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/car_icon.png');
  }

  @override
  void initState() {
    super.initState();
    createMaprker();
    initConnect();
    addVehiclesToMap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getlastLocation(){

  }

  void initConnect() {
    client = StompClient(
        config: StompConfig(
            url: 'ws://45.114.48.150:8084/appendpoint',
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString())));

    client.activate();
  }

  dynamic onConnect(StompClient client, StompFrame frame) {
    print("socket is calling");
    stompClient = client;
    stompClient.subscribe(
        destination: '/topic/mcs',
        callback: (StompFrame frame) {
          newResult = jsonDecode(frame.body);
          var data = Vehicle.fromJson(newResult);
          print("---------------->");
          print(data.lat);
          if (vehicleData != null) {
            setState(() {
              vehicleData.removeWhere(
                  (element) => element.vehicleNumber == data.vehicleNumber);
            });
            vehicleData.add(data);
            print(vehicleData);
            addMarker(data);
          }
        });
  }

  void addVehiclesToMap() {
    print("array is --->");
    print(vehicleData);
    for (var obj in vehicleData) {
      addMarker(obj);
    }
  }

  void addMarker(Vehicle obj) async {
    var markerVal = obj.vehicleNumber;
    MarkerId markerId = MarkerId(markerVal);
    latitude = obj.lat;
    longitude = obj.lng;
    Marker marker = Marker(
        markerId: markerId,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/car_icon.png'),
        position: LatLng(obj.lat, obj.lng),
        onTap: () {
          print("clicked ----------------->");
          setState(() {
            markers.clear();
            currentVehicle = obj;
            // _addSelectedMarker();
          });
          subscribeToVehicle(obj.vehicleNumber, obj);
        });
    Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      markers[markerId] = marker;
    });


    // print(markers);
  }

  void _addSelectedMarker() async {
    print("inside add selected maker");
    var markerIdVal = currentVehicle.vehicleNumber;
    //TODO : NIRANJAN
    // final MarkerId markerId = MarkerId(markerIdVal);
    markerId = MarkerId(markerIdVal);

    latitude = currentVehicle.lat;
    longitude = currentVehicle.lng;

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(currentVehicle.lat,currentVehicle.lng),
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'assets/car_icon.png'),
      onTap: () {},
    );

    Future.delayed(Duration(seconds: 1), () async {
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 17.0)));
    });

    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      markers[markerId] = marker;
      print(markers);
    });
  }

  void unSubscribe() {
    if (isAlreadySubscribeToVehicle) {
      print("yes 1");
      unsubscribeFn(unsubscribeHeaders: {"id": "hello"});
    }
    if(subscription != null){
      print("yes 2");
      subscription.cancel();
    }
    _latLngStream = LatLngInterpolationStream(
      movementDuration: Duration(milliseconds: 2000),
    );
    print("yes 3");
    // if(result.length != 0){
    //   result.clear();
    //   print("yes 4");
    // }
  }

  void subscribeToVehicle(var vehicleNumber, Vehicle obj) {
    print("inside the subScribe funtion");
    unSubscribe();
    _addSelectedMarker();
    // subScribeSockJsCalled(vehicleNumber, obj);
    if(initialPositin == null || currentPositin == null){
      initialPositin = LatLng(obj.lat,obj.lng);
      currentPositin = LatLng(obj.lat,obj.lng);
    }
    subscribeLatLngStream();

    unsubscribeFn = stompClient.subscribe(
        destination: '/topic/' + vehicleNumber,
        callback: (StompFrame frame) {
          print("inside the stomp client");
          newResult = jsonDecode(frame.body);
          print("********************************************************************************");
          print(newResult);
          // print(jsonDecode(frame.body));
          latitude = newResult["lat"];
          longitude = newResult["lng"];
          setState(() {
            if(initialPositin != currentPositin){
              initialPositin = currentPositin;
            }
            currentPositin = LatLng(latitude,longitude);
          });
          print("initial position :$initialPositin ");
          print("current position :$currentPositin ");
          // print("longitude is $longitude and latitude is $latitude");
          setState(() {
            isAlreadySubscribeToVehicle = true;
            _updateMarker();
          });
        },
        headers: {"id": "hello"});

  }

  // void subScribeSockJsCalled(var vehicleNumber, Vehicle obj){
  //   unsubscribeFn = stompClient.subscribe(
  //       destination: '/topic/' + vehicleNumber,
  //       callback: (StompFrame frame) {
  //         print("inside the stomp client");
  //         newResult = jsonDecode(frame.body);
  //         print("********************************************************************************");
  //         print(newResult);
  //         print(jsonDecode(frame.body));
  //         latitude = newResult["lat"];
  //         longitude = newResult["lng"];
  //         print("longitude is $longitude and latitude is $latitude");
  //         setState(() {
  //           isAlreadySubscribeToVehicle = true;
  //           _updateMarker(obj);
  //         });
  //       },
  //       headers: {"id": "hello"});
  // }


  void subscribeLatLngStream(){
    print("inside subscribe latlng stream");
    subscription = _latLngStream.getLatLngInterpolation().listen((LatLngDelta delta) {
      // print("inside subscribe latlng stream 1----------------->");
      setState(() {
        //TODo :Niranjan
        Marker sourceMarker = Marker(
          // markerId: sourceId,
          markerId: markerId,
          rotation: delta.rotation+130,
          icon: pinLocationIcon,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5,0.5),
          position: LatLng(
            delta.from.latitude,
            delta.from.longitude,
          ),
        );
        // _markers[sourceId] = sourceMarker;
        //TODO: Niranjan
        // markers[sourceId] = sourceMarker;
        markers[markerId] = sourceMarker;
      });

      lastPosition = delta.to;
      Future.delayed(Duration(seconds: 5), () async {
        moveCamera(lastPosition);
      });
    });
  }

  void _updateMarker() async {
    print("Inside update  marker function");
    String route = await _googleMapsServices.getRouteCoordinate(initialPositin, currentPositin);
    _convertToLatLng(_decodePoly(route));
    updateMarkerPosition();

  }

  Future<void> updateMarkerPosition() async {
    //  Future.delayed(const Duration(milliseconds: 4000), () {
    //             _latLngStream.addLatLng(result.removeLast());
    //           });

    for (int i = 0; i < result.length - 1; i++) {
      await Future.delayed(const Duration(milliseconds: 1000));
      _latLngStream.addLatLng(result[i]);
    }

    // print(result);
  }

  List<LatLng> _convertToLatLng(List points) {
    print("inside convert latlng function");
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        //getting lat lng from array
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void moveCamera(LatLng to)async{
    // print("inside move camera function");
    GoogleMapController controller = await  _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            tilt: 0,
            target: to,
            zoom: 17.0,
          )
        )
    );
  }


  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(20.296059, 85.824539),
                zoom: 10,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _latLngStream.addLatLng(LatLng(20.296059, 85.824539));
              },
              markers: Set<Marker>.of(markers.values),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 3,
                          blurRadius: 1.5),
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 4,
                          blurRadius: 1.5),
                    ]),
                child: IconButton(
                  tooltip: "refresh",
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // setState(() {
                    //   isAlreadySubscribeToVehicle = false;
                    // });
                    unSubscribe();
                    // subscription.cancel();
                    markers.clear();
                    for (int i = 0; i < vehicleData.length; i++) {
                      addMarker(vehicleData[i]);
                    }
                    setState(() {
                      Future.delayed(Duration(seconds: 1), () async {
                        GoogleMapController controller = await _controller.future;
                        controller.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0)));
                      });
                    });


                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
