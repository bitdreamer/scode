
// import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "msg_state.dart";

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
  void tapUp( MsgCubit mc)
  { DateTime dtold = state.dt;
    DateTime dt = DateTime.now();
    Duration dur = dt.difference(dtold);
    String dd = " ";
    if ( dur.inMilliseconds > thresh )  { dd = "-"; }
    else { dd = "."; }
    String letter = state.letter + dd;
    emit( TapState(dt, letter, state.word) );
    smallSpace(mc);
  }

  // smallSpace() waits for 'thresh' milliseconds and then,
  // if another beep has not been started, this is the
  // end of a letter, so we look up which letter, put it
  // in word, and reset 'letter'.
  Future<void> smallSpace( MsgCubit mc) async
  { TapState ts = state;
    await Future.delayed( const Duration(milliseconds:thresh) );
    // await Future.delayed( const Duration(seconds:1) ); // debuggin
    if ( state==ts ) // no new state has been generated while we waited
    { String tr = samt2a[state.letter] ?? "¿";
      String word = state.word + tr;
      emit(TapState(state.dt,"",word));
      bigSpace(mc);
    }
  }

  // This is just like smallSpace, except that we are 
  // looking for a longer space, and if it occurs we
  // have the end of a word.  So add the word to the end
  // of the message and reset the word.
  Future<void> bigSpace( MsgCubit mc) async
  { TapState ts = state;
    await Future.delayed( const Duration(milliseconds:thresh*3) );
    await Future.delayed( const Duration(seconds:1) ); // debug
    if ( state==ts ) // no new state has been generated while we waited
    { mc.add(state.word+" ");
      emit(TapState(state.dt,"",""));
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