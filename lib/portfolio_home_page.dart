// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/academicons.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:portfolio/blog_page.dart';
import 'package:portfolio/portfolio_page.dart';
import 'package:portfolio/resume_tab.dart';


class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  int selectedIndex = 0;

  final List<String> navItems = ['About', 'Resume', 'Portfolio', 'Blog',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sidebar
          Container(
            width: 350,
            margin: EdgeInsets.only(left: 200),
            height: double.infinity,
            child: _buildSidebar(),
          ),
          // Main Content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20, right: 200, bottom: 20),
              padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF3A3A3A), width: 1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:  MainAxisSize.min,
                  children: [
                    // Navigation
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children:
                      navItems.asMap().entries.map((entry) {
                        int index = entry.key;
                        String item = entry.value;
                        bool isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 30),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                              isSelected
                                  ? Colors.amber.withValues( alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                color: isSelected ? Colors.amber : Colors.white70,
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 40),

                    if (selectedIndex == 0)
                      buildAboutTab()
                    else if (selectedIndex == 1)
                      ResumeTab()
                    else if(selectedIndex == 2)
                        PortfolioPage()
                      else if(selectedIndex == 3)
                          BlogPage(mediumUsername: 'manish2261',)
                      else
                        SizedBox.shrink(),

                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        SizedBox(height: 8),

        // Yellow underline
        Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(2)),
        ),

        SizedBox(height: 30),

        // Description
        Text(
          '''
                            Hi, I'm Manish — a Flutter developer who loves turning ideas into smooth, beautiful mobile apps. I enjoy tackling complex problems, whether it's designing intuitive UIs, optimizing performance, or integrating APIs that just work. Beyond coding, I've also worked with numbers through accounting and finance, so I bring an extra layer of precision and analytical thinking to every project. When I'm not coding, you'll probably find me exploring new tech tools, refining my designs, or learning something that makes me a better creator.
                                      ''',
          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white70),
        ),

        SizedBox(height: 50),

        // What I'm Doing Section
        Text(
          'What I\'m Doing',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        SizedBox(height: 30),

        // Services Grid - Changed from Expanded to Container with height
        Wrap(
          children: [
            _buildServiceCard(
              icon: Icons.phone_android,
              title: 'Mobile Apps',
              description:
              'Design and develop high-performance, cross-platform mobile applications using Flutter. Focused on delivering intuitive UI/UX, smooth animations, and optimized performance for both Android and iOS. Skilled in integrating APIs, managing state efficiently, and implementing scalable architectures to ensure robust, maintainable apps.',
            ),
            _buildServiceCard(
              icon: Icons.code,
              title: 'Flutter Flow Developer',
              description:
              '''I build apps fast, clean, and aesthetic using FlutterFlow’s no-code magic. From concept to launch, I craft sleekUIs, hook up databases and APIs, and make sure everything runs smooth on both Android and iOS. Speed meets style, and the code’s ready to scale when you are.
                            ''',
            ),
          ],
        ),
        Text(
          'Skills',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        SizedBox(height: 30),

        Wrap(
          children: [
            _buildSkillCard(
              color: Color(0xFF4A90E2),
              icon: Icons.design_services,
              title: 'Design Tools',
              subtitle: 'UI/UX',
            ),
            _buildSkillCard(
              color: Color(0xFF42A5F5),
              icon: Icons.flutter_dash,
              title: 'Flutter',
              subtitle: 'Mobile Dev',
            ),
            _buildSkillCard(
              color: Color(0xFFFF9800),
              icon: Icons.local_fire_department,
              title: 'Firebase',
              subtitle: 'Backend',
            ),
            _buildSkillCard(
              color: Color(0xFFFF6B35),
              icon: Icons.code,
              title: 'Code Editor',
              subtitle: 'Development',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillCard({
    required Color color,
    IconData? icon,
    String? imagePath,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF4A4A4A), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues( alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
            imagePath != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain),
            )
                : Icon(icon!, color: color, size: 24),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF3A3A3A), width: 1),
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A4A4A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.person, size: 60, color: Colors.white70),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF2A2A2A), width: 3),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25),

          // Name
          Text(
            'Manish sahu',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8),

          // Title
          Text(
            'Software Developer',
            style: TextStyle(fontSize: 14, color: Colors.white60),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30),

          // Divider
          Container(
            height: 1,
            color: Color(0xFF3A3A3A),
            margin: EdgeInsets.symmetric(horizontal: 20),
          ),

          SizedBox(height: 30),

          // Contact Info
          _buildContactInfo(Icons.email_outlined, 'EMAIL', 'manishsahu2609@gmail.com'),

          SizedBox(height: 20),

          _buildContactInfo(Icons.phone_outlined, 'PHONE', '+91 7389523175'),

          SizedBox(height: 20),

          _buildContactInfo(Icons.location_on_outlined, 'LOCATION', 'Raipur, Chhattisgarh'),

          Spacer(),

          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              _buildSocialIcon(Bi.linkedin),
              _buildSocialIcon(Mdi.github),
              _buildSocialIcon(Academicons.stackoverflow_square),
              _buildSocialIcon(Ri.medium_fill),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF3A3A3A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.amber, size: 18),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 14, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Color(0xFF3A3A3A), borderRadius: BorderRadius.circular(8)),
      child: Iconify(icon, color: Colors.white.withValues(alpha: 0.5)),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFF3A3A3A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF3A3A3A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.amber, size: 24),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(description, style: TextStyle(fontSize: 14, color: Colors.white60, height: 1.4)),
        ],
      ),
    );
  }
}