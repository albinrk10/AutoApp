import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../domain/models/message.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/chat/her_message_bubble.dart';
import '../../widgets/chat/my_message_bubble.dart';
import '../../widgets/shared/message_field.dart';



class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        //back home
       

        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://img2.freepng.es/20181201/xwx/kisspng-technical-support-computer-icons-application-softw-5c02c5b352d088.0481706015436855553392.jpg'),
          ),
        ),
        
        title: const Text('Soporte'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Aquí puede agregar la lógica para mostrar la ayuda
                Navigator.pushNamed(context, 'home');
            },
          ),
        ],
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message=chatProvider.messageList[index];
                return(message.fromwho==Fromwho.hers)
                ? HerMessageBubble(message:message)
                : MyMessageBubble(message:message);
              },
            )),
            
            //Caja de texto 
             MessageFieldBox(
              //onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
             ),
          ],
          
        ),
      ),
    );
  }
}