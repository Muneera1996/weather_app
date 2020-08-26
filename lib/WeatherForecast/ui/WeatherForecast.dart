import 'package:provider/provider.dart';
import 'package:weather_app/WeatherForecast/model/weather_forecast_model.dart';
import 'package:weather_app/WeatherForecast/network/network.dart';
import 'package:weather_app/WeatherForecast/ui/bottomView.dart';
import 'package:weather_app/WeatherForecast/ui/midView.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/WeatherForecast/util/weather_notifier.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  var _cityName;

  @override
  void initState() {
    super.initState();
   // _cityName = "Karachi";
    //Provider.of<WeatherNotifier>(context).searchWeatherForecast(_cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          textFieldView(),
          Consumer<WeatherNotifier>(builder:
              (BuildContext context, value, Widget child) {
            return FutureBuilder<WeatherForecastModel>(
                  future: value.getWeatherForecast(),
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
                  });
          }),
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
          onSubmitted: (String value) {
            _cityName = value;
            Provider.of<WeatherNotifier>(context)
                .searchWeatherForecast(_cityName);
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
          onSubmitted: (String value) {
            _cityName = value;
            Provider.of<WeatherNotifier>(context)
                .searchWeatherForecast(_cityName);
          },
        ),
      ),
    );
  }
}
