import 'package:flutter/material.dart';
import 'package:flutter_learn_1/home.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 37, 37, 37),
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Cloud Notes'),
              toolbarHeight: 0,
              backgroundColor: Color.fromARGB(100, 57, 152, 189),
            ),
            body: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                    color: Color.fromARGB(255, 238, 227, 209),
                    image: DecorationImage(
                        image: AssetImage('assets/images/moon.jpg'))),
                height: 500,
                child: Stack(
                  children: [
                    Positioned(
                      top: 280,
                      left: 20,
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/images/icon1.png'),
                    ),
                    Positioned(
                      top: 350,
                      left: 250,
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/images/icon2.png'),
                    )
                  ],
                ),
              ),
              Container(
                color: Color.fromARGB(255, 37, 37, 37),
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(top: 501),
                child: Stack(children: [
                  Positioned(
                    left: 10,
                    top: 50,
                    child: Text(
                      'Check Live weather updates',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Positioned(
                      top: 70,
                      left: 10,
                      child: Text(
                        'all over the world',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      )),
                  Positioned(
                    top: 150,
                    left: 130,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        ); // Add the closing parenthesis here
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 37, 37),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 238, 227, 209)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 240,
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/icon3.png'),
                  )
                ]),
              ),
              Container(
                  child: Stack(
                children: [
                  Positioned(
                      top: 430,
                      left: 70,
                      child: Image.asset('assets/images/icon4.png'))
                ],
              ))
            ])),
        debugShowCheckedModeBanner: false);
  }
}
