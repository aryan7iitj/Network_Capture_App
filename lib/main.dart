// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:location/location.dart';
import 'package:sensors_plus/sensors_plus.dart';

class NetworkCaptureApp extends StatefulWidget {
  @override
  _NetworkCaptureAppState createState() => _NetworkCaptureAppState();
}

class _NetworkCaptureAppState extends State<NetworkCaptureApp> {
  String carrierName = '';
  String rsrp = '';
  String rsrq = '';
  String cqi = '';
  String sinr = '';
  String taDistance = '';
  String latitude = '';
  String longitude = '';
  String height = '';
  String magneticData = '';
  String directionData = '';
  String pingSpeed = '';
  String downloadSpeed = '';
  String uploadSpeed = '';

  StreamSubscription<ConnectivityResult>? connectivitySubscription;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    startCapturing();
  }

  @override
  void dispose() {
    stopCapturing();
    super.dispose();
  }

  void startCapturing() {
    // Start capturing network-related terms
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        // Mobile network is connected
        setState(() {
          carrierName =
              'Jio'; // Replace with actual carrier name retrieval logic
        });
      } else if (result == ConnectivityResult.wifi) {
        // WiFi is connected
        setState(() {
          carrierName =
              'Wifi'; // Replace with actual carrier name retrieval logic
        });
      }
    });

    // Start capturing other parameters
    location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        latitude = locationData.latitude.toString();
        longitude = locationData.longitude.toString();
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        directionData =
            event.toString(); // Replace with actual data processing logic
      });
    });

    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        magneticData =
            event.toString(); // Replace with actual data processing logic
      });
    });

    // ... Add capturing logic for other parameters
  }

  void stopCapturing() {
    connectivitySubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Capture App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Carrier Name: $carrierName'),
          Text('RSRP: $rsrp'),
          Text('RSRQ: $rsrq'),
          Text('CQI: $cqi'),
          Text('SINR: $sinr'),
          Text('TA Distance: $taDistance'),
          Text('Latitude: $latitude'),
          Text('Longitude: $longitude'),
          Text('Height: $height'),
          Text('Magnetic Data: $magneticData'),
          Text('Direction Data: $directionData'),
          Text('Ping Speed: $pingSpeed'),
          Text('Download Speed: $downloadSpeed'),
          Text('Upload Speed: $uploadSpeed'),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NetworkCaptureApp(),
  ));
}
