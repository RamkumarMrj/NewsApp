import 'package:flutter/material.dart';

import 'chat_api.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() async {
    String userMessage = _textController.text;
    _textController.clear();
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
    });
    // // Simulate API call (replace with actual API integration)
    // await Future.delayed(const Duration(seconds: 1));
    // // String aiResponse = await ChatAPI.sendMessage(userMessage);
    // String aiResponse = "This is a simulated AI response.";
    // setState(() {
    //   _messages.add(ChatMessage(text: aiResponse, isUser: false));
    // });
    try {
      String aiResponse = await ChatAPI.sendMessage(userMessage);
      setState(() {
        _messages.add(ChatMessage(text: aiResponse, isUser: false));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: 'Error: $e', isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: message.isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

