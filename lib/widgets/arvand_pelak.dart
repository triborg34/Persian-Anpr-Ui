import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'package:unapwebv/model/model.dart';

class ArvandPelak extends StatelessWidget {
  late plateModel entry;
  ArvandPelak({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      width: 180,
      height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            children: [
              Container(
                width: 30,
                color: const Color.fromARGB(255, 64, 107, 180),
                child: Center(
                  child: Image.network('assets/images/arvand.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  entry.plateNum!.length <=5 ? entry.plateNum!.toPersianDigit()+" | 33" : "${entry.plateNum!.toPersianDigit().substring(0,entry.plateNum!.length-2)} | ${entry.plateNum!.toPersianDigit().substring(entry.plateNum!.length-2)}",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  
                ),
              ),
            ],
          ),
        ));
  }
}


class ArvandPelak2 extends StatelessWidget {
  late plateModel entry;
  ArvandPelak2({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 180,
      height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            children: [
              Container(
                width: 30,
                color: const Color.fromARGB(255, 64, 107, 180),
                child: Center(
                  child: Image.network('assets/images/arvand.png'),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                   entry.plateNum!.length <=5 ? entry.plateNum!.toPersianDigit() + " | 33" : "${entry.plateNum!.toPersianDigit().substring(0,entry.plateNum!.length-2)} | ${entry.plateNum!.toPersianDigit().substring(entry.plateNum!.length-2)}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

