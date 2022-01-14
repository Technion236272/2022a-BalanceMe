import 'package:flutter/material.dart';

class ConnectionLostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // https://github.com/abuanwar072/20-Error-States-Flutter
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/10_Connection Lost.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 25,
                    color: Color(0xFF59618B).withOpacity(0.17),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
