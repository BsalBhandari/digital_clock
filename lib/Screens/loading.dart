import 'package:flutter/material.dart';
import 'package:timeapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  void setupWorldTime() async {
    WorldTime instance =
        WorldTime(flag: 'flag', location: 'Nepal', url: 'Asia/Nepal');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'url': instance.url,
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isdaytime': instance.isdaytime
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: Center(
          child: SpinKitThreeInOut(
            color: Colors.white,
            size: 50,
          ),
        ));
  }
}
