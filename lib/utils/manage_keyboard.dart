import 'package:flutter/material.dart';

//this class is used for foucing and unfoucsing keyboard through all over app. some time you move to other screen and your keyboard remains fouces to avoid that issue we will use below logic for foucing and foucing jsut by passing context.

class KeyBoardUtil{
  static void hideKeyBoard(BuildContext context){
    FocusScopeNode currentFoucs = FocusScope.of(context);
    if(!currentFoucs.hasPrimaryFocus){
      currentFoucs.unfocus();
    }
  }
}