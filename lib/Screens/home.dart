import 'package:flutter/material.dart';
import 'package:timeapp/services/world_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reload() async {
    WorldTime instance =
        WorldTime(flag: 'flag', location: data['location'], url: data['url']);
    await instance.getTime();
    data['time'] = instance.time;
    data['isdaytime'] = instance.isdaytime;
  }

  Map data = {};
  @override
  Widget build(BuildContext context) {
    // data = ModalRoute.of(context) ModalRoute.of(context)!.settings.arguments;
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    // print(data);
    String bgImage = data['isdaytime'] ? 'day.jpeg' : 'night.jpeg';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'flag': result['flag'],
                        'isdaytime': result['isdaytime']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Edit location',
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 28.0, wordSpacing: 2.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: data['time'] == 'Could not get time data'
                    ? TextStyle(fontSize: 18, color: Colors.black)
                    : TextStyle(fontSize: 64, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              data['time'] == 'Could not get time data'
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              reload();
                            });
                          },
                          child: Text(
                            'Reload',
                            style: TextStyle(
                                color: Colors.white, wordSpacing: 2.0),
                          )),
                    )
                  : Text(
                      data['isdaytime']
                          ? 'Have a good day'
                          : 'Have a good night',
                      style: Theme.of(context).textTheme.headline4,
                    )
            ],
          ),
        )),
      ),
    );
  }
}
