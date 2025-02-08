import 'package:flutter/material.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);
  static const String routeName = '/support';

  @override
  State<CustomerSupport> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<CustomerSupport> {
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla quam eu facilisis mollis.', 'isOutgoing': false},
    {'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'isOutgoing': true},
    {'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla quam eu facilisis mollis.', 'isOutgoing': false},
    {'text': 'Lorem ipsum dolor sit amet.', 'isOutgoing': true},
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final newMessage = _messageController.text.trim();
    if (newMessage.isNotEmpty) {
      setState(() {
        _messages.add({'text': newMessage, 'isOutgoing': true});
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to the Profile Page
          },
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
        title: const Text(
          'Customer Support',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat Area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Column(
                  children: [
                    message['isOutgoing']
                        ? OutgoingMessage(message: message['text'])
                        : IncomingMessage(message: message['text']),
                    const SizedBox(height: 17),
                  ],
                );
              },
            ),
          ),
          // Message Input Area
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 20),
                      hintText: "Message here...",
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IncomingMessage extends StatelessWidget {
  final String message;
  const IncomingMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class OutgoingMessage extends StatelessWidget {
  final String message;
  const OutgoingMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}