import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const String base = "https://fire-fly-five.vercel.app";

Future<bool> registerUserOnMongo(
    String name,
    int age,
    String gender,
    String medRecord,
    String fcmKey,
    String city,
    String phoneNumber,
    String fuid) async {
  Map<String, dynamic> data = {
    "name": name,
    "age": age,
    "gender": gender,
    "medRecord": medRecord,
    "fcmKey": fcmKey,
    "city": city,
    "phone": phoneNumber,
    "fuid": fuid
  };

  http.Response response = await http.post(
    Uri.parse(base + "/user"),
    headers: Map.from({"Content-Type": "application/json"}),
    body: jsonEncode(data),
  );

  print("registerUserOnMongo: ${response.body}");
  return response.statusCode == 200;
}

Future<bool> updateFcm(String fuid, String fcmKey) async {
  Map<String, dynamic> data = {"fcmKey": fcmKey, "fuid": fuid};

  http.Response response = await http.patch(
    Uri.parse(base + "/user/updateFcmKey"),
    headers: Map.from({"Content-Type": "application/json"}),
    body: jsonEncode(data),
  );

  print("updateFcm: ${response.toString()}");
  return response.statusCode == 200;
}

Future<void> updateStrandedPerson(String strandedPersonId, bool isConfirmed) async {
  Map<String, dynamic> data = {
    "isConfirmed": isConfirmed
  };

  await http.patch(
    Uri.parse(base + "/personStranded/$strandedPersonId"),
    headers: Map.from({"Content-Type": "application/json"}),
    body: jsonEncode(data),
  );
}
