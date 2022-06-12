import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'salon.dart';
import 'giris.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Akıllı Ev Kontrol Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final screens = [
    const Page1(),
    const Page2(),
    const Salon(),
    const Page3(),
    const Giris(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.purple,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Akıllı Ev Kontrol Sistemi",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Oda 1',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Oda 2',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Salon',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Oda 3',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Giriş',
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}


/* 
Center(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
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
            const Text(
              "Nodemcu Controller",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
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
                      children: [
                        const SizedBox(
                          width: 80,
                        ),
                        Text(
                          "Odanın Sıcaklığı:",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$last_temp",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Wrap(
                            children: const <Widget>[
                              Icon(
                                Icons.refresh,
                                color: Colors.white24,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Güncelle",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          //onPressed: getTemp,
                          onPressed: getTemp,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                        ),
                        Text(
                          "Odadaki Nem    :",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "58.00",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
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
                      children: const [
                        Text("Son Güncelleme:"),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text("20/01/2022 05:55:06"),
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
                height: 75.0,
              ),
            ),
          ],
        ),
      ),

*/





/*

**home: const Sayac(isim: "Bardak",),

class Sayac extends StatefulWidget {
  final String isim;

  const Sayac({Key? key, required this.isim}) : super(key: key);

  @override
  _SayacState createState() => _SayacState();
}

class _SayacState extends State<Sayac> {

  int sayi = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("${widget.isim} sayisi: $sayi"),
      
      floatingActionButton: FloatingActionButton(onPressed: sayiArttir),
    );
  }

  void sayiArttir(){
      setState(() {
        sayi++;
      });
    }
}
*/