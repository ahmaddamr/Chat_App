import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
      const ChatBuble({
    super.key,
    required this.message
  });
  
  final Message message ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // width: 150,
        padding: const  EdgeInsets.only(left: 16 , top: 20 , bottom: 20 , right: 16) ,
        // height: 60,
        // alignment: Alignment.centerLeft,
        margin: const  EdgeInsets.all(10),
        decoration: const  BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32)
          ),
          color: Color(0xffAE00FD)
        ) ,
        child: Text(message.message,
        style:  TextStyle(
          color: Colors.white
        ),),
      ),
    );
  }
}

class ChatBubleOther extends StatelessWidget {
      const ChatBubleOther({
    super.key,
    required this.message
  });
  
  final Message message ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // width: 150,
        padding: const  EdgeInsets.only(left: 16 , top: 20 , bottom: 20 , right: 16) ,
        // height: 60,
        // alignment: Alignment.centerLeft,
        margin: const  EdgeInsets.all(10),
        decoration: const  BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32)
          ),
          color: Color.fromARGB(255, 148, 34, 38)
        ) ,
        child: Text(message.message,
        style:  TextStyle(
          color: Colors.white
        ),),
      ),
    );
  }
}