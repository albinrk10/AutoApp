import 'package:flutter/material.dart';


class NotificationsService {


  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();


  static showSnackbar( String message ) {

    final snackBar =  const SnackBar(
      content: Text(
         'Verificar su correo o contraseña',
        // message,
          style: TextStyle( color: Colors.white, fontSize: 20) ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);

  }


}