// main.dart
// Barrett Koster  2025
// Scode - a program for practicing Morse Code

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';

void main()
{ runApp(Scode());
}

class Scode extends StatelessWidget
{ Scode({super.key});

  @override
  Widget build(BuildContext context)
  { return MaterialApp
    ( title: 'Scode',
      home:  Scode2( ),
    );
  }
}

class Scode2 extends StatefulWidget
{
  @override
  State<Scode2> createState() => Scode3();
}

class Scode3 extends State<Scode2> 
{
  final AudioPlayer ap = AudioPlayer();
  final AssetSource ass = AssetSource("beep2.mp3");


  @override
  Widget build(BuildContext context)
  { 
    return Scaffold
    (
      appBar: AppBar( title: Text("Scode"), ),
      body: GestureDetector
      ( onTapDown: (_) { ap.play(ass); },
        onTapUp:   (_) { ap.stop();     },
        child: Column
        ( children:
          [  Container
            ( width: 200, height:200,
              decoration: BoxDecoration( border: Border.all(width:1) ),
              child: Text("tap here"),
            ),
            
          ],
        ),
      ),
    );
  }
}
