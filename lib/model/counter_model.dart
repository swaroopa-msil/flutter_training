class CounterModel{

  final int value;
  final DateTime date;

CounterModel({required this.value, required this.date});

CounterModel copyWith ({
    int? value,
    DateTime? date
}){
  return CounterModel(value: value ?? this.value , date: date ?? this.date);
}

}