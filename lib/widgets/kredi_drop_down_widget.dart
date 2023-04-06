import 'package:dinamik_not_hesapla/constans/app_constants.dart';
import 'package:dinamik_not_hesapla/helper/data_helper.dart';
import 'package:flutter/material.dart';

class KrediDropDownWidget extends StatefulWidget {
  final Function onKrediSecildi;
  const KrediDropDownWidget({required this.onKrediSecildi, super.key});

  @override
  State<KrediDropDownWidget> createState() => _KrediDropDownWidgetState();
}

class _KrediDropDownWidgetState extends State<KrediDropDownWidget> {
  double secilenKrediDegeri = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
          
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade400,
        items: DataHelper.tumDerslerinKredileri(),
        onChanged: (value) {
          setState(() {
            secilenKrediDegeri = value!;
            widget.onKrediSecildi(value );
          });
        },
        underline: Container(),
      ),
    );
  }
}