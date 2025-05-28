
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

  void tapUp()
  { DateTime dtold = state.dt;
    DateTime dt = DateTime.now();
    Duration dur = dt.difference(dtold);
    String dd = " ";
    if ( dur.inMilliseconds > thresh )  { dd = "-"; }
    else { dd = "."; }
    String letter = state.letter + dd;
    emit( TapState(dt, letter, state.word) );
  }
}