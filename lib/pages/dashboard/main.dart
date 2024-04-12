import 'dart:convert';
import 'dart:core';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firefly/sos/intermediate_sos.dart';
import 'package:flutter/material.dart';
import 'package:firefly/apis/navigation.dart';
import 'package:firefly/apis/user.dart';
// import 'package:firefly/pages/ble/ble_scanner.dart';
// import 'package:firefly/pages/sos/intermediate_sos.dart';
// import 'package:firefly/pages/sos/main.dart';
// import 'package:firefly/utils/gps_service.dart';
import 'package:woosmap_flutter/woosmap_flutter.dart';
import 'widgets/bottomsheet_dashboard.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  WoosmapController? _controller;
  bool isLoading = true;

  @override
  void initState() {
    initializeFcm();
    super.initState();
  }

  void initializeFcm() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);

    FirebaseMessaging.instance.getToken().then((fcmToken) async {
      if (fcmToken == null) {
        print("XXXXXXXXXXX");
        return;
      }
      updateFcm(FirebaseAuth.instance.currentUser!.uid, fcmToken!);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String personStrandedId = message.data["personStranded"];
      double latitude = double.parse(message.data["latlng"]["coordinates"[1]]);
      double longitude = double.parse(message.data["latlng"]["coordinates"[0]]);
      // GPSService((lat, long) {
      // Check how far they are
      updateStrandedPerson(personStrandedId, true);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => IntermediateSosPage()));
    });
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WoosmapMapViewWidget.create(
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
            Column(
              children: [
                Spacer(),
                BottomsheetDashboard(
                  onExplorePressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BleScanner(),
                    //   ),
                    // );
                    // List<LatLng> route =
                    //     await getRoute(28.62493571932967, 77.18738107481119);
                    // LatLng? prev;
                    // for (var ll in route) {
                    //   MarkerOptions markerOptions = MarkerOptions(
                    //       position: LatLng(lat: ll.lat, lng: ll.lng));
                    //   markerOptions.icon = WoosIcon(
                    //       url:
                    //           "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
                    //       scaledSize: WoosSize(height: 12, width: 12));
                    //   var marker = Marker.create(markerOptions, _controller!);
                    //   marker.add();

                    //   if (prev == null) {
                    //     prev = ll;
                    //     continue;
                    //   }

                    //   double l1 = prev.lat;
                    //   double l2 = ll.lat;
                    //   double l3 = prev.lng;
                    //   double l4 = ll.lng;

                    //   double dff1 = (l2 - l1).abs();
                    //   double diff2 = (l4 - l3).abs();
                    //   if (l2 > l1 && l4 > l3) {
                    //     while (l1 < l2 && l3 < l4) {
                    //       l1 += dff1 / 5;
                    //       l3 += diff2 / 5;
                    //       MarkerOptions markerOptions =
                    //           MarkerOptions(position: LatLng(lat: l1, lng: l3));
                    //       markerOptions.icon = WoosIcon(
                    //           url:
                    //               "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
                    //           scaledSize: WoosSize(height: 12, width: 12));
                    //       var marker =
                    //           Marker.create(markerOptions, _controller!);
                    //       marker.add();
                    //     }
                    //   } else if (l2 > l1 && l4 < l3) {
                    //     while (l1 < l2 && l3 > l4) {
                    //       l1 += dff1 / 5;
                    //       l3 -= diff2 / 5;
                    //       MarkerOptions markerOptions =
                    //           MarkerOptions(position: LatLng(lat: l1, lng: l3));
                    //       markerOptions.icon = WoosIcon(
                    //           url:
                    //               "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
                    //           scaledSize: WoosSize(height: 12, width: 12));
                    //       var marker =
                    //           Marker.create(markerOptions, _controller!);
                    //       marker.add();
                    //     }
                    //   } else if (l2 < l1 && l4 > l3) {
                    //     while (l1 > l2 && l3 < l4) {
                    //       l1 -= dff1 / 5;
                    //       l3 += diff2 / 5;
                    //       MarkerOptions markerOptions =
                    //           MarkerOptions(position: LatLng(lat: l1, lng: l3));
                    //       markerOptions.icon = WoosIcon(
                    //           url:
                    //               "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
                    //           scaledSize: WoosSize(height: 12, width: 12));
                    //       var marker =
                    //           Marker.create(markerOptions, _controller!);
                    //       marker.add();
                    //     }
                    //   } else {
                    //     while (l1 > l2 && l3 > l4) {
                    //       l1 -= dff1 / 5;
                    //       l3 -= diff2 / 5;
                    //       MarkerOptions markerOptions =
                    //           MarkerOptions(position: LatLng(lat: l1, lng: l3));
                    //       markerOptions.icon = WoosIcon(
                    //           url:
                    //               "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
                    //           scaledSize: WoosSize(height: 12, width: 12));
                    //       var marker =
                    //           Marker.create(markerOptions, _controller!);
                    //       marker.add();
                    //     }
                    //   }

                    //   prev = ll;
                    // }

                    // List<LatLng> fireNodes = await getFireNodes();
                    // for (var ll in fireNodes) {
                    //   MarkerOptions markerOptions = MarkerOptions(
                    //       position: LatLng(lat: ll.lat, lng: ll.lng));
                    //   markerOptions.icon = WoosIcon(
                    //       url: "https://static-00.iconduck.com/assets.00/fire-emoji-402x512-8ma95d17.png", scaledSize: WoosSize(height: 36, width: 36));
                    //   var marker = Marker.create(markerOptions, _controller!);
                    //   marker.add();
                    // }
                  },
                  onSosPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntermediateSosPage(),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onVenueLoaded() {
    _controller!
        .setUserLocation(28.62493571932967, 77.18738107481119, 0, 0, true);
    // _controller!.mapOptions!.center =
    //     LatLng(lat: 28.628569596568086, lng: 77.18906970982692);
    _controller!.setZoom(18);

    _controller!.setCenter(
        LatLng(lat: 28.62493571932967, lng: 77.18738107481119),
        WoosPadding(bottom: 0, left: 0, right: 0, top: 0));
  }
}
