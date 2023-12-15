import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  
  TextEditingController controller = TextEditingController() ;
  final _controller = ScrollController() ;
  static String id = 'ChatPage' ;

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Create a CollectionReference called users that references the firestore collection
      CollectionReference messages = FirebaseFirestore.instance.collection(collections);


  @override
  Widget build(BuildContext context) {
    var email =ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(order , descending: true).snapshots() ,
      builder: (context , snapshot)
      {
        // print(snapshot.data!['messages']) ;
        // print(snapshot.data!.docs[0]['message']) ;g
        if (snapshot.hasData) {
          List<Message> messageList = [] ;
          for (int i = 0 ; i < snapshot.data!.docs.length ; i++ )
          {
            messageList.add(Message.fromjson(snapshot.data!.docs[i])) ;
          }
          return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffAE00FD),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Applogo
            , height: 95,),
      const Text('ChatApp',
      style: TextStyle(
          fontWeight: FontWeight.bold
      ),)
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true ,
              controller: _controller ,
              itemCount: messageList.length,
              itemBuilder: (context , index)
            {
              return messageList[index].id == email ?
                ChatBuble(
                  message: messageList[index],)
                : ChatBubleOther(message: messageList[index]) ;
            }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller ,
              onSubmitted:(value) {
                messages.add({
                  kmessage : value ,
                  order : DateTime.now(),
                  'id' : email
                }) ;
                controller.clear() ;
                _controller.animateTo(
    0,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 500),
  );                
              }, 
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffAE00FD) ,
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  contentPadding: EdgeInsets.all(18),
                  filled: true,
                  labelText: 'Message'  ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      suffixIcon: Icon(Icons.send_outlined ,
                      color: Color(0xffAE00FD), )
                ),
            ),
          )
        ],
      )
      ,
    );
        }else
        {
          return Center(child: Text('loading ....')) ;
        }
      },
    ) ;
  }
}

