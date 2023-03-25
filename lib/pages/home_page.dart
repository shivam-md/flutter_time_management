import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _timeInSec = 5;
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
              Text(
                _timeInSec < 0 ? "DONE" : _timeInSec.toString(),
                style: const TextStyle(fontSize: 100,fontWeight: FontWeight.w700 ,color: Colors.deepPurpleAccent),
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
