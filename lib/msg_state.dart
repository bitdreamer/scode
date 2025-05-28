
import 'package:flutter_bloc/flutter_bloc.dart';

class MsgState
{
  String msg;
  MsgState( this.msg );
}

class MsgCubit extends Cubit<MsgState>
{
  MsgCubit() : super( MsgState("") );
  
  void add(String w) { emit( MsgState( state.msg + w) ); }
}