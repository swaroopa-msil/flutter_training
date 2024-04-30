

import 'package:flutter/cupertino.dart';

class DataListChangeProvider extends ChangeNotifier{

  List<String> dataList = [];
  List<String> favDataList = [];

  void addToList(String item){
    dataList.add(item);
    notifyListeners();
  }

  void addToFav(String item){
    if(isInFav(item)){
      removeFromFav(item);
    }else{
      favDataList.add(item);
    }
    notifyListeners();
  }
  void removeFromFav(String item){
    favDataList.remove(item);
    notifyListeners();
  }

  void removeFromList(String item){
    if(favDataList.contains(item)){
      favDataList.remove(item);
    }
    dataList.remove(item);
    notifyListeners();
  }

  bool isInFav(String item){
    return favDataList.contains(item);
  }


}