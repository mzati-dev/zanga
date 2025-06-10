import 'package:flutter/material.dart';
//import 'package:zanga/models/group.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final List<Group> _groups = [
    Group(
      id: '1',
      name: 'Family Group',
      lastMessage: 'Alice: See you tomorrow',
      time: 'Yesterday',
      unread: false,
      members: 8,
      image: 'assets/group_icon.jpg',
    ),
    Group(
      id: '2',
      name: 'Work Team',
      lastMessage: 'Meeting at 2pm',
      time: 'Mar 14',
      unread: true,
      members: 12,
      image: 'assets/work_group.jpg',
    ),
    Group(
      id: '3',
      name: 'College Friends',
      lastMessage: 'John: Party this weekend?',
      time: 'Mar 10',
      unread: false,
      members: 15,
      image: 'assets/friends_group.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: 'Search groups...',
          //       prefixIcon: const Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                return _buildGroupItem(_groups[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateGroupDialog(context);
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.group_add, color: Colors.white),
      ),
    );
  }

  Widget _buildGroupItem(Group group) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(group.image),
      ),
      title: Text(
        group.name,
        style: TextStyle(
          fontWeight: group.unread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        '${group.lastMessage} • ${group.members} members',
        style: TextStyle(
          fontWeight: group.unread ? FontWeight.bold : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            group.time,
            style: TextStyle(
              fontSize: 12,
              color: group.unread ? Colors.green : Colors.grey,
              fontWeight: group.unread ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (group.unread)
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
        // Open group chat screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatScreen(group: group),
          ),
        );
      },
    );
  }

  void _showCreateGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String groupName = '';
        return AlertDialog(
          title: const Text('Create New Group'),
          content: TextField(
            onChanged: (value) => groupName = value,
            decoration: const InputDecoration(
              hintText: 'Enter group name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (groupName.isNotEmpty) {
                  // Create new group logic here
                  setState(() {
                    _groups.insert(
                      0,
                      Group(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: groupName,
                        lastMessage: 'Group created',
                        time: 'Just now',
                        unread: false,
                        members: 1,
                        image: 'assets/new_group.jpg',
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

class GroupChatScreen extends StatefulWidget {
  final Group group;

  const GroupChatScreen({super.key, required this.group});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<GroupMessage> _messages = [
    GroupMessage(
      text: 'Welcome to the group!',
      sender: 'Admin',
      time: '10:30 AM',
      isMe: false,
    ),
    GroupMessage(
      text: 'Hello everyone!',
      sender: 'You',
      time: '10:31 AM',
      isMe: true,
    ),
    GroupMessage(
      text: 'Hi there!',
      sender: 'John',
      time: '10:32 AM',
      isMe: false,
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          GroupMessage(
            text: _messageController.text,
            sender: 'You',
            time: 'Just now',
            isMe: true,
          ),
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
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(widget.group.image),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.group.name),
                const Text('Online', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'info') {
                _showGroupInfo();
              } else if (value == 'exit') {
                // Handle exit group
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  const PopupMenuItem(value: 'info', child: Text('Group Info')),
                  const PopupMenuItem(value: 'exit', child: Text('Exit Group')),
                ],
          ),
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

  Widget _buildMessageBubble(GroupMessage message) {
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
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!message.isMe)
              Text(
                message.sender,
                style: TextStyle(
                  color: message.isMe ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
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

  void _showGroupInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(widget.group.image),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    widget.group.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Group Members',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/user1.jpg'),
                  ),
                  title: const Text('You'),
                  subtitle: const Text('Admin'),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/user2.jpg'),
                  ),
                  title: const Text('John Mwangi'),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/user3.jpg'),
                  ),
                  title: const Text('Sarah Smith'),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Add members functionality
                  },
                  child: const Text('Add Members'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Group {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;
  final int members;
  final String image;

  Group({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.members,
    required this.image,
  });
}

class GroupMessage {
  final String text;
  final String sender;
  final String time;
  final bool isMe;

  GroupMessage({
    required this.text,
    required this.sender,
    required this.time,
    required this.isMe,
  });
}
