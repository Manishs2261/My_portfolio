import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Blog Post Model
class BlogPost {
  final String title;
  final String imageUrl;
  final String url;
  final String publishDate;
  final String description;

  BlogPost({
    required this.title,
    required this.imageUrl,
    required this.url,
    required this.publishDate,
    required this.description,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      title: json['title'] ?? 'No Title',
      imageUrl: json['thumbnail'] ?? 'https://via.placeholder.com/400x200',
      url: json['link'] ?? '',
      publishDate: json['pubDate'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

// Blog Service to fetch Medium RSS
class BlogService {
  static Future<List<BlogPost>> fetchMediumPosts(String mediumUsername) async {
    try {
      // Using RSS2JSON service to convert Medium RSS to JSON
      final url = 'https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/@$mediumUsername/feed';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List;

        return items.map((item) => BlogPost(
          title: item['title'] ?? 'No Title',
          imageUrl: _extractImageFromContent(item['content'] ?? ''),
          url: item['link'] ?? '',
          publishDate: _formatDate(item['pubDate'] ?? ''),
          description: _extractDescription(item['content'] ?? ''),
        )).toList();
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return [];
  }

  static String _extractImageFromContent(String content) {
    final regex = RegExp(r'<img[^>]+src="([^">]+)"');
    final match = regex.firstMatch(content);
    return match?.group(1) ?? 'https://via.placeholder.com/400x200';
  }

  static String _extractDescription(String content) {
    final regex = RegExp(r'<p>(.*?)</p>');
    final match = regex.firstMatch(content);
    final description = match?.group(1) ?? '';
    return description.replaceAll(RegExp(r'<[^>]*>'), '').substring(0,
        description.length > 150 ? 150 : description.length) + '...';
  }

  static String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  static String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}

// Main Blog Page
class BlogPage extends StatefulWidget {
  final String mediumUsername;

  const BlogPage({super.key, required this.mediumUsername});

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<BlogPost> posts = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => isLoading = true);
    final fetchedPosts = await BlogService.fetchMediumPosts(widget.mediumUsername);
    setState(() {
      posts = fetchedPosts;
      isLoading = false;
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  List<BlogPost> get filteredPosts {
    if (searchQuery.isEmpty) return posts;
    return posts.where((post) =>
    post.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        post.description.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Blog',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 30),

        // Search Bar
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2d2d2d),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            onChanged: (value) => setState(() => searchQuery = value),
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search blog posts...',
              hintStyle: TextStyle(color: Colors.white54),
              prefixIcon: Icon(Icons.search, color: Colors.white54),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Blog Posts Grid
        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: filteredPosts.length,
            itemBuilder: (context, index) {
              return BlogCard(
                post: filteredPosts[index],
                onTap: () => _launchUrl(filteredPosts[index].url),
              );
            },
          ),

        const SizedBox(height: 40),
      ],
    );
  }

}

// Blog Card Widget
class BlogCard extends StatefulWidget {
  final BlogPost post;
  final VoidCallback onTap;

  const BlogCard({super.key, required this.post, required this.onTap});

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _animationController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.withValues(alpha: 0.8),
                    Colors.blue.withValues(alpha: 0.6),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: width / 2,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.post.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[800],
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[800],
                            child: const Icon(Icons.image_not_supported, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category and Date
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues( alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AutoSizeText(
                                  'Blog',
                                  minFontSize: 4,   // never shrink smaller than 12
                                  maxFontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withValues( alpha: 0.9),

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              AutoSizeText(
                                widget.post.publishDate,
                                minFontSize: 4,   // never shrink smaller than 12
                                  maxFontSize : 18,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues( alpha: 0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Title
                          Expanded(
                            child: AutoSizeText(
                              widget.post.title,
                              minFontSize: 4,   // never shrink smaller than 12
                              maxFontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,

                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                              maxLines: 3,

                            ),
                          ),

                          // Description
                          const SizedBox(height: 8),
                          AutoSizeText(
                            widget.post.description,
                            minFontSize: 4,   // never shrink smaller than 12
                            maxFontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues( alpha: 0.8),

                              height: 1.4,
                            ),
                            maxLines: 2,

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


