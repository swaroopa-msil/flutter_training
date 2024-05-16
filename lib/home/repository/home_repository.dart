import 'dart:convert';
import 'dart:io';

import '../model/contact_model.dart';
import '../utils/app_constants.dart';

class HomeRepository{
  var client = HttpClient();

  Future<List<ContactModel>?> getContactDataFromServer() async{
   final url = Uri.parse(AppConstant.CONTACT_LIST_URL);
    try{
      HttpClientRequest request = await client.getUrl(url);
      HttpClientResponse response = await request.close();
      if (response.statusCode == AppConstant.SUCCESS_CODE) {
        final String respBody = await response.transform(utf8.decoder).join();
        List<dynamic> data = json.decode(respBody);
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