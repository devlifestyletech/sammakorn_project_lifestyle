import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:registerapp_flutter/data/auth.dart';
import 'package:registerapp_flutter/data/home.dart';
import '../../../constance.dart';

class Services {
  Auth auth = Auth();
  Home home = Home();

  getListItems() async {
    Uri url = Uri.parse("${URL}/listItem_whitelist_blacklist/");

    var token_var = await auth.getToken();
    String token = 'Bearer ${token_var[0]["TOKEN"]}';
    String resId = await auth.getResidentId();
    String home_id = await home.getHomeId();

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      },
      body: jsonEncode(
          <String, String>{"home_id": home_id, "resident_id": resId}),
    );

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      return json.decode(body);

      // var lists = json.decode(body);
      // List blacklist = [];
      // List whitelist = [];
      // List whitelist_wait_approve = [];
      // List blacklist_wait_approve = [];
      // List whitelist_reject = [];
      // List blacklist_reject = [];

      // for (var elem in lists) {
      //   if (elem["type"] == "blacklist") {
      //     blacklist.add(elem);
      //   } else if (elem["type"] == "blacklist") {
      //     whitelist.add(elem);
      //   } else if (elem["type"] == "blacklist wait approve") {
      //     blacklist_wait_approve.add(elem);
      //   } else if (elem["type"] == "whitelist wait approve") {
      //     whitelist_wait_approve.add(elem);
      //   } else if (elem["type"] == "whitelist reject") {
      //     whitelist_reject.add(elem);
      //   } else if (elem["type"] == "blacklist reject") {
      //     blacklist_reject.add(elem);
      //   }
      // }

      // return [
      //   whitelist,
      //   blacklist,
      //   whitelist_wait_approve,
      //   blacklist_wait_approve,
      //   whitelist_reject,
      //   blacklist_reject,
      // ];

    } else {
      return 301;
    }
  }

  deleteItem(String type, String index) async {
    var token_var = await auth.getToken();
    Uri url = Uri.parse("${URL}/delete_backlist_whitelist/");
    String token = 'Bearer ${token_var[0]["TOKEN"]}';

    var response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      },
      body: jsonEncode(<String, String>{"type": type, "index": index}),
    );

    print(response.body);

    return response.body;
  }
}
