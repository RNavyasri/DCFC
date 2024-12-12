import 'package:flutter/material.dart';

class EWasteBotScreen extends StatefulWidget {
  @override
  _EWasteBotScreenState createState() => _EWasteBotScreenState();
}

class _EWasteBotScreenState extends State<EWasteBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = []; // Stores conversation history

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({"user": message});
        _messages.add({"bot": _generateBotResponse(message)});
      });
      _messageController.clear();
    }
  }

  String _generateBotResponse(String userMessage) {
    // Simple bot logic
    if (userMessage.toLowerCase().contains("e-waste")) {
      return "E-waste refers to discarded electronic devices. Recycling helps reduce environmental harm!";
    } else if (userMessage.toLowerCase().contains("recycle")) {
      return "You can recycle e-waste at certified centers. Avoid dumping electronics in regular trash.";
    } else if (userMessage.toLowerCase().contains("harm")) {
      return "Improper disposal of e-waste can release toxic chemicals, harming soil and water.";
    } else {
      return "I'm here to help with any questions about e-waste! Please ask anything.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Waste Awareness Bot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index].containsKey("user");
                final message = isUser ? _messages[index]["user"] : _messages[index]["bot"];
                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    message!,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask about e-waste...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _sendMessage(_messageController.text),
                  child: Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
