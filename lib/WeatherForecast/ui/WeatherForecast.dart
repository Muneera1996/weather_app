import 'package:weather_app/WeatherForecast/model/weather_forecast_model.dart';
import 'package:weather_app/WeatherForecast/network/network.dart';
import 'package:weather_app/WeatherForecast/ui/bottomView.dart';
import 'package:weather_app/WeatherForecast/ui/midView.dart';
import 'package:flutter/material.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  Future<WeatherForecastModel> weatherForecast;
  var _cityName;

  @override
  void initState() {
    super.initState();
   _cityName = "Mumbai";
    weatherForecast = getWeatherForecast(cityName: _cityName);

  }

  Future<WeatherForecastModel> getWeatherForecast({String cityName}) => Network().getWeatherForecast(cityName: _cityName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          textFieldView(),
          Container(
            child: FutureBuilder<WeatherForecastModel>(
                future: weatherForecast,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherForecastModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        midView(snapshot),
                        //midView(snapshot),
                        BottomView(snapshot: snapshot)
                        //bottomView(snapshot, context)
                      ],
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget textFieldView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: TextField( 
          decoration: InputDecoration(
              hintText: "Enter City Name",
              prefixIcon: Icon(Icons.search),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.all(8)),
          onSubmitted: (value) {
            setState(() {
              _cityName = value;
              weatherForecast = getWeatherForecast(cityName: _cityName);
            });
          },
        ),
      ),
    );
  }

Widget TextViewField() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Karachi',
            prefixIcon: Icon(Icons.search),
            labelText: 'Enter City',
            contentPadding: EdgeInsets.all(8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSubmitted: (String value){
            setState(() {
              _cityName = value;
              weatherForecast = getWeatherForecast(cityName: _cityName);
            });
          },
        ),
      ),
    );

  }




}
