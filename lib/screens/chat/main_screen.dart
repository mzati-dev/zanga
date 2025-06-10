import 'package:flutter/material.dart';
import 'package:zanga/screens/chat/calls_screen.dart';
import 'package:zanga/screens/chat/group_screen.dart';
import 'package:zanga/screens/chat/status_screen.dart';
import 'package:zanga/screens/market/market_screen.dart';
import 'package:zanga/screens/public/public_screen.dart';
import 'package:zanga/screens/wallet/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _chatTabController;
  late TabController _publicTabController;
  late TabController _walletTabController;
  late TabController _marketTabController;

  int _currentBottomIndex = 0;
  bool _showChatScreen = false;
  String _currentChatId = '';

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _chatTabController = TabController(length: 5, vsync: this);
    _publicTabController = TabController(length: 4, vsync: this);
    _walletTabController = TabController(length: 4, vsync: this);
    _marketTabController = TabController(length: 5, vsync: this);

    _chatTabController.addListener(_onChatTabChanged);

    _screens = [
      ChatMainScreen(),
      TabBarView(
        controller: _publicTabController,
        children: const [
          PublicScreen(contentType: PublicContentType.status),
          PublicScreen(contentType: PublicContentType.zShorts),
          PublicScreen(contentType: PublicContentType.zPicks),
          PublicScreen(contentType: PublicContentType.categories),
        ],
      ),
      TabBarView(
        controller: _walletTabController,
        children: const [
          ZWalletScreen(contentType: WalletContentType.myWallet),
          ZWalletScreen(contentType: WalletContentType.groupWallet),
          ZWalletScreen(contentType: WalletContentType.insights),
          ZWalletScreen(contentType: WalletContentType.rewards),
        ],
      ),
      TabBarView(
        controller: _marketTabController,
        children: const [
          ZMarketScreen(contentType: MarketContentType.all),
          ZMarketScreen(contentType: MarketContentType.categories),
          ZMarketScreen(contentType: MarketContentType.topDeals),
          ZMarketScreen(contentType: MarketContentType.services),
          ZMarketScreen(contentType: MarketContentType.myListings),
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _chatTabController.removeListener(_onChatTabChanged);
    _chatTabController.dispose();
    _publicTabController.dispose();
    _walletTabController.dispose();
    _marketTabController.dispose();
    super.dispose();
  }

  void _onChatTabChanged() {
    setState(() {});
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
      appBar:
          _currentBottomIndex == 0
              ? _buildChatAppBar()
              : _currentBottomIndex == 1
              ? _buildPublicAppBar()
              : _currentBottomIndex == 2
              ? _buildWalletAppBar()
              : _currentBottomIndex == 3
              ? _buildMarketAppBar()
              : _buildChatAppBar(),
      body: _screens[_currentBottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) {
          setState(() {
            _currentBottomIndex = index;
            if (index == 0) {
              _chatTabController.index = 0;
            } else if (index == 1) {
              _publicTabController.index = 0;
            } else if (index == 2) {
              _walletTabController.index = 0;
            } else if (index == 3) {
              _marketTabController.index = 0;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFE3F2FD),
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  _currentBottomIndex == 0
                      ? BoxDecoration(
                        color: const Color(0xFF00796B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      )
                      : null,
              child: const Icon(Icons.chat),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  _currentBottomIndex == 1
                      ? BoxDecoration(
                        color: const Color(0xFF00796B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      )
                      : null,
              child: const Icon(Icons.public),
            ),
            label: 'Public',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  _currentBottomIndex == 2
                      ? BoxDecoration(
                        color: const Color(0xFF00796B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      )
                      : null,
              child: const Icon(Icons.account_balance_wallet),
            ),
            label: 'Z-Wallet',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  _currentBottomIndex == 3
                      ? BoxDecoration(
                        color: const Color(0xFF00796B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      )
                      : null,
              child: const Icon(Icons.shopping_bag),
            ),
            label: 'Z-Market',
          ),
        ],
      ),
    );
  }

  bool _isSearching = false;

  AppBar _buildPublicAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text('Public'),
      actions: [
        // 🔍 Search Icon
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching; // Toggle search bar visibility
            });
          },
        ),
        // 🔔 Notification Icon with badge
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification button press
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: const Text(
                  '3', // Replace with dynamic count
                  style: TextStyle(color: Colors.white, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        // ⋮ Popup menu
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          offset: const Offset(0, 40),
          onSelected: (value) {},
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'settings', child: Text('Settings')),
                const PopupMenuItem(value: 'logout', child: Text('Logout')),
              ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize:
            _isSearching
                ? const Size.fromHeight(100)
                : const Size.fromHeight(50),
        child: Column(
          children: [
            // 👇 Show search bar only when _isSearching is true
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            // 👇 Always show tab bar
            Container(
              color: Colors.blueGrey,
              child: TabBar(
                controller: _publicTabController,
                isScrollable: false,
                labelPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.amber[400],
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Z-Shorts'),
                  Tab(text: 'Z-Picks'),
                  Tab(text: 'Categories'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isWalletSearchActive = false; // Add this to your state

  AppBar _buildWalletAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text('Z-Wallet'),
      actions: [
        // Added search icon to the left of notifications
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isWalletSearchActive = !_isWalletSearchActive;
            });
          },
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification button press
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: const Text(
                  '3', // Replace with dynamic count
                  style: TextStyle(color: Colors.white, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          offset: const Offset(0, 40),
          onSelected: (value) {},
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'settings', child: Text('Settings')),
                const PopupMenuItem(value: 'logout', child: Text('Logout')),
              ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize:
            _isWalletSearchActive
                ? const Size.fromHeight(100)
                : const Size.fromHeight(48),
        child: Column(
          children: [
            if (_isWalletSearchActive)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            Container(
              color: Colors.blueGrey,
              child: TabBar(
                controller: _walletTabController,
                isScrollable: false,
                labelPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.amber[400],
                tabs: const [
                  Tab(text: 'My Wallet'),
                  Tab(text: 'Group Wallet'),
                  Tab(text: 'Insights'),
                  Tab(text: 'Rewards'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isMarketSearchActive = false; // Add this to your state

  AppBar _buildMarketAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text('Z-Market'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isMarketSearchActive = !_isMarketSearchActive;
            });
          },
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification button press
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: const Text(
                  '3', // Replace with dynamic count
                  style: TextStyle(color: Colors.white, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          offset: const Offset(0, 40),
          onSelected: (value) {},
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'settings', child: Text('Settings')),
                const PopupMenuItem(value: 'logout', child: Text('Logout')),
              ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize:
            _isMarketSearchActive
                ? const Size.fromHeight(100)
                : const Size.fromHeight(48),
        child: Column(
          children: [
            if (_isMarketSearchActive)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            Container(
              color: Colors.blueGrey,
              child: TabBar(
                controller: _marketTabController,
                isScrollable: false,
                labelPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.amber[400],
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Categories'),
                  Tab(text: 'Top Deals'),
                  Tab(text: 'Services'),
                  Tab(text: 'MyListings'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isChatSearchActive = false; // Add this to your state

  AppBar _buildChatAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      title: _showChatScreen ? const Text('Chat') : const Text('Zanga'),
      leading:
          _showChatScreen
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _closeChat,
              )
              : null,
      actions: [
        if (!_showChatScreen)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isChatSearchActive = !_isChatSearchActive;
              });
            },
          ),
        if (!_showChatScreen)
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle notification button press
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Text(
                    '3', // Replace with dynamic count
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        if (!_showChatScreen)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            offset: const Offset(0, 40),
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
              : PreferredSize(
                preferredSize:
                    _isChatSearchActive
                        ? const Size.fromHeight(100)
                        : const Size.fromHeight(48),
                child: Column(
                  children: [
                    if (_isChatSearchActive)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    TabBar(
                      controller: _chatTabController,
                      isScrollable: false,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.7,
                      ),
                      indicatorColor: Colors.amber[400],
                      tabs: const [
                        Tab(text: 'Chats'),
                        Tab(text: 'Groups'),
                        Tab(text: 'Status'),
                        Tab(text: 'Calls'),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  @override
  Widget build(BuildContext context) {
    final _MainScreenState? parent =
        context.findAncestorStateOfType<_MainScreenState>();
    final TabController? chatTabController = parent?._chatTabController;

    if (chatTabController == null) {
      return const Center(child: Text("Error: TabController not found."));
    }

    return TabBarView(
      controller: chatTabController,
      children: [
        _ChatListScreen(),
        const GroupScreen(),
        const StatusScreen(),

        const CallsScreen(),
      ],
    );
  }
}

class _ChatListScreen extends StatefulWidget {
  const _ChatListScreen({super.key});

  @override
  State<_ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<_ChatListScreen> {
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
      name: 'Mwayi Tembo',
      lastMessage: 'appy birthday?',
      time: 'Mar 12',
      unread: false,
      isOnline: true,
    ),
    Chat(
      id: '5',
      name: 'David Manja',
      lastMessage: 'Did you see the news?',
      time: 'Mar 10',
      unread: false,
      isOnline: true,
    ),
    Chat(
      id: '5',
      name: 'Alice Meya',
      lastMessage: 'When will you come?',
      time: 'Mar 10',
      unread: false,
      isOnline: true,
    ),
    Chat(
      id: '5',
      name: 'James Banda',
      lastMessage: 'Did you see the news?',
      time: 'Mar 10',
      unread: false,
      isOnline: true,
    ),
    Chat(
      id: '5',
      name: 'Natasha Mkweza',
      lastMessage: 'Merry Chrismas',
      time: 'Mar 10',
      unread: false,
      isOnline: true,
    ),
    Chat(
      id: '5',
      name: 'George Manda',
      lastMessage: 'I am back',
      time: 'Mar 10',
      unread: false,
      isOnline: true,
    ),
    Chat(
      id: '5',
      name: 'Mary Kaunda',
      lastMessage: 'I am going to school now',
      time: 'Mar 10',
      unread: true,
      isOnline: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          return _buildChatItem(_chats[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
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
        if (chat.isGroup) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => GroupChatScreen(
                    group: Group(
                      id: chat.id,
                      name: chat.name,
                      lastMessage: chat.lastMessage,
                      time: chat.time,
                      unread: chat.unread,
                      members: 0,
                      image: 'assets/group_icon.jpg',
                    ),
                  ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chatId: chat.id),
            ),
          );
        }
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

class GroupChatScreen extends StatelessWidget {
  final Group group;

  const GroupChatScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(group.name)),
      body: Center(child: Text('Group Chat with ${group.name}')),
    );
  }
}
