import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ZShortsScreen extends StatefulWidget {
  const ZShortsScreen({super.key});

  @override
  State<ZShortsScreen> createState() => _ZShortsScreenState();
}

class _ZShortsScreenState extends State<ZShortsScreen> {
  final List<ShortVideo> _videos = [
    ShortVideo(
      id: '1',
      username: 'john_mwangi',
      caption: 'Beautiful sunset at the beach 🌅 #nature #sunset',
      likes: '12.5K',
      comments: '1.2K',
      shares: '543',
      songName: 'Original Sound - John Mwangi',
      videoUrl: 'assets/videos/sunset.mp4',
      userImage: 'assets/user1.jpg',
    ),
    ShortVideo(
      id: '2',
      username: 'sarah_smith',
      caption: 'Morning workout routine 💪 #fitness #morning',
      likes: '8.7K',
      comments: '876',
      shares: '321',
      songName: 'Workout Music - Fitness Beats',
      videoUrl: 'assets/videos/workout.mp4',
      userImage: 'assets/user2.jpg',
    ),
    ShortVideo(
      id: '3',
      username: 'david_manja',
      caption: 'Trying this new recipe 👨‍🍳 #cooking #foodie',
      likes: '15.2K',
      comments: '2.1K',
      shares: '890',
      songName: 'Cooking Vibes - David Manja',
      videoUrl: 'assets/videos/cooking.mp4',
      userImage: 'assets/user3.jpg',
    ),
  ];

  late PageController _pageController;
  final ImagePicker _picker = ImagePicker();
  File? _recordedVideo;
  late List<VideoPlayerController> _videoControllers;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers =
        _videos.map((video) {
          return VideoPlayerController.asset(video.videoUrl);
        }).toList();

    // Initialize all video controllers
    for (var controller in _videoControllers) {
      controller.initialize();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFE3F2FD),
      backgroundColor: Colors.teal,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return _buildVideoPlayer(_videos[index], _videoControllers[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recordVideo,
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildVideoPlayer(ShortVideo video, VideoPlayerController controller) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player
        Chewie(
          controller: ChewieController(
            videoPlayerController: controller,
            autoPlay: true,
            looping: true,
            showControls: false,
            allowFullScreen: false,
            allowMuting: true,
            aspectRatio: 9 / 16,
          ),
        ),

        // Video Overlay UI
        _buildVideoOverlay(video),
      ],
    );
  }

  Widget _buildVideoOverlay(ShortVideo video) {
    return Column(
      children: [
        // Removed the top bar completely as requested

        // Spacer
        const Spacer(),

        // Right Sidebar (Like, Comment, Share, etc.)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // User Avatar
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(video.userImage),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(Icons.favorite, color: Colors.white, size: 30),
                  const SizedBox(height: 4),
                  Text(
                    video.likes,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.comment, color: Colors.white, size: 30),
                  const SizedBox(height: 4),
                  Text(
                    video.comments,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.share, color: Colors.white, size: 30),
                  const SizedBox(height: 4),
                  Text(
                    video.shares,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.music_note, color: Colors.white, size: 30),
                ],
              ),
            ],
          ),
        ),

        // Bottom Section (Username, Caption, Song)
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${video.username}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(video.caption, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    video.songName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _recordVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );

    if (video != null) {
      setState(() {
        _recordedVideo = File(video.path);
      });

      // Show preview and posting options
      _showVideoPreview(_recordedVideo!);
    }
  }

  void _showVideoPreview(File videoFile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Preview
              Expanded(
                child: FutureBuilder(
                  future: _initializeVideoPlayer(
                    ShortVideo(
                      id: 'new',
                      username: 'You',
                      caption: '',
                      likes: '0',
                      comments: '0',
                      shares: '0',
                      songName: 'Original Sound',
                      videoUrl: videoFile.path,
                      userImage: 'assets/current_user.jpg',
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Chewie(
                        controller: ChewieController(
                          videoPlayerController:
                              snapshot.data as VideoPlayerController,
                          autoPlay: true,
                          looping: true,
                          aspectRatio: 9 / 16,
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),

              // Caption Input
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a caption...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // Post Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Here you would typically upload the video to your backend
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Video posted successfully'),
                      ),
                    );
                  },
                  child: const Text('Post Z-Short'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<VideoPlayerController> _initializeVideoPlayer(ShortVideo video) async {
    VideoPlayerController controller;

    if (video.videoUrl.contains('assets/')) {
      controller = VideoPlayerController.asset(video.videoUrl);
    } else {
      controller = VideoPlayerController.file(File(video.videoUrl));
    }

    await controller.initialize();
    return controller;
  }
}

class ShortVideo {
  final String id;
  final String username;
  final String caption;
  final String likes;
  final String comments;
  final String shares;
  final String songName;
  final String videoUrl;
  final String userImage;

  ShortVideo({
    required this.id,
    required this.username,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.songName,
    required this.videoUrl,
    required this.userImage,
  });
}
