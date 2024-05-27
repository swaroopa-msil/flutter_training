class DataItem {
  List<String> call;
  List<String> put;
  String strikePrice;

  DataItem({required this.call, required this.put, required this.strikePrice});


  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      call: List<String>.from(json['call']),
      put: List<String>.from(json['put']),
      strikePrice: json['strike_price'],
    );
  }
}

class DataModel {
  List<DataItem> data;

  DataModel({required this.data});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      data: List<DataItem>.from(json['data'].map((item) => DataItem.fromJson(item))),
    );
  }
}