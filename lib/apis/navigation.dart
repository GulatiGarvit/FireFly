import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:woosmap_flutter/woosmap_flutter.dart';

const String base = "https://fire-fly-five.vercel.app";

Future<Map<String, dynamic>> getRoute(int x, int y) async {
  http.Response response = await http.get(
    Uri.parse(base + "/nav?x=$x&y=$y"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  print("RRRROOOO: ${response.body}");

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<LatLng> route = [];

    for (var element in data['data']['path']) {
      route.add(LatLng(
        lat: double.parse(element[0]),
        lng: double.parse(element[1]),
      ));
    }
    return {
      "route": route,
      "eta": data['data']['time'] / 45,
      "distance": data['data']['time'] * 5,
      "exitName": "Fire Exit"
    };
  } else {
    return {};
  }
}

Future<LatLng> getCurrentPosition(String uuid) async {
  http.Response response = await http.get(
    Uri.parse(base + "/nav/getCoord?uuid=$uuid"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  Map<String, dynamic> data = jsonDecode(response.body);
  return new LatLng(
      lat: double.parse(data['data']['lat']),
      lng: double.parse(data['data']['lng']));
}

Future<List<LatLng>> getFireNodes() async {
  List<LatLng> fireNodes = [];
  http.Response response = await http.get(
    Uri.parse(base + "/nav/getFire"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  print("getFireNodes: ${response.body}");

  Map<String, dynamic> data = jsonDecode(response.body);
  for (var element in data['data']) {
    fireNodes.add(LatLng(
      lat: element[0],
      lng: element[1],
    ));
  }

  return fireNodes;
}

Future<Map<String, dynamic>> getMedkitRoute(int x, int y) async {
  http.Response response = await http.get(
    Uri.parse(base + "/nav/getMedkit?x=$x&y=$y"),
    headers: Map.from({"Content-Type": "application/json"}),
  );

  print("RRRROOOO: ${response.body}");

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<LatLng> route = [];

    for (var element in data['data']['path']) {
      route.add(LatLng(
        lat: double.parse(element[0]),
        lng: double.parse(element[1]),
      ));
    }
    return {
      "route": route,
      "eta": data['data']['time'] / 45,
      "distance": data['data']['time'] * 5
    };
  } else {
    return {};
  }
}
