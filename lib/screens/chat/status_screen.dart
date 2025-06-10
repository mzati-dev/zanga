import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final List<Status> _statusUpdates = [
    Status(
      id: '1',
      userName: 'John Mwangi',
      time: '10 minutes ago',
      imageUrl: 'assets/user1.jpg',
      isViewed: false,
    ),
    Status(
      id: '2',
      userName: 'Sarah Smith',
      time: '25 minutes ago',
      imageUrl: 'assets/user2.jpg',
      isViewed: true,
    ),
    Status(
      id: '3',
      userName: 'Work Team',
      time: '1 hour ago',
      imageUrl: 'assets/work_group.jpg',
      isViewed: false,
      isGroup: true,
    ),
    Status(
      id: '4',
      userName: 'David Manja',
      time: '2 hours ago',
      imageUrl: 'assets/user3.jpg',
      isViewed: true,
    ),
  ];

  File? _myStatusImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildMyStatus(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent updates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _statusUpdates.length,
              itemBuilder: (context, index) {
                return _buildStatusItem(_statusUpdates[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'status_text',
            mini: true,
            onPressed: () {
              _createTextStatus();
            },
            backgroundColor: Colors.blueGrey[200],
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'status_camera',
            onPressed: () {
              _createImageStatus();
            },
            backgroundColor: Colors.blueGrey,
            child: const Icon(Icons.camera_alt, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMyStatus() {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage:
                _myStatusImage != null
                    ? FileImage(_myStatusImage!)
                    : const AssetImage('assets/current_user.jpg')
                        as ImageProvider,
          ),
          if (_myStatusImage == null)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ),
        ],
      ),
      title: const Text(
        'My Status',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _myStatusImage == null ? 'Tap to add status update' : 'Today, 12:30 PM',
      ),
      onTap: () {
        if (_myStatusImage != null) {
          _viewStatus(
            Status(
              id: '0',
              userName: 'My Status',
              time: 'Just now',
              imageUrl: _myStatusImage!.path,
              isViewed: true,
            ),
          );
        } else {
          _createImageStatus();
        }
      },
    );
  }

  Widget _buildStatusItem(Status status) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: status.isViewed ? Colors.grey : Colors.green,
            width: 2,
          ),
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundImage:
              status.isGroup
                  ? const AssetImage('assets/group_icon.jpg')
                  : AssetImage(status.imageUrl),
        ),
      ),
      title: Text(
        status.userName,
        style: TextStyle(
          fontWeight: status.isViewed ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(status.time, style: const TextStyle(fontSize: 12)),
      onTap: () {
        _viewStatus(status);
      },
    );
  }

  Future<void> _createImageStatus() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _myStatusImage = File(image.path);
      });
      // Here you would typically upload the status to your backend
    }
  }

  void _createTextStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String statusText = '';
        return AlertDialog(
          title: const Text('Create Text Status'),
          content: TextField(
            onChanged: (value) => statusText = value,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Type your status here...',
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
                if (statusText.isNotEmpty) {
                  // Here you would typically post the text status to your backend
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Status updated')),
                  );
                }
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }

  void _viewStatus(Status status) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StatusViewScreen(status: status)),
    );

    // Mark as viewed if it's not the user's own status
    if (status.id != '0') {
      setState(() {
        status.isViewed = true;
      });
    }
  }
}

class StatusViewScreen extends StatelessWidget {
  final Status status;

  const StatusViewScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          status.userName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Center(
        child:
            status.imageUrl.contains('assets/')
                ? Image.asset(status.imageUrl, fit: BoxFit.contain)
                : Image.file(File(status.imageUrl), fit: BoxFit.contain),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Send message',
            hintStyle: const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {},
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Status {
  final String id;
  final String userName;
  final String time;
  final String imageUrl;
  bool isViewed;
  final bool isGroup;

  Status({
    required this.id,
    required this.userName,
    required this.time,
    required this.imageUrl,
    this.isViewed = false,
    this.isGroup = false,
  });
}
