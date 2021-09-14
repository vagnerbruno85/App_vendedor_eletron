import 'dart:async';

import 'package:flutter/material.dart';

class SplashLoadingWidget extends StatelessWidget {
  get image => null;

  void Function()? get handleTimeout => null;

  startTimeout() async {
    var duration = const Duration(seconds:5);
    return new Timer(duration, handleTimeout!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
                  color: Color(0xFF9d4edd),
                  gradient: LinearGradient(colors: [
                    Color(0xFFe0aaff),
                    Colors.white,
                    Color(0xFF9d4edd),
                    Colors.white,
                    Color(0xFF9d4edd),
                  ]
                  
                  ),
                ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logosplash.png'),
           LinearProgressIndicator(color: Color(0xFF9d4edd),),
        ],
       
      ),
    );
      }
}



