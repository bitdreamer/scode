// main.dart
// Barrett Koster  2025
// Scode - a program for practicing Morse Code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';

import "tap_state.dart";

void main()
{ runApp(Scode());
}

class Scode extends StatelessWidget
{ Scode({super.key});
  final AudioPlayer ap = AudioPlayer();
  final AssetSource ass = AssetSource("beep2.mp3");

  @override
  Widget build(BuildContext context)
  { return MaterialApp
    ( title: 'Scode',
      home: BlocProvider<TapCubit>
      ( create: (context) => TapCubit(),
        child: BlocBuilder<TapCubit,TapState>
        ( builder: (context,state) => Scode2( ap, ass ),
        ),
      ),
    );
  }
}

class Scode2 extends StatelessWidget
{
  final AudioPlayer ap;
  final AssetSource ass;
  Scode2( this.ap, this.ass );

  @override
  Widget build(BuildContext context)
  { TapCubit tc = BlocProvider.of<TapCubit>(context);
    return Scaffold
    (
      appBar: AppBar( title: Text("Scode"), ),
      body: GestureDetector
      ( onTapDown: (_) { ap.play(ass); tc.tapDown(); },
        onTapUp:   (_) { ap.stop();    tc.tapUp(); },
        child: Column
        ( children:
          [  Container
            ( width: 200, height:200,
              decoration: BoxDecoration( border: Border.all(width:1) ),
              child: Text("tap here"),
            ),
            Text(tc.state.letter),
          ],
        ),
      ),
    );
  }
}

