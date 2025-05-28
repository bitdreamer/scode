
import "package:flutter_bloc/flutter_bloc.dart";

const int thresh = 200;

class TapState
{
  DateTime dt;  // last time something happened.
  String letter; // letter being formed ".--."
  String word; // word being formed "cra"



  TapState( this.dt, this.letter, this.word );
}

class TapCubit extends Cubit<TapState>
{
  TapCubit() : super( TapState( DateTime.now(), "", "" )  );

  void tapDown()
  { // DateTime dtold = state.dt;
    DateTime dt = DateTime.now();
    emit( TapState(dt, state.letter, state.word ) );
  }

  // when the mouse button goes up, this is the end of a 
  // beep, short of long.  Figure out which, then add to
  // letter.
  void tapUp()
  { DateTime dtold = state.dt;
    DateTime dt = DateTime.now();
    Duration dur = dt.difference(dtold);
    String dd = " ";
    if ( dur.inMilliseconds > thresh )  { dd = "-"; }
    else { dd = "."; }
    String letter = state.letter + dd;
    emit( TapState(dt, letter, state.word) );
    oneSpace();
  }

  // oneSpace() waits for 'thresh' milliseconds and then,
  // if another beep has not been started, this is the
  // end of a letter, so we look up which letter, put it
  // in word, and reset 'letter'.
  Future<void> oneSpace() async
  { TapState ts = state;
    await Future.delayed( const Duration(milliseconds:thresh) );
    await Future.delayed( const Duration(seconds:1) );
    if ( state==ts ) // no new state has been generated
    { String tr = samt2a[state.letter] ?? "¿";
      String word = state.word + tr;
      emit(TapState(state.dt,"",word));
    }
  }

  Map<String,String> samt2a = 
  { ".-"  : "a",
    "-...": "b",
    "-.-.": "c",
    "-..": "d",
    ".": "e",
    "..-.": "f",
    "--.": "g",
    "....": "h",
    "..": "i",
    ".---": "j",
    "-.-": "k",
    ".-..": "l",
    "--": "m",
    "-.": "n",
    "---": "o",
    ".--.": "p",
    "--.-": "q",
    ".-.": "r",
    "...": "s",
    "-": "t",
    "..-": "u",
    "...-": "v",
    ".--": "w",
    "-..-": "x",
    "-.--": "y",
    "--..": "z",

    ".----": "1",
    "..---": "2",
    "...--": "3",
    "....-": "4",
    ".....": "5",
    "-....": "6",
    "--...": "7",
    "---..": "8",
    "----.": "9",
    "-----": "0",

    ".-.-.-": ".",
    "--..--": ",",
    "..--..": "?",
    "-..-.": "/",
  };
}