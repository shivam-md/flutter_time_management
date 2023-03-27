import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _timeInSec = 6;
  var isTimerActive = false;

  void counter() {

    if(isTimerActive == false){
      isTimerActive = true;
      Timer.periodic(const Duration(seconds: 1), (t) {
        if(_timeInSec > -1){
          setState(() {
            _timeInSec--;
          });
        }
        else{
          isTimerActive = false;
          _timeInSec = 6;
          t.cancel();
        }
      });
    }
  }
  // returns START if timer has ended or yet to start.
  // returns seconds remaining when Timer is active.
  String timerStatus(){
    if(_timeInSec == 6 || _timeInSec < 0){
      return 'START';
    }
    return _timeInSec.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(radius: 300,
              lineWidth: 40,
                center: Text(
                  timerStatus(),
                  style: const TextStyle(fontSize: 100,fontWeight: FontWeight.w700 ,color: Colors.deepPurpleAccent),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  counter();
                  debugPrint("button pressed");
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Text(
                    "Start Timer",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
