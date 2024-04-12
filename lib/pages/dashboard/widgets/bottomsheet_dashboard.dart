import 'package:flutter/material.dart';
import 'package:firefly/colors/dark_mode.dart';
// import 'package:firefly/pages/ble/ble_scanner.dart';

class BottomsheetDashboard extends StatefulWidget {
  BottomsheetDashboard(
      {super.key, required this.onSosPressed, required this.onExplorePressed});
  VoidCallback onSosPressed, onExplorePressed;

  @override
  State<BottomsheetDashboard> createState() => _BottomsheetDashboardState();
}

class _BottomsheetDashboardState extends State<BottomsheetDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'South Pacific Mall',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '🛡️ (101/101)',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              'Rohini West, ABC Road, New Delhi, India',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                ),
                elevation: MaterialStateProperty.all(4),
              ),
              child: Text(
                'Explore Building',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: widget.onExplorePressed,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                backgroundColor: MaterialStateProperty.all(
                  DarkModeColors.colorPrimary,
                ),
                elevation: MaterialStateProperty.all(4),
              ),
              child: Text(
                'SOS',
                style: TextStyle(color: Color(0xFFF9F8FD), fontSize: 16),
              ),
              onPressed: widget.onSosPressed,
            ),
          ),
        ],
      ),
    );
  }
}
