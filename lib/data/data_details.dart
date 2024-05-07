import 'package:flutter/material.dart';
class WidgetDetails {
  static List<Map<String, String>> widgetDetailsList = [
    {
      "key": "tween",
      "title": "Tween(s)",
      "details": "A Tween in Flutter is a class that helps you animate values smoothly between a starting and an ending point over a specified duration. The name Tween is short for in-between, emphasizing its role in generating intermediate values during an animation."
    },
    {
      "key": "animation_controller",
      "title": "Animation\nController",
      "details": "An AnimationController in Flutter is a class that controls the timing and duration of animations. It provides methods to start, stop, forward, reverse, and otherwise manage the progress of an animation"
    },
    {
      "key": "tween",
      "title": "Tween(s)",
      "details": "A Tween in Flutter is a class that helps you animate values smoothly between a starting and an ending point over a specified duration. The name Tween is short for in-between, emphasizing its role in generating intermediate values during an animation."
    },
    {
      "key": "animation",
      "title": "Animation",
      "details": "Animation in Flutter refers to the process of creating dynamic and visually engaging motion effects within your application. Animations can be applied to various UI elements, such as widgets, transitions between screens, and interactions, to provide feedback and enhance the user experience"
    },
    {
      "key": "animation",
      "title": "Animation",
      "details": "Animation in Flutter refers to the process of creating dynamic and visually engaging motion effects within your application. Animations can be applied to various UI elements, such as widgets, transitions between screens, and interactions, to provide feedback and enhance the user experience"
    },
    {
      "key": "widget",
      "title": "Widget",
      "details": "A widget is a declarative UI component that represents a part of the user interface. Widgets can be simple, such as a text label or an icon, or they can be more complex, like a button, input field, or entire screen layout"
    },
    {
      "key": "widget",
      "title": "Widget",
      "details": "A widget is a declarative UI component that represents a part of the user interface. Widgets can be simple, such as a text label or an icon, or they can be more complex, like a button, input field, or entire screen layout"
    }
  ];
  static Map<String,List<Color>> colorMap = {
    'tween' : [const Color.fromARGB(255, 234, 207, 37),const Color.fromARGB(245, 243, 131, 6)],
    'animation_controller' : [const Color.fromARGB(245, 81, 127, 245),const  Color.fromARGB(245, 9, 17, 143)],
    'animation' : [const Color.fromARGB(245, 81, 127, 245),const  Color.fromARGB(245, 9, 17, 143)],
    'widget' : [const Color.fromARGB(245, 243, 9, 224),const Color.fromARGB(245, 138, 7, 189)]
  };
}