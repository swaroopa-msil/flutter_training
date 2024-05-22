mixin ExpressionValidation{

  bool hasInvalidOperator(String expression) {
    final RegExp invalidOperatorRegex = RegExp(r'[^0-9\+\-\*\/\^\(\)\s]');
    return invalidOperatorRegex.hasMatch(expression);
  }


  bool containsDigit(String expression) {
    final RegExp digitRegex = RegExp(r'\d');
    return digitRegex.hasMatch(expression);
  }

  bool validateParentheses(String expression) {
    int counter = 0;
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '(') {
        counter++;
      } else if (expression[i] == ')') {
        counter--;
        if (counter < 0) {
          return false;
        }
      }
    }
    print('counter number $counter');
    return counter == 0;
  }

}