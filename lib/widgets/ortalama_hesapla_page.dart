import 'package:dinamik_not_hesapla/constans/app_constants.dart';
import 'package:dinamik_not_hesapla/helper/data_helper.dart';
import 'package:dinamik_not_hesapla/model/ders.dart';
import 'package:dinamik_not_hesapla/widgets/ders_listesi.dart';
import 'package:dinamik_not_hesapla/widgets/harf_drop_down_widget.dart';
import 'package:dinamik_not_hesapla/widgets/kredi_drop_down_widget.dart';
import 'package:dinamik_not_hesapla/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(Sabitler.baslikText, style: Sabitler.baslikStyle),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildForm(),
                ),
                Expanded(
                  flex: 1,
                  child: OrtalamaGoster(
                      dersSayisi: DataHelper.tumEklenenDersler.length,
                      ortalama: DataHelper.ortalamaHesapla()),
                ),
              ],
            ),
            Expanded(child: DersListesi(onElemanCikarildi: (index) {
              DataHelper.tumEklenenDersler.removeAt(index);
              setState(() {});
            })),
          ],
        ));
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
              padding: Sabitler.yatayPadding8, child: _buildTextFormField()),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                    padding: Sabitler.yatayPadding8,
                    child: HarfDropDownWidget(
                      onHarfSecildi: (harf) {
                        secilenHarfDegeri = harf;
                      },
                    )),
              ),
              Expanded(
                  child: Padding(
                      padding: Sabitler.yatayPadding8,
                      child: KrediDropDownWidget(onKrediSecildi: (kredi) {
                        secilenKrediDegeri = kredi;
                      }))),
              IconButton(
                  onPressed: () => _dersEkleVeOrtalamaHesapla(),
                  icon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Sabitler.anaRenk,
                  ),
                  iconSize: 30),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (newValue) {
        girilenDersAdi = newValue!;
      },
      validator: ((s) {
        if (s!.isEmpty) {
          return "Ders adını giriniz";
        } else {
          return null;
        }
      }),
      decoration: InputDecoration(
        hintText: "Ex: Math",
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
      ),
    );
  }

  _dersEkleVeOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDersAdi = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDersAdi);
      setState(() {});
    }
  }
}
