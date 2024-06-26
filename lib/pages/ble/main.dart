import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:woosmap_flutter/woosmap_flutter.dart';
import 'package:flutter/material.dart';

class BleExample extends StatefulWidget {
  const BleExample({super.key});

  @override
  State<BleExample> createState() => _BleExampleState();
}

class _BleExampleState extends State<BleExample> {
  WoosmapController? _controller;
  LatLng? loc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WoosmapMapViewWidget.create(
          wooskey: "a21f4a5d-595b-439c-9628-a62949aee455",
          // mapOptions: MapOptions(
          //     center: LatLng(
          //         lat: 48.88115758013444, lng: 2.3562935123187856),
          //     zoom: 20),
          widget: true,
          activate_indoor_product: true,
          indoorRendererConfiguration: IndoorRendererOptions(
              centerMap: true, defaultFloor: 0, venue: "ishuven"),
          indoorWidgetConfiguration: IndoorWidgetOptions(
            units: UnitSystem.metric,
            ui: IndoorWidgetOptionsUI(
                primaryColor: "#318276", secondaryColor: "#004651"),
          ),
          onRef: (p0) async {
            _controller = p0;
            // reloadMenu();
          },
          indoor_venue_loaded: (message) {
            // setState(() {
            //   isLoading = false;
            // });
            onVenueLoaded();
            debugPrint(jsonEncode(message));
          },
          indoor_feature_selected: (message) {
            debugPrint(jsonEncode(message));
          },
          indoor_level_changed: (message) {
            debugPrint("$message");
          },
          indoor_user_location: (message) {
            debugPrint(jsonEncode(message));
          },
          indoor_directions: (message) {
            _controller?.setDirections(message);
            debugPrint(jsonEncode(message));
          },
          indoor_highlight_step: (message) {
            debugPrint(jsonEncode(message));
          },
        ),
      ),
    );
  }

  void onVenueLoaded() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      FlutterBluePlus.startScan(
          withServices: [Guid("bf27730d-860a-4e09-889c-2d8b6a9e0fe7")],
          timeout: Duration(seconds: 10));

      var subscription = FlutterBluePlus.scanResults.listen((results) async {
        ScanResult? fin;
        for (ScanResult r in results) {
          if (fin == null || r.rssi.abs() < fin.rssi.abs()) fin = r;
        }

        if (fin == null) return;

        if (fin.advertisementData.advName.split(" ")[1] == "1") {
          loc = LatLng(lat: 28.624211110729064, lng: 77.18556315921688);
        } else if (fin.advertisementData.advName.split(" ")[1] == "2") {
          loc = LatLng(lat: 28.625757376332814, lng: 77.1867930145221);
        } else {
          loc = LatLng(lat: 28.62631074601461, lng: 77.18595579555301);
        }

        panToCurrentLocation();
      });
    });
  }

  void panToCurrentLocation() {
    _controller!.setUserLocation(loc!.lat, loc!.lng, 0, 0, true);
    _controller!.setZoom(18);

    _controller!.setCenter(LatLng(lat: loc!.lat, lng: loc!.lng),
        WoosPadding(bottom: 0, left: 0, right: 0, top: 0));
  }
}
