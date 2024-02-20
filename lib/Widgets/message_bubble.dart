import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? text;
  final String? sender;
  final bool? isMe;
  const MessageBubble({super.key, this.text, this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender!,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Wrap(
            children: [
              Material(
                elevation: 5.0,
                borderRadius: isMe!
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                color: isMe! ? Colors.lightBlueAccent : Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    text!,
                    style: TextStyle(
                        fontSize: 20,
                        color: isMe! ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
