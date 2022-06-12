
// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, duplicate_ignore

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Salon extends StatefulWidget {
  const Salon({Key? key}) : super(key: key);

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> {
  // ignore: non_constant_identifier_names
  var last_temp = "23.00";
  var last_hum  = "58"; 
  String last_date = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());

  updateData() async {
    var url = Uri.parse(
        'https://gsx2json.com/api?id=148r8M7CVsmZuGy7VsPWBGoeT3hlCprBk8xCd0vTF_rs&sheet=salon_sicaklik&api_key=');
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data)['rows'].last;
        var temp = decodedData['sicaklik'];
        var hum = decodedData['nem'];
        var date = decodedData['tarih_saat'];

        setState(() {
          last_temp = temp.toString();
          last_hum = hum.toString();
          last_date = date.toString(); 
        });

        //print(temp);
        return temp;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  turnOnLight() async {
    //'https://gsx2json.com/api?id=148r8M7CVsmZuGy7VsPWBGoeT3hlCprBk8xCd0vTF_rs&sheet=oda_1_isik&api_key='
    var url = Uri.parse(
        'https://script.google.com/macros/s/AKfycbzetm_JaZh6_-MEuyL0mlgjX7md-wnVy6en95OvTk3dOyYLhmXVAeaSqVVO0H7_b4k1/exec?salon_isik=1');
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data)['columns']['isik_durum'].last;
        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  turnOffLight() async {
    //'https://script.google.com/macros/s/AKfycbzetm_JaZh6_-MEuyL0mlgjX7md-wnVy6en95OvTk3dOyYLhmXVAeaSqVVO0H7_b4k1/exec?isik_durum=1'
    var url = Uri.parse(
        'https://script.google.com/macros/s/AKfycbzetm_JaZh6_-MEuyL0mlgjX7md-wnVy6en95OvTk3dOyYLhmXVAeaSqVVO0H7_b4k1/exec?salon_isik=0');
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        return 'okey';
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: const DecorationImage(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 7.0,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          child: Wrap(
                            children: const <Widget>[
                              Icon(
                                Icons.lightbulb,
                                color: Colors.amber,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "   Işığı Aç  ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          onPressed: turnOnLight,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ElevatedButton(
                          child: Wrap(
                            children: const <Widget>[
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.amber,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Işığı Kapat",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          ),
                          onPressed: turnOffLight,
                        ),
                      ],
                    ),
                    /*
                    Row(
                      children: [
                        Text("buton1"),
                        Text("buton2"),
                      ],
                    ),
                    */
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.green.shade300,
                      Colors.green.shade100,
                    ],
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 70.0,
                height: 160.0,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 5.0,
              animationDuration: kThemeChangeDuration,
              child: Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            Text(
                              "Oda Sıcaklığı:  ",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "$last_temp °C",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20,
                              ),
                            ),
                            
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            Text(
                              "Odadaki Nem:   ",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "$last_hum.00",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              child: Wrap(
                                children: const <Widget>[
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              //onPressed: getTemp,
                              onPressed: updateData,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.green.shade300,
                      Colors.green.shade100,
                    ],
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 70.0,
                height: 180.0,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 7.0,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Son Güncelleme:",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          "$last_date",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.green.shade300,
                      Colors.green.shade100,
                    ],
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 70.0,
                height: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}