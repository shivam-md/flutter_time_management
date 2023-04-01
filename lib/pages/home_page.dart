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
  // late double progress;

  void counter() {

    if(isTimerActive == false){
      isTimerActive = true;
      Timer.periodic(const Duration(seconds: 1), (t) {
        if(_timeInSec > -1){
          setState(() {
            _timeInSec--;
            circularPercentProgress();
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
        // decoration: BoxDecoration(
        //   color: Colors.purple.shade50,
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 140,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 50,
                lineWidth: 35,
                backgroundColor: Colors.deepPurpleAccent.shade100,
                progressColor: Colors.deepPurpleAccent.shade700,
                circularStrokeCap: CircularStrokeCap.round,
                percent: circularPercentProgress(),
                center: Text(
                  timerStatus(),
                  style: const TextStyle(fontSize: 50,fontWeight: FontWeight.w900 ,color: Colors.deepPurpleAccent),
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    onPressed: () {
                      counter();
                      debugPrint(" start button pressed");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: Text(
                        "S T A R T   T I M E R",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        _timeInSec = -1;
                      });
                      debugPrint(" end timer button pressed");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 42),
                      child: Text(
                        "E N D   T I M E R",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  // tracks progress of counter.
  double circularPercentProgress(){
    // make animation value go in ascending order.
    var timeInSec = 5 - _timeInSec;

    // if timer has started and has not ended (> -1).
    if(_timeInSec >= 0 && _timeInSec < 6) return (timeInSec/5);

    // if timer is either completed or yet to start
    return 0.00;
  }

  Widget? showPomodoroTimer(){
    int timeInSeconds = 25*60;

    if(timeInSeconds == 0 || timeInSeconds == 25*60){
      return IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow));
    }

  }
}
