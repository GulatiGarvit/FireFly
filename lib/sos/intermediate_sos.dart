import 'package:firefly/sos/main.dart';
import 'package:flutter/material.dart';
import 'package:firefly/colors/dark_mode.dart';

class IntermediateSosPage extends StatefulWidget {
  const IntermediateSosPage({super.key});

  @override
  State<IntermediateSosPage> createState() => _IntermediateSosPageState();
}

class _IntermediateSosPageState extends State<IntermediateSosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/fire_icon.png",
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Fire Alert for South Pacific Mall!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                        elevation: MaterialStateProperty.all(4),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SosPage()));
                      },
                      child: Text(
                        'Navigate to Safety',
                        style:
                            TextStyle(color: Color(0xFFF9F8FD), fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all(4),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'I\'m not inside',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
