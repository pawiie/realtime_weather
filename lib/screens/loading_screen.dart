import 'package:flutter/material.dart';
import 'package:realtime_weather/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

double lat=35.0, lon=-12.0;

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }


  void getLocation() async{
    Location location = new Location();
    await location.getCurrentLocation();
    // print(location.latitude);
    // print(location.longitude);
    lat=location.latitude;
    lon=location.longitude;
  }
  
  void getData() async{

    var uri = Uri(
        scheme: 'https',
        host: 'api.weatherapi.com',
        path: '/v1/current.json',
        query:'key=ca50cfc1624043678a1174243211003&q='+lat.toString()+','+lon.toString()+'&aqi=no'
        );
    http.Response response =await  http.get(uri);
    if(response.statusCode==200){
      print(response.body);
    }
    else{
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    getData();
    return Scaffold(
      body: Center(
        // child: RaisedButton(
        //   onPressed: () {
        //     getLocation();
        //   },
        //   child: Text('Get Location'),
        // ),
      ),
    );
  }
}
