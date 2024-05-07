import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:march09/home/ui/shape_widget.dart';
import 'package:march09/utils/dotted_line.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double boxWidthSide = 60;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const HexagonShapeWidget(borderColor1: Color.fromARGB(
                              255, 234, 207, 37),
                              borderColor2: Color.fromARGB(
                                  245, 243, 131, 6),
                              textData: 'Tween(s)'),
                          SizedBox(width: boxWidthSide),
                          const HexagonShapeWidget(borderColor1:Color.fromARGB(
                              245, 81, 127, 245),
                              borderColor2: Color.fromARGB(
                                  245, 9, 17, 143)
                              ,textData: 'Animation\nController'),
                          SizedBox(width: boxWidthSide),
                          const HexagonShapeWidget(
                              borderColor1: Color.fromARGB(
                                  255, 234, 207, 37),
                              borderColor2: Color.fromARGB(
                                  245, 243, 131, 6),textData: 'Tween(s)')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const HexagonShapeWidget(borderColor1:Color.fromARGB(
                              245, 81, 127, 245),
                              borderColor2: Color.fromARGB(
                                  245, 9, 17, 143),textData: 'Animation'),
                           SizedBox(width: boxWidthSide),
                          const HexagonShapeWidget(borderColor1:Color.fromARGB(
                              245, 81, 127, 245),
                              borderColor2: Color.fromARGB(
                                  245, 9, 17, 143),textData: 'Animation'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const HexagonShapeWidget(borderColor1:Color.fromARGB(
                              245, 243, 9, 224),
                              borderColor2: Color.fromARGB(
                                  245, 138, 7, 189),textData: 'Widget'),
                           SizedBox(width: boxWidthSide),
                          const HexagonShapeWidget(borderColor1:Color.fromARGB(
                              245, 243, 9, 224),
                              borderColor2: Color.fromARGB(
                                  245, 138, 7, 189), textData: 'Widget'),
                        ],
                      ),
                    ],
                  ),
                  CustomPaint(
                    painter: DottedLine(
                        offsetXInitial: 60+30 +12,
                        offsetYInitial: 60 +12,
                        offsetXEnd: 60+30+30+15,
                        offsetYEnd: 60 + 30 + 20,
                        color: const Color.fromARGB(
                            245, 243, 131, 6),
                        spacing: 5,
                        dotWidth: 2
                    ),
                  ),
                  CustomPaint(
                    painter: DottedLine(
                        offsetXInitial: 60+30 + 80,
                        offsetYInitial: 60 +15,
                        offsetXEnd: 60+30+30+15,
                        offsetYEnd: 60 + 30 + 22.5,
                        color: const Color.fromARGB(
                            245, 9, 17, 143),
                        spacing: 5,
                        dotWidth: 2
                    ),
                  ),
                  CustomPaint(
                    painter: DottedLine(
                        offsetXInitial: 60 + 40 + 80 + 60,
                        offsetYInitial: 70,
                        offsetXEnd: 60+30+30+15 + 80 + 60,
                        offsetYEnd: 60 + 30 + 20,
                        color: const Color.fromARGB(
                            245, 243, 131, 6),
                        spacing: 5,
                        dotWidth: 2
                    ),
                  ),
                  CustomPaint(
                    painter: DottedLine(
                        offsetXInitial: 60+30 + 80 + 60 + 80,
                        offsetYInitial: 60 +15,
                        offsetXEnd: 60+30+30+15 + 80 + 60,
                        offsetYEnd: 60 + 30 + 20,
                        color: const Color.fromARGB(
                            245, 9, 17, 143),
                        spacing: 5,
                        dotWidth: 2
                    ),
                  ),
                  CustomPaint(
                    painter: DottedLine(
                        offsetXInitial: 60+30+30+15,
                        offsetYInitial: 60 +7.5 + 100 + 22.5,
                        offsetXEnd: 60+30+30+15,
                        offsetYEnd: 60 +7.5 + 100 + 45,
                        color: const Color.fromARGB(
                            245, 9, 17, 143),
                        spacing: 5,
                        dotWidth: 2
                    ),
                  ),
                  CustomPaint(
                    painter: DottedLine(
                        offsetXInitial: 60+30+30+15 + 80 + 60,
                        offsetYInitial: 60 +7.5 + 100 + 22.5,
                        offsetXEnd: 60+30+30+15 + 80 + 60,
                        offsetYEnd: 60 +7.5 + 100 + 45,
                        color: const Color.fromARGB(
                            245, 9, 17, 143),
                        spacing: 5,
                        dotWidth: 2
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}
