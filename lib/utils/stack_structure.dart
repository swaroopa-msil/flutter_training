class Stack<T>{
  final List<T> _stack = [];

  bool get isStackEmpty => _stack.isEmpty;
  int get stackSize => _stack.length;

  void push(T element){
    _stack.add(element);
  }

  T pop(){
    return _stack.removeLast();
  }
  T peek(){
    return _stack.last;
  }
  @override
  String toString(){
    return _stack.toString();
  }

}