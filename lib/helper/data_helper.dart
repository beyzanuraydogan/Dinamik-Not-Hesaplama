import 'package:dinamik_not_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DataHelper {

  static List<String> _tumDerslerinHarfleri() {
    return ["AA", "BA", "BB", "CB", "CC", "DC", "DD", "FF"];
  }

  static ortalamaHesapla(){
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var element in tumEklenenDersler) {
      toplamNot =toplamNot + (element.krediDegeri * element.harfDegeri);
      toplamKredi += element.krediDegeri;
      }
     return (toplamNot / toplamKredi);

  }

  static List<Ders> tumEklenenDersler = [];

  static dersEkle(Ders ders){
    tumEklenenDersler.add(ders);
  }
  
  static double _harfiNotaCevir(String harf) {
    switch (harf) {
      case "AA":
        return 4;
      case "BA":
        return 3.5;
      case "BB":
        return 3;
      case "BC":
        return 2.5;
      case "CC":
        return 2;
      case "DC":
        return 1.5;
      case "DD":
        return 1;
      case "FD":
        return 0.5;
      case "FF":
        return 0.0;
      default:
        return 1;
    }
  }

  static List<DropdownMenuItem<double>> tumDerslerinHarfleri() {
    return _tumDerslerinHarfleri()
        .map((e) => DropdownMenuItem(
              value: _harfiNotaCevir(e),
              child: Text(e),
            ),)
        .toList();
  }

  static List<int> _tumKrediler(){
    return List.generate(10, (index) => index+1);
  }

  static List<DropdownMenuItem<double>> tumDerslerinKredileri(){
    return _tumKrediler()
    .map((e) => DropdownMenuItem(
      value: e.toDouble() ,
      child: Text(e.toString()),
      ),).toList();
  }
}
