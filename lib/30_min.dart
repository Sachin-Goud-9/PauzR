import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:date_time/main.dart' as first;

/*void main() => runApp(MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),
    ));
*/
class MyApp10 extends StatefulWidget {
  @override
  MyAppState10 createState() => MyAppState10();
}

class MyAppState10 extends State<MyApp10> with TickerProviderStateMixin {
  get isPlaying => null;

  showCompleted(BuildContext context)
  {
      return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("You have Earned 10 points."),
        //content: Text("Are you sure you want to pause?"),
        actions: <Widget>[
          FlatButton(child: Text("Confirm"),
          onPressed: () {
            
          },
          ),
          /*FlatButton(child: Text("No"),
          onPressed: () {
            return ;
          },)*/
        ],
      );
      });
  }
  
  Future<String> createAlertDialog(BuildContext context){
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Are you sure you want to pause?"),
        //content: Text("Are you sure you want to pause?"),
        actions: <Widget>[
          FlatButton(child: Text("Yes"),
          onPressed: () {
            Navigator.pushNamed(context,"/");
          },
          ),
          FlatButton(child: Text("No"),
          onPressed: () {
            Navigator.pop(context);
          },)
        ],
      );
    });
  }



  AnimationController controller;

  // bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes:30,seconds: 00),
    );

    // ..addStatusListener((status) {
    //     if (controller.status == AnimationStatus.dismissed) {
    //       setState(() => isPlaying = false);
    //     }

    //     print(status);
    //   })
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                                painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.white,
                              color: themeData.indicatorColor,
                            ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Ends In",
                              style: themeData.textTheme.subhead,
                            ),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  //if(controller.isAnimating==false)
                                  //{
                      
                                      //showCompleted(context);

                                  //}
                                  return Text(
                                    timerString,
                                    style: themeData.textTheme.display4,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        
                      return Icon(controller.isAnimating
                            ? Icons.timer
                            : Icons.play_arrow);
                      
                        //|| Icon(isPlaying
                         //? Icons.pause
                         //: Icons.play_arrow);
                      },
                    ),
                    onPressed: () {
                      // setState(() => isPlaying = !isPlaying);

                      if (controller.isAnimating) {
                        createAlertDialog(context);
                        
                      } else {
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);

                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    double distance=size.width / 2.0;
    Offset p1=Offset(distance,distance);
    Offset p2=Offset(distance+10.0,distance+10.0);
    //canvas.drawLine(p1,p2, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}