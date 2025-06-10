import 'package:flutter/material.dart';
import 'package:zanga/screens/public/Categories/category_screen.dart';
import 'package:zanga/screens/public/zanga_pick_screen.dart';
import 'package:zanga/screens/public/zshort_screen.dart';

// Define an enum to represent the different content types
enum PublicContentType { status, zShorts, zPicks, categories }

class PublicScreen extends StatefulWidget {
  final PublicContentType contentType;

  const PublicScreen({super.key, required this.contentType});

  @override
  State<PublicScreen> createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    // Sample posts
    _posts.addAll([
      Post(
        userName: 'John Mwangi',
        userImage: 'assets/user1.jpg',
        content:
            'Looking for a reliable plumber in Nairobi area. Any recommendations?',
        time: '2 mins ago',
        likes: 5,
        comments: 3,
        shares: 1,
      ),
      Post(
        userName: 'Pastor David',
        userImage: 'assets/user2.jpg',
        content:
            'Blessed morning church! Today\'s sermon will be about forgiveness.',
        time: '1 hour ago',
        isAmen: true,
        amens: 24,
      ),
      Post(
        userName: 'Community Health',
        userImage: 'assets/user3.jpg',
        content: 'Free vaccination camp this Saturday at the county hospital.',
        time: '3 hours ago',
        likes: 42,
        comments: 7,
        shares: 15,
      ),
      Post(
        userName: 'Mary Wanjiku',
        userImage: 'assets/user4.jpg',
        content:
            'My son needs urgent surgery. Please support with any amount. M-Pesa: 0722123456',
        time: '5 hours ago',
        needsSupport: true,
        supporters: 8,
      ),
    ]);
  }

  void _createPost() {
    if (_postController.text.isNotEmpty) {
      setState(() {
        _posts.insert(
          0,
          Post(
            userName: 'You',
            userImage: 'assets/current_user.jpg',
            content: _postController.text,
            time: 'Just now',
            likes: 0,
            comments: 0,
          ),
        );
        _postController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine which content to display based on the contentType
    Widget currentContent;
    switch (widget.contentType) {
      case PublicContentType.status:
        currentContent = _buildStatusContent();
        break;
      case PublicContentType.zShorts:
        currentContent = ZShortsScreen(); // Use ZShortsScreen widget here
        break;
      case PublicContentType.zPicks:
        // Zanga Picks screen is attached here
        currentContent = ZangaPicksScreen();
        break;
      case PublicContentType.categories:
        // *** THIS IS WHERE CATEGORY SCREEN IS ATTACHED ***
        currentContent = const CategoryScreen();
        break;
    }

    return Column(
      children: [
        // Post creation area (only visible for Status tab if needed)
        if (widget.contentType == PublicContentType.status)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/current_user.jpg'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _postController,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.photo_library),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _createPost,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        // Display the content based on the selected tab
        Expanded(child: currentContent),
      ],
    );
  }

  // --- Content building methods for each "endpoint" ---

  Widget _buildStatusContent() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return _buildPost(_posts[index]);
      },
    );
  }

  Widget _buildZShortsContent() {
    return const Center(child: Text('This is the Z Shorts content.'));
  }

  // _buildZPicksContent() method is now removed as it's a separate screen

  // _buildCategoriesContent() method is now removed as it's a separate screen

  // Your existing _buildPost method
  Widget _buildPost(Post post) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(post.userImage)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.time,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            if (post.isAmen)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up, color: Colors.blue),
                    onPressed: () {},
                  ),
                  Text('${post.amens} amens'),
                ],
              )
            else if (post.needsSupport)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Support'),
                  ),
                  Text('${post.supporters} people supported'),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up),
                        onPressed: () {},
                      ),
                      Text('${post.likes}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {},
                      ),
                      Text('${post.comments}'),
                    ],
                  ),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String userName;
  final String userImage;
  final String content;
  final String time;
  final int likes;
  final int comments;
  final int shares;
  final bool isAmen;
  final int amens;
  final bool needsSupport;
  final int supporters;

  Post({
    required this.userName,
    required this.userImage,
    required this.content,
    required this.time,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isAmen = false,
    this.amens = 0,
    this.needsSupport = false,
    this.supporters = 0,
  });
}
