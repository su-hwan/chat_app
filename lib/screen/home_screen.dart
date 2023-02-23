import 'package:flutter/material.dart';
import 'package:chat_app/models/message_model.dart' as message;

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: ListView.builder(
        itemCount: message.chats.length,
        itemBuilder: (BuildContext context, int index) {
          message.Message chat = message.chats[index];
          // print('chat.sender.name:${chat.sender.name}');
          // print('chat.sender.id:${chat.sender.id}');
          // print('chat.sender.imageUrl:${chat.sender.imageUrl}');
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(chat.sender),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  _widgetUserImage(chat),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(children: [
                      _widgetUserTitle(chat),
                      SizedBox(
                        height: 10,
                      ),
                      _widgetUserProfile(chat),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _widgetUserImage(message.Message chat) => Container(
        padding: EdgeInsets.all(2),
        decoration: chat.unread
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5),
                ],
              )
            : BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5),
                ],
              ),
        child: CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(chat.sender.imageUrl),
        ),
      );

  Widget _widgetUserTitle(message.Message chat) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    chat.sender.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chat.sender.isOnline
                      ? Container(
                          margin: EdgeInsets.only(left: 5),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container(
                          child: null,
                        ),
                ],
              ),
              Text(
                chat.time,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
            ],
          )
        ],
      );

  Widget _widgetUserProfile(message.Message chat) => Container(
        alignment: Alignment.topLeft,
        child: Text(
          chat.text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      );
}
