import 'package:flutter/material.dart';

import '../../data/data_details.dart';
import '../../model/widget_model.dart';

class WidgetDataProvider extends ChangeNotifier{

  List<WidgetModel> widgetModelList = [];

  void getWidgetList(){
    final widgetModelL = WidgetDetails.widgetDetailsList.map((e) =>
        WidgetModel(details: e['details']??'', Title: e['title']??'', key: e['key']??"")).toList();
    widgetModelList.clear();
    widgetModelList.addAll(widgetModelL);
    notifyListeners();
    // return widgetModelList;
  }

}