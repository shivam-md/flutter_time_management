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
    if (isTimerActive == false) {
      isTimerActive = true;
      Timer.periodic(const Duration(seconds: 1), (t) {
        if (_timeInSec > -1) {
          setState(() {
            _timeInSec--;
            circularPercentProgress();
          });
        } else {
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
        decoration: const BoxDecoration(
          color: Color(0xFFDCD0FF),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: const Icon(Icons.menu),
                  onTap: () {
                    debugPrint("menu button clicked");
                  },
                ),
              ),
              const SizedBox(
                height: 180,
              ),
              CircularPercentIndicator(
                radius: 160,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 50,
                lineWidth: 40,
                backgroundColor: Color(0xFFAF8FE9),
                progressColor: Colors.deepPurple.shade400,
                circularStrokeCap: CircularStrokeCap.round,
                percent: circularPercentProgress(),
                center: timerStatus(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // returns START if timer has ended or yet to start.
  // returns seconds remaining when Timer is active.
  Widget timerStatus() {
    if (_timeInSec == 6 || _timeInSec < 0) {
      return FittedBox(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            counter();
            debugPrint(" start button pressed");
          },
          child: Icon(
            Icons.play_arrow_rounded,
            size: 200,
            color: Colors.deepPurple.shade400,
          ),
        ),
      );
    }
    return TextButton(
      onPressed: (){
        setState(() {
          _timeInSec = -1;
        });
        debugPrint(" end timer button pressed");
      },
      child: Text(
        _timeInSec.toString(),
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.w900,
          color: Colors.deepPurple.shade400,),),
    );
  }
  // tracks progress of counter.
  double circularPercentProgress() {
    // make animation value go in ascending order.
    var timeInSec = 5 - _timeInSec;

    // if timer has started and has not ended (> -1).
    if (_timeInSec >= 0 && _timeInSec < 6) return (timeInSec / 5);

    // if timer is either completed or yet to start
    return 0.00;
  }
}













// removed container below
//  Column(
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepPurpleAccent,
//                     ),
//                     onPressed: () {
//                       counter();
//                       debugPrint(" start button pressed");
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
//                       child: Text(
//                         "S T A R T   T I M E R",
//                         style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepPurpleAccent,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _timeInSec = -1;
//                       });
//                       debugPrint(" end timer button pressed");
//                     },
//                     child: const Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 15, horizontal: 42),
//                       child: Text(
//                         "E N D   T I M E R",
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w900),
//                       ),
//                     ),
//                   ),
//                 ],
//               ) //