mixin ExpressionValidation{

  bool hasInvalidOperator(String expression) {
    final RegExp invalidOperatorRegex = RegExp(r'[^0-9\+\-\*\/\^\(\)\s]');
    return invalidOperatorRegex.hasMatch(expression);
  }


  bool containsDigit(String expression) {
    final RegExp digitRegex = RegExp(r'\d');
    return digitRegex.hasMatch(expression);
  }

}