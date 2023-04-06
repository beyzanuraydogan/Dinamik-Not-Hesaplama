import 'package:dinamik_not_hesapla/constans/app_constants.dart';
import 'package:dinamik_not_hesapla/helper/data_helper.dart';
import 'package:dinamik_not_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildi;
  const DersListesi({required this.onElemanCikarildi, super.key});

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.isNotEmpty
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: ((a) {
                  onElemanCikarildi(index);
                }),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                      shadowColor: Sabitler.anaRenk,
                      child: ListTile(
                        title: Text(tumDersler[index].ad),
                        subtitle: Text(
                            "${tumDersler[index].krediDegeri} Kredi, Not Değeri: ${tumDersler[index].harfDegeri}"),
                        leading: CircleAvatar(
                          backgroundColor: Sabitler.anaRenk,
                          child: Text(
                            (tumDersler[index].harfDegeri *
                                    tumDersler[index].krediDegeri)
                                .toStringAsFixed(0),
                          ),
                        ),
                      )),
                ),
              );
            }),
          )
        : Center(
            child: Text("Lütfen Ders Ekleyiniz", style: Sabitler.baslikStyle),
          );
  }
}
