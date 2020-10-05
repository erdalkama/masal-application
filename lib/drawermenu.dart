import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                      Colors.red[800],
                      Colors.red[800],
                    ])),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Material(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            elevation: 15,
                            child: Image.asset('assets/culogo.png',
                                width: 80, height: 80),
                          ),
                          Text(
                            '\n  ÇUKUROVA ÜNİVERSİTESİ\n BİLGİSAYAR MÜHENDİSLİĞİ\nERDAL KAMA STAJ PROJESİ',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.contactPhone),
                    title: Text(
                      'İLETİŞİM',
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.linkedinBox),
                    title: Text(
                      '   LINKEDIN',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _urlAcma('https://www.linkedin.com/in/erdalkama/');
                    },
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.school),
                    title: Text(
                      '   ÇUKUROVA ÜNİVERSİTESİ\n   BİLGİSAYAR MÜHENDİSLİĞİ\n   BÖLÜMÜ WEB SİTESİ',
                      textAlign: TextAlign.left,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _urlAcma('https://bmb.cu.edu.tr/');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future _urlAcma(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    debugPrint('Gönderdiğiniz linki açamıyorum.');
  }
}
