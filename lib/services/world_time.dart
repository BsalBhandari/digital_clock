import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isdaytime = true;

  WorldTime({required this.flag, required this.location, required this.url});

  Future<void> getTime() async {
    try {
      //make a request
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      //GET Properties from data
      String datatime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // String hours = offset.substring(1, 3);
      // String minutes = offset.substring(4);
      //   print(datatime);
      //   print(offset);

      //Datetime object creation
      DateTime now = DateTime.parse(datatime);
      now = now.add(Duration(hours: int.parse(offset)));

      isdaytime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}
