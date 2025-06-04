import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentBottomIndex = 0;
  bool _showChatScreen = false;
  String _currentChatId = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'settings':
        break;
      case 'logout':
        Navigator.pushReplacementNamed(context, '/login');
        break;
    }
  }

  void _openChat(String chatId) {
    setState(() {
      _showChatScreen = true;
      _currentChatId = chatId;
    });
  }

  void _closeChat() {
    setState(() {
      _showChatScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showChatScreen ? const Text('Chat') : const Text('Zanga'),
        leading:
            _showChatScreen
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _closeChat,
                )
                : null,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          if (!_showChatScreen)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _onMenuItemSelected,
              itemBuilder:
                  (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'settings',
                      child: Text('Settings'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ],
            ),
        ],
        bottom:
            _showChatScreen
                ? null
                : TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  tabs: const [
                    Tab(text: 'Inbox'),
                    Tab(text: 'Groups'),
                    Tab(text: 'Status'),
                    Tab(text: 'Z-shorts'),
                    Tab(text: 'Calls'),
                  ],
                ),
      ),
      body:
          _showChatScreen
              ? ChatScreen(chatId: _currentChatId)
              : TabBarView(
                controller: _tabController,
                children: [
                  InboxScreen(onChatSelected: _openChat),
                  const GroupsScreen(),
                  const StatusScreen(),
                  const ZShortsScreen(),
                  const CallsScreen(),
                ],
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) => setState(() => _currentBottomIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Public'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Z-Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Z-Market',
          ),
        ],
      ),
    );
  }
}

// Inbox Screen with chat list
class InboxScreen extends StatelessWidget {
  final Function(String) onChatSelected;

  const InboxScreen({super.key, required this.onChatSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildChatItem('1', 'John', 'Hi', '10:30 AM', context),
        _buildChatItem('2', 'Sarah', 'Hello there!', '9:15 AM', context),
        _buildChatItem(
          '3',
          'Mike',
          'Thanks for the payment',
          'Yesterday',
          context,
        ),
        _buildChatItem(
          '4',
          'Zanga Support',
          'Your issue has been resolved',
          'Yesterday',
          context,
        ),
        _buildChatItem(
          '5',
          'Family Group',
          'Alice: See you tomorrow',
          'Monday',
          context,
        ),
      ],
    );
  }

  Widget _buildChatItem(
    String id,
    String name,
    String lastMessage,
    String time,
    BuildContext context,
  ) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Text(time, style: const TextStyle(color: Colors.grey)),
      onTap: () => onChatSelected(id),
    );
  }
}

// Chat Screen Implementation
class ChatScreen extends StatelessWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _ChatBubble(isMe: false, message: 'Hi there!', time: '10:30 AM'),
              _ChatBubble(
                isMe: true,
                message: 'Hello! How are you?',
                time: '10:31 AM',
              ),
              _ChatBubble(
                isMe: false,
                message:
                    'I\'m good, thanks for asking. Just wanted to check about the payment.',
                time: '10:32 AM',
              ),
              _ChatBubble(
                isMe: true,
                message: 'Yes, I sent it this morning. Did you receive it?',
                time: '10:33 AM',
              ),
              _ChatBubble(
                isMe: false,
                message: 'Yes, thanks I received the money',
                time: '10:35 AM',
              ),
            ],
          ),
        ),
        _ChatInputField(),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;

  const _ChatBubble({
    required this.isMe,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  _ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              // Send message logic
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder screens for other tabs
class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Groups Content'));
  }
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Status Content'));
  }
}

class ZShortsScreen extends StatelessWidget {
  const ZShortsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Z-shorts Content'));
  }
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Calls Content'));
  }
}
