import 'package:chat_app/models/message_model.dart' as chat;
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    int prevUserId = -1;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: user.name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: user.isOnline ? 'online' : 'offline',
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chat.messages.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                final chat.Message message = chat.messages[index];
                final bool isMe = currentUser.id == message.sender.id;
                final bool isSameUser = prevUserId == message.sender.id;
                prevUserId = message.sender.id;
                return _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  Widget _chatBubble(chat.Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(message.sender.imageUrl),
                      ),
                    )
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(message.sender.imageUrl),
                      ),
                    )
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  Widget _sendMessageArea() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        color: Colors.white,
        height: 75,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
                iconSize: 25,
                color: Theme.of(context).primaryColor),
            Expanded(
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message...'),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
                iconSize: 25,
                color: Theme.of(context).primaryColor),

          ],
        ));
  }
}
