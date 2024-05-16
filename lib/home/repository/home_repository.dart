import 'dart:convert';

import '../model/contact_model.dart';
import '../utils/app_constants.dart';
import 'package:http/http.dart' as http;

class HomeRepository{

  Future<List<ContactModel>?> getContactDataFromServer() async{
    final url = Uri.parse(AppConstant.CONTACT_LIST_URL);
    try{
      final resp = await http.get(url);
      if (resp.statusCode == AppConstant.SUCCESS_CODE) {
        List<dynamic> data = json.decode(resp.body);
        final List<ContactModel> contactList = data.map((m) => ContactModel.fromJson(m)).toList();
        return contactList;
      } else {
        return null;
      }
    }catch(e){
      return null;
    }

  }
}