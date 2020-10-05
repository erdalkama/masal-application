import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

typedef void OnError(Exception exception);
AudioPlayer advancedPlayer;
AudioCache audioCache;
AnimationController _animationController;
Duration _duration = new Duration();
Duration _position = new Duration();
String sesAdi;
bool isPlaying = false;
AudioPlayer audioPlayer = AudioPlayer();
class DinlemeSayfasi extends StatefulWidget {
  String kitapAdi;
  String kitapResmi;
  DinlemeSayfasi(String _kitapAdi, String _kitapResmi, String _sesAdi) {
    kitapAdi = _kitapAdi;
    kitapResmi = _kitapResmi;
    sesAdi = _sesAdi;
  }

  @override
  _DinlemeSayfasi createState() =>
      _DinlemeSayfasi(kitapAdi, kitapResmi, sesAdi);
}

class _DinlemeSayfasi extends State<DinlemeSayfasi> {
  _DinlemeSayfasi(String _kitapAdi, String _kitapResmi, String _sesAdi) {
    kitapAdi = _kitapAdi;
    kitapResmi = _kitapResmi;
    sesAdi = _sesAdi;
  }
  String kitapAdi;
  String kitapResmi;
  String sesAdi;

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isPlaying == true) {
          _animationController.reverse();
          advancedPlayer.pause();
        }
        return new Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Color(0xFFD12828),
        appBar:
            AppBar(title: Text(kitapAdi), centerTitle: true, actions: <Widget>[
        
        ]),
        bottomNavigationBar: new BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new IconButton(
                  icon: new Icon(
                    Icons.fast_rewind,
                    color: Colors.red.shade700,
                  ),
                  iconSize: 40.0,
                  onPressed: () {
                    Duration tmp = new Duration(seconds: 10);
                    if (_position > tmp) {
                      _position = _position - tmp;
                      advancedPlayer.positionHandler(_position);
                      seekToSecond(_position.inSeconds);
                    } else {
                      _position = Duration(seconds: 0);
                      advancedPlayer.positionHandler(_position);
                      seekToSecond(_position.inSeconds);
                    }
                  },
                ),
              ),
              PlayButton(),
              new IconButton(
                icon: new Icon(
                  Icons.fast_forward,
                  color: Colors.red.shade700,
                ),
                iconSize: 40.0,
                onPressed: () {
                  Duration tmp = new Duration(seconds: 7);
                  if (_position + tmp < _duration) {
                    _position += tmp;
                    advancedPlayer.positionHandler(_position);
                    seekToSecond(_position.inSeconds);
                  }
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: new Image.asset(
                kitapResmi,
                fit: BoxFit.fitWidth,
              ),
            ),
            new Container(
                alignment: Alignment.topCenter,
                child:Text(
                  _position.toString().split('.').first.padLeft(8, "0"),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  textAlign: TextAlign.center,
                  
                ),
               
              
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }



  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }
}

class PlayButton extends StatefulWidget {
  //https://gist.githubusercontent.com/bimsina/a23920ba16381f8abd85b00d93a81e29/raw/18d4ff838164e30166573f496aaab3e13032cb4f/animated_icon_demo.dart
  //https://medium.com/@bimsina/animated-icons-in-flutter-3ca7e921500a
  @override
  _PlayButton createState() => _PlayButton();
}

class _PlayButton extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animationController,
          color: Colors.red.shade700),
      onPressed: () => _handleOnPressed(),
    );
  }
    void _handleOnPressed() async{
    setState(() {
      isPlaying = !isPlaying;

      if (isPlaying == true) {
        //play
        _animationController.forward();
        audioCache.play(sesAdi);

        
      } else {
        //pause
        _animationController.reverse();
        advancedPlayer.pause();
      }
    });
  }
}
