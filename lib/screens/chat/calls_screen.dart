import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  final List<Call> _recentCalls = [
    Call(
      name: 'Alice Meya',
      time: 'Today, 2:45 PM',
      type: CallType.outgoing,
      status: CallStatus.missed,
      isGroupCall: false,
    ),
    Call(
      name: 'John Mwangi',
      time: 'Today, 1:15 PM',
      type: CallType.incoming,
      status: CallStatus.answered,
      isGroupCall: false,
    ),
    Call(
      name: 'Work Team',
      time: 'Yesterday, 5:00 PM',
      type: CallType.incoming,
      status: CallStatus.answered,
      isGroupCall: true,
    ),
    Call(
      name: 'Sarah Smith',
      time: 'Yesterday, 10:00 AM',
      type: CallType.outgoing,
      status: CallStatus.answered,
      isGroupCall: false,
    ),
    Call(
      name: 'Family Group',
      time: 'March 15, 9:00 AM',
      type: CallType.incoming,
      status: CallStatus.missed,
      isGroupCall: true,
    ),
    Call(
      name: 'David Manja',
      time: 'March 14, 3:00 PM',
      type: CallType.outgoing,
      status: CallStatus.declined,
      isGroupCall: false,
    ),
  ];

  void _showNewCallOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.call),
                title: const Text('New Voice Call'),
                onTap: () {
                  Navigator.pop(bc);
                  // TODO: Implement logic for initiating a new voice call
                  _initiateNewCall(context, CallType.outgoing, isVideo: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('New Video Call'),
                onTap: () {
                  Navigator.pop(bc);
                  // TODO: Implement logic for initiating a new video call
                  _initiateNewCall(context, CallType.outgoing, isVideo: true);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.video_call,
                ), // Changed to Icons.video_call for consistency
                title: const Text('Create Meeting'),
                onTap: () {
                  Navigator.pop(bc);
                  _createMeeting(context); // Correctly call _createMeeting
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _initiateNewCall(
    BuildContext context,
    CallType type, {
    bool isVideo = false,
  }) {
    // This is where you'd navigate to a contact selection screen
    // or directly initiate a call to a predefined contact for demonstration.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Initiating new ${isVideo ? "video" : "voice"} call...'),
      ),
    );
    // In a real app, you would navigate to a screen to select contacts
    // and then initiate the call.
  }

  void _createMeeting(BuildContext context) {
    // This is a unique feature: a simple meeting creation flow.
    // In a real app, this would involve more complex logic
    // for setting meeting details, inviting participants, and generating a link.
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Create New Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Meeting Title (Optional)',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext); // Close dialog
                  // Simulate meeting link creation and sharing
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Meeting link created and copied!'),
                    ),
                  );
                },
                child: const Text('Generate Meeting Link'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _recentCalls.isEmpty
              ? const Center(child: Text('No recent calls'))
              : Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align title to the start
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Recent Calls',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    // Wrap ListView.builder with Expanded
                    child: ListView.builder(
                      itemCount: _recentCalls.length,
                      itemBuilder: (context, index) {
                        final call = _recentCalls[index];
                        return _buildCallItem(call);
                      },
                    ),
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewCallOptions(context),
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add_call,
          color: Colors.white,
        ), // A more specific icon for new call/meeting
      ),
    );
  }

  Widget _buildCallItem(Call call) {
    IconData icon;
    Color iconColor;

    switch (call.status) {
      case CallStatus.missed:
        icon = Icons.call_missed;
        iconColor = Colors.red;
        break;
      case CallStatus.declined:
        icon = Icons.call_end;
        iconColor = Colors.red;
        break;
      case CallStatus.answered:
        icon =
            call.type == CallType.incoming
                ? Icons.call_received
                : Icons.call_made;
        iconColor = Colors.green;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage:
            call.isGroupCall
                ? const AssetImage(
                  'assets/group_icon.jpg',
                ) // Assuming you have a group call image
                : const AssetImage(
                  'assets/user1.jpg',
                ), // Placeholder user image
      ),
      title: Text(
        call.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 4),
          Text(call.time, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
      trailing: SizedBox(
        // Use SizedBox to give the Row a defined width
        width: 90, // Adjust this width as needed to prevent overflow
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              // Wrap the first IconButton with Expanded
              child: IconButton(
                icon: Icon(
                  call.isGroupCall ? Icons.video_call : Icons.videocam,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  // Handle video call
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Starting video call with ${call.name}'),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              // Wrap the second IconButton with Expanded
              child: IconButton(
                icon: const Icon(Icons.call, color: Colors.blueGrey),
                onPressed: () {
                  // Handle voice call
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Starting voice call with ${call.name}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // View call details or initiate a call back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on call with ${call.name}')),
        );
      },
    );
  }
}

enum CallType { incoming, outgoing }

enum CallStatus { missed, answered, declined }

class Call {
  final String name;
  final String time;
  final CallType type;
  final CallStatus status;
  final bool isGroupCall;

  Call({
    required this.name,
    required this.time,
    required this.type,
    required this.status,
    this.isGroupCall = false,
  });
}
