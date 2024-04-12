import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:woosmap_flutter/woosmap_flutter.dart';

const String base = "https://fire-fly-five.vercel.app";

Future<Map<String, dynamic>> getRoute(double lat, double long) async {
  http.Response response = await http.get(
    Uri.parse(base + "/nav?lat=$long&long=$lat"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  print("getRoute: ${response.body}");

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<LatLng> route = [];
    for (var element in data['data']['path']) {
      if (element.length < 2) continue;
      route.add(LatLng(
        lat: element[1],
        lng: element[0],
      ));
    }
    return {
      "route": route,
      "eta": data['data']['time'],
      "distance": data['data']['dis'],
      "exitName": data['data']['goalName']
    };
  } else {
    return {};
  }
}

Future<List<LatLng>> getFireNodes() async {
  List<LatLng> fireNodes = [];
  http.Response response = await http.get(
    Uri.parse(base + "/ucs/fireNodes"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  print("getFireNodes: ${response.body}");

  Map<String, dynamic> data = jsonDecode(response.body);
  for (var element in data['data']) {
    fireNodes.add(LatLng(
      lat: element[1],
      lng: element[0],
    ));
  }

  return fireNodes;
}

Future<Map<String, dynamic>> getMedkitRoute(double lat, double long) async {
  http.Response response = await http.get(
    Uri.parse(base + "/ucs/getmedkit?lat=$long&long=$lat"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  print("getMedkitRoute: ${response.body}");

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<LatLng> route = [];
    for (var element in data['data']['path']) {
      if (element.length < 2) continue;
      route.add(LatLng(
        lat: element[1],
        lng: element[0],
      ));
    }
    return {
      "route": route,
      "eta": data['data']['time'],
      "distance": data['data']['dis']
    };
  } else {
    return {};
  }
}
