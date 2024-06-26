import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firefly/apis/navigation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:woosmap_flutter/woosmap_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SosPage extends StatefulWidget {
  final bool medKit;
  SosPage({super.key, this.medKit = false});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  WoosmapController? _controller;
  String? distance;
  String? time;
  LatLng? loc;
  Map<String, List<int>> map = {
    "1": [3, 0],
    "2": [3, 6],
    "3": [0, 6]
  };
  String? currentUuid;
  String? exitName;
  List<Marker> markers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22))),
              height: MediaQuery.of(context).size.height / 8,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_circle_right,
                    size: MediaQuery.of(context).size.width / 6,
                    color: Colors.white,
                  ),
                  // Image.asset(
                  //   "assets/images/up_arrow.png",
                  //   width: MediaQuery.of(context).size.width / 6,
                  // ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(distance ?? "Calculating...",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      if (!widget.medKit)
                        Text(distance != null ? "via $exitName" : "",
                            style: TextStyle(color: Colors.white, fontSize: 12))
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  WoosmapMapViewWidget.create(
                    wooskey: "a21f4a5d-595b-439c-9628-a62949aee455",
                    mapOptions: MapOptions(
                        center: LatLng(
                            lat: 28.626999083937292, lng: 77.18925912717486),
                        zoom: 18),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 8.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 4,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Image.asset(
                                            "assets/images/cancel.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        time ?? "Routing you to safety...",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        time != null
                                            ? "Safe for the next 8 minutes"
                                            : "",
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 12),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          _launchCaller();
                        },
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.green)),
                        backgroundColor: Colors.white,
                        child: Icon(Icons.phone, color: Colors.green),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20 + 100, right: 12),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SosPage(medKit: true)));
                        },
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.red)),
                        backgroundColor: Colors.red,
                        child:
                            Icon(Icons.medical_services, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchCaller() async {
    launchUrl(Uri.parse("tel://108"));
  }

  void loadMedKit() async {
    Map<String, dynamic> data =
        await getMedkitRoute(map[currentUuid]![0], map[currentUuid]![1]);

    setState(() {
      time = "${data['eta']} min";
      distance = "${data['distance']}m to MedKit";
    });

    List<LatLng> route = data['route'];
    LatLng? prev;
    for (var ll in route) {
      MarkerOptions markerOptions =
          MarkerOptions(position: LatLng(lat: ll.lat, lng: ll.lng));
      markerOptions.icon = WoosIcon(
          url:
              "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
          scaledSize: WoosSize(height: 12, width: 12));
      var marker = Marker.create(markerOptions, _controller!);
      markers.add(marker);
      marker.add();

      if (prev == null) {
        prev = ll;
        continue;
      }

      double l1 = prev.lat;
      double l2 = ll.lat;
      double l3 = prev.lng;
      double l4 = ll.lng;

      double dff1 = (l2 - l1).abs();
      double diff2 = (l4 - l3).abs();
      if (l2 > l1 && l4 > l3) {
        while (l1 < l2 && l3 < l4) {
          l1 += dff1 / 5;
          l3 += diff2 / 5;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      } else if (l2 > l1 && l4 < l3) {
        while (l1 < l2 && l3 > l4) {
          l1 += dff1 / 5;
          l3 -= diff2 / 5;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      } else if (l2 < l1 && l4 > l3) {
        while (l1 > l2 && l3 < l4) {
          l1 -= dff1 / 5;
          l3 += diff2 / 5;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      } else {
        while (l1 > l2 && l3 > l4) {
          l1 -= dff1 / 5;
          l3 -= diff2 / 5;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      }

      prev = ll;
    }

    List<LatLng> fireNodes = await getFireNodes();
    for (var ll in fireNodes) {
      MarkerOptions markerOptions =
          MarkerOptions(position: LatLng(lat: ll.lat, lng: ll.lng));
      markerOptions.icon = WoosIcon(
          url:
              "https://static-00.iconduck.com/assets.00/fire-emoji-402x512-8ma95d17.png",
          scaledSize: WoosSize(height: 36, width: 36));
      var marker = Marker.create(markerOptions, _controller!);
      marker.add();
    }
  }

  void removeAllMarkers() {
    for (var marker in markers) {
      marker.remove();
    }
  }

  Future<void> locateMe() async {
    Timer.periodic(Duration(seconds: 5), (timer) {
      startScan();
    });
  }

  void startScan() async {
    FlutterBluePlus.startScan(
        withServices: [Guid("bf27730d-860a-4e09-889c-2d8b6a9e0fe7")],
        timeout: Duration(seconds: 10));

    var subscription = FlutterBluePlus.scanResults.listen((results) async {
      ScanResult? fin;
      for (ScanResult r in results) {
        if (fin == null || r.rssi.abs() < fin.rssi.abs()) fin = r;
      }

      if (fin == null) return;
      currentUuid = fin.device.advName.split(" ")[1];
      LatLng currentLoc =
          await getCurrentPosition(fin.device.advName.split(" ")[1]);
      if (loc == null ||
          (currentLoc.lat != loc!.lat || currentLoc.lng != loc!.lng)) route();
      setState(() {
        loc = currentLoc;
        _controller!.setUserLocation(loc!.lat, loc!.lng, 0, 0, true);
        _controller!.setZoom(18);

        // _controller!.setCenter(LatLng(lat: loc!.lat, lng: loc!.lng),
        //     WoosPadding(bottom: 0, left: 0, right: 0, top: 0));
      });
    });
  }

  void route() async {
    print("Routing!!!!!");
    print("${map[currentUuid]![0]}, ${map[currentUuid]![1]}");
    Map<String, dynamic> data =
        await getRoute(map[currentUuid]![0], map[currentUuid]![1]);

    print("XXXXXXXXXX");

    removeAllMarkers();

    setState(() {
      time = "${data['eta']} min";
      distance = "${data['distance']}m to exit";
      exitName = data['exitName'];
    });

    List<LatLng> route = data['route'];
    LatLng? prev;
    for (var ll in route) {
      MarkerOptions markerOptions =
          MarkerOptions(position: LatLng(lat: ll.lat, lng: ll.lng));
      markerOptions.icon = WoosIcon(
          url:
              "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
          scaledSize: WoosSize(height: 12, width: 12));
      var marker = Marker.create(markerOptions, _controller!);
      marker.add();

      if (prev == null) {
        prev = ll;
        continue;
      }

      double l1 = prev.lat;
      double l2 = ll.lat;
      double l3 = prev.lng;
      double l4 = ll.lng;

      double dff1 = (l2 - l1).abs();
      double diff2 = (l4 - l3).abs();
      if (l2 > l1 && l4 > l3) {
        while (l1 < l2 && l3 < l4) {
          l1 += dff1 / 2;
          l3 += diff2 / 2;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      } else if (l2 > l1 && l4 < l3) {
        while (l1 < l2 && l3 > l4) {
          l1 += dff1 / 2;
          l3 -= diff2 / 2;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      } else if (l2 < l1 && l4 > l3) {
        while (l1 > l2 && l3 < l4) {
          l1 -= dff1 / 2;
          l3 += diff2 / 2;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      } else {
        while (l1 > l2 && l3 > l4) {
          l1 -= dff1 / 2;
          l3 -= diff2 / 2;
          MarkerOptions markerOptions =
              MarkerOptions(position: LatLng(lat: l1, lng: l3));
          markerOptions.icon = WoosIcon(
              url:
                  "https://www.pinclipart.com/picdir/big/28-288762_all-photo-png-clipart-google-map-round-marker.png",
              scaledSize: WoosSize(height: 12, width: 12));
          var marker = Marker.create(markerOptions, _controller!);
          marker.add();
        }
      }

      prev = ll;
    }

    List<LatLng> fireNodes = await getFireNodes();
    for (var ll in fireNodes) {
      MarkerOptions markerOptions =
          MarkerOptions(position: LatLng(lat: ll.lat, lng: ll.lng));
      markerOptions.icon = WoosIcon(
          url: "https://www.freeiconspng.com/uploads/red-circle-icon-1.png",
          scaledSize: WoosSize(height: 35, width: 35));
      var marker = Marker.create(markerOptions, _controller!);
      marker.add();
    }
  }

  void onVenueLoaded() async {
    locateMe();

    if (widget.medKit) {
      loadMedKit();
      return;
    }
  }
}
