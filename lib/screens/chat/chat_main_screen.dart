import 'package:flutter/material.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  final List<Chat> _chats = [
    Chat(
      id: '1',
      name: 'John Mwangi',
      lastMessage: 'Hi there!',
      time: '10:30 AM',
      unread: true,
      isOnline: true,
    ),
    Chat(
      id: '2',
      name: 'Family Group',
      lastMessage: 'Alice: See you tomorrow',
      time: 'Yesterday',
      unread: false,
      isGroup: true,
    ),
    Chat(
      id: '3',
      name: 'Sarah Smith',
      lastMessage: 'Thanks for the help!',
      time: 'Mar 15',
      unread: false,
    ),
    Chat(
      id: '4',
      name: 'Work Team',
      lastMessage: 'Meeting at 2pm',
      time: 'Mar 14',
      unread: true,
      isGroup: true,
    ),
    Chat(
      id: '5',
      name: 'David Johnson',
      lastMessage: 'Did you see the news?',
      time: 'Mar 10',
      unread: false,
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          // Status view (like WhatsApp)
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStatusItem(isMe: true),
                _buildStatusItem(name: 'John', seen: true),
                _buildStatusItem(name: 'Sarah', seen: false),
                _buildStatusItem(name: 'Mike', seen: true),
                _buildStatusItem(name: 'Family', isGroup: true),
              ],
            ),
          ),

          // Chats list
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return _buildChatItem(_chats[index]);
              },
            ),
          ),
        ],
      ),

      // Floating action button for new chat
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open new chat screen
        },
        backgroundColor: const Color(0xFF00796B),
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildStatusItem({
    bool isMe = false,
    String? name,
    bool seen = false,
    bool isGroup = false,
  }) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    isMe
                        ? const AssetImage('assets/current_user.jpg')
                        : isGroup
                        ? const AssetImage('assets/group_icon.jpg')
                        : const AssetImage('assets/user1.jpg'),
                child: isMe ? const Icon(Icons.add, size: 20) : null,
              ),
              if (!isMe && !isGroup)
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: seen ? Colors.grey : Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            isMe ? 'My Status' : name ?? '',
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(Chat chat) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage:
                chat.isGroup
                    ? const AssetImage('assets/group_icon.jpg')
                    : const AssetImage('assets/user1.jpg'),
          ),
          if (chat.isOnline && !chat.isGroup)
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
        ],
      ),
      title: Text(
        chat.name,
        style: TextStyle(
          fontWeight: chat.unread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: TextStyle(
          fontWeight: chat.unread ? FontWeight.bold : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.time,
            style: TextStyle(
              fontSize: 12,
              color: chat.unread ? Colors.green : Colors.grey,
              fontWeight: chat.unread ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (chat.unread)
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Open chat screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen(chatId: chat.id)),
        );
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message(text: 'Hi there!', isMe: false, time: '10:30 AM'),
    Message(text: 'Hello! How are you?', isMe: true, time: '10:31 AM'),
    Message(
      text: 'I was wondering if we could meet tomorrow?',
      isMe: false,
      time: '10:32 AM',
    ),
    Message(
      text: 'Sure, what time works for you?',
      isMe: true,
      time: '10:33 AM',
    ),
    Message(
      text: 'How about 2pm at the coffee shop?',
      isMe: false,
      time: '10:35 AM',
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          Message(text: _messageController.text, isMe: true, time: 'Just now'),
        );
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00796B),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/user1.jpg'),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('John Mwangi'),
                Text('Online', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              message.isMe
                  ? const Color(0xFF00796B).withOpacity(0.8)
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                fontSize: 10,
                color: message.isMe ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
          IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
        ],
      ),
    );
  }
}

class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;
  final bool isOnline;
  final bool isGroup;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = false,
    this.isOnline = false,
    this.isGroup = false,
  });
}

class Message {
  final String text;
  final bool isMe;
  final String time;

  Message({required this.text, required this.isMe, required this.time});
}
