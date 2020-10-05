import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'DinlemeSayfasi.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawermenu.dart';

final kitapIsimleri = [
  "SİHİRLİ BROKAR",
  "KRALIN MAAŞI",
  "TEMBEL TARO",
];
final kitapResimleri = [
  "assets/11111.png",
  "assets/1112.png",
  "assets/1113.png",
];
final kitapKayitlari = [
  "audio.mp3",
  "audio1.mp3",
  "audio2.mp3",
];

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}


class _AnaSayfaState extends State<AnaSayfa> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD12828),
      appBar: AppBar(
          title: Text(
            'MASAL APPLICATION',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _urlAcma(Platform.isAndroid
                    ? "https://play.google.com/store/apps/details?id=com.stajodevi.masal_application"
                    : "");
              },
              icon: Icon(Icons.star),
              tooltip: 'Puan Ver',
            ),
            IconButton(
              onPressed: () {
                Share.share(
                    """Masal Application Mobil uygulamamızı indirdiniz mi?\n Google Play Store: https://play.google.com/store/apps/details?id=com.stajodevi.masal_application""");
              },
              icon: Icon(Icons.share),
              tooltip: 'Paylaş',
            ),
          ]),
      body: new Center(//FOTOGRAF PLACEMENT
          child: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 1,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(kitapIsimleri.length, (index) {
          return Center(
            child: InkWell(
                child: Container(
                  child: Image.asset(kitapResimleri[index]),
                  width: MediaQuery.of(context).size.width * 0.88,
                ),//FOTOGRAF PLACEMENT
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DinlemeSayfasi(
                              kitapIsimleri[index],
                              kitapResimleri[index],
                              kitapKayitlari[index])));
                }),//DİNLEME SAYFASINA
          );
        }),
      )),
      drawer: DrawerMenu(),
    );
  }
}

/*class ListDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // itemCount : Listemizin uzunluğu
        itemCount: kitapIsimleri.length,
        // item Builder ile kolayca listemizin index değeri ile listemizi doldurduk
        itemBuilder: (context, index) {
          return ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(kitapResimleri[index]),
                width: MediaQuery.of(context).size.width * 0.45,
              ),
            ],
          ));
        },
      ),
    );
  }
}*/

Future _urlAcma(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    debugPrint('Gönderdiğiniz linki açamıyorum.');
  }
}
