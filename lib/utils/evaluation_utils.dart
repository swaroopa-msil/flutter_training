import 'dart:collection';

import 'package:march09/utils/stack_structure.dart';
import 'dart:math' as math;

class ExpEvaluator{
  List<String> output = [];


  /// example -  [3, 4, 5, 2, -, *, +, 2, 2, ^, +]
  ///   expression - 3+4*(5-2)+2^2  answer = 3+12+4 = 19
  ///   operators - ^+-*+
  ///   output 3,4,5,2,-,*,2,2,^ +
  ///   stack  2^2, 5-2 , 4*(5-2),+,+ => 4, 3, 12 , +, + => 7, 12, + => 19

  bool isOperator(String s) {
    return ['+', '-', '*', '/', '^'].contains(s);
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  List<String> splitExpression(String expression) {

    final RegExp regex = RegExp(r'(\d+|\+|\-|\*|\/|\^|\(|\))');
    final matches = regex.allMatches(expression);
    List<String> splitList = matches.map((match) => match.group(0)!).toList();

    // combining sign with negative numbers
    for (int i = 0; i < splitList.length; i++) {
      if (splitList[i] == '-' && (i == 0 || isOperator(splitList[i - 1]) || splitList[i - 1] == '(')) {
        splitList[i + 1] = '-${splitList[i + 1]}';
        splitList.removeAt(i);
      }
    }
    return splitList;
  }

 void inFixToPostfix(String infixExp){
    Queue<String> operators = Queue<String>();
    Map<String, int> precedence = {
      '+': 1,
      '-': 1,
      '*': 2,
      '/': 2,
      '^': 3,
    };

    Set<String> rightAssociative = {'^'};

    List<String> splitList = splitExpression(infixExp);

    for (String item in splitList) {
      if (item == '(') {
        operators.addFirst(item);
      } else if (item == ')') {
        print('output expin $operators');
        while (operators.isNotEmpty && operators.first != '(') {
          output.add(operators.removeFirst());
        }
        operators.removeFirst();
      } else if (isNumeric(item)) {
        output.add(item);
      } else if (isOperator(item)) {
        while (operators.isNotEmpty &&
            operators.first != '(' &&
            (precedence[operators.first]! > precedence[item]! ||
                (precedence[operators.first]! == precedence[item]! &&
                    !rightAssociative.contains(item)))) {
          output.add(operators.removeFirst());
        }
        operators.addFirst(item);
      }
    }
    while (operators.isNotEmpty) {
      output.add(operators.removeFirst());
    }
  }

  double evaluateExpression(String infixExp){
    Stack<double> stack = Stack<double>();
    inFixToPostfix(infixExp);
    for (String item in output) {
      if (isNumeric(item)) {
        stack.push(double.parse(item));
      } else if (isOperator(item)) {
        double b = stack.pop();
        double a = stack.pop();
        double result = calculation(a, b, item);
        stack.push(result);
      }
    }

    return stack.pop();
  }

  double calculation(double a, double b, String operator) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        return a / b;
      case '^':
        return math.pow(a,b).toDouble();
      default:
        throw ArgumentError("Invalid operator: $operator");
    }
  }

}


