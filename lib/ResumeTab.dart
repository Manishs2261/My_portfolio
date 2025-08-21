import 'package:flutter/material.dart';


class ResumeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resume Title
          Text(
            'Resume',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),

          SizedBox(height: 8),

          // Yellow underline
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(2)),
          ),

          SizedBox(height: 60),

          _buildSection(
            icon: Icons.work,
            title: 'Experience',
            items: [
              _buildExperienceItem(
                position: "Software Developer",
                company: "RIVERHOUSE TECHNOLOGY",
                duration: "9 mos",
                period: "Mar, 2024 — Nov, 2024",
                location: "Bhilai (C.G)",
                lineHeight: 465,
                projects: [
                  {
                    'title': "Wiki-Fortune App Redesign & Optimization",
                    'responsibilities': [
                      'Overhauled app UI by updating outdated components to a new, modern design, '
                          'improving user experience and visual appeal.',
                      'Identified and resolved multiple critical bugs, leading to improved app '
                          'stability and smoother functionality.',
                      'Worked closely with UI/UX designers to ensure alignment with brand aesthetics '
                          'and enhanced user engagement.',
                    ],
                  },
                  {
                    'title': "Collegiate Backer – Crowdfunding Platform for Athletes",
                    'responsibilities': [
                      "Developed a crowdfunding application that allows users to financially support "
                          "athletes aiming for international competition.",
                      " Implemented secure Stripe-based payment processing and distribution system, "
                          "ensuring smooth and reliable financial transactions",
                      " Integrated Firebase for real-time database management, authentication, and "
                          "cloud storage, providing a seamless, scalable backend infrastructure.",
                      " Optimized user authentication flows, resulting in faster, secure user onboarding and account access.",
                    ],
                  },
                ],
              ),
              _buildExperienceItem(
                position: "Flutter Developer",
                company: "FIXINGDOTS",
                duration: "Present",
                period: "Nov, 2024 - Present",
                location: "Raipur (C.G)",
                lineHeight: 270,
                projects: [
                  {
                    'title': "FixHR Employee Management App",
                    'responsibilities': [
                      ' Fixed critical bugs to improve app stability and performance.',
                      'Implemented new features, including:\n'
                          ' - Calendar integration for attendance and scheduling.\n'
                          ' - Background location fetching for employee tracking.',
                      ' Enhanced existing codebase for better readability, maintainability, and efficiency',
                      'Managed app deployment and updates on:  Google Play Store (Android), Apple'
                          ' App Store (iOS)',
                    ],
                  },
                ],
              ),
              _buildExperienceItem(
                position: "Flutter Developer",
                company: "Self Project",
                duration: "Present",
                period: "Sep,2023 - Present",
                location: "Raipur (C.G)",
                lineHeight: 270,
                projects: [
                  {
                    'title': "Room Rent Search App (Appixo)",
                    'responsibilities': [
                      'Frontend Development: Proficient in Flutter, creating interactive and responsive user interfaces. ',
                      'Backend Implementation: Experienced in Dart for seamless API integration '
                          'and efficient database operations.',
                      'Database Management: Utilized Firebase to store and manage product information and user data.',
                      'State management  using Getx.',
                      ' User authentication :  Implemented secure user authentication and '
                          'authorization using Firebase Auth.',
                      'Features : Login and Sign-up, Forget Password, Post your room and tiffin '
                          'services, Edit user posts, Call now, One-time user rating, Rating '
                          'summary',
                      'GitHub  : https://github.com/Manishs2261/PgRoomApp',
                      'Play Store : https://play.google.com/store/apps/details?id=com.manishsahu'
                          '.myappixo.app',
                    ],
                  },
                ],
              ),
            ],
          ),
          SizedBox(height: 60),

          // Education Section
          _buildSection(
            icon: Icons.school,
            title: 'Education',
            items: [
              _buildEducationItem(
                institution: 'Guru Ghasidas Central University, Bilaspur,',
                degree: "Bachelor degree, computer science and information technology (Honors)",
                duration: '2020 — 2023',
                lineHeight: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.amber, size: 24),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),

        SizedBox(height: 40),

        // Timeline Items
        ...items,
      ],
    );
  }

  Widget _buildEducationItem({
    required String institution,
    required String degree,
    required String duration,
    double? lineHeight,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot and line
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
              ),
              Container(width: 2, height: lineHeight ?? 80, color: Color(0xFF3A3A3A)),
            ],
          ),

          SizedBox(width: 20),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  institution,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(degree, style: TextStyle(fontSize: 16, color: Colors.white70)),
                SizedBox(height: 8),
                Text(
                  duration,
                  style: TextStyle(fontSize: 14, color: Colors.amber, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem({
    required String position,
    required String company,
    required String duration,
    required String period,
    required String location,
    double? lineHeight,
    required List<Map<String, dynamic>> projects, // multiple projects
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot and line
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
              ),
              Container(width: 2, height: lineHeight ?? 200, color: Color(0xFF3A3A3A)),
            ],
          ),

          SizedBox(width: 20),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(company, style: TextStyle(fontSize: 16, color: Colors.white70)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 16),

                // Loop through projects
                ...projects.map((project) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['title'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 4),
                      ...project['responsibilities']
                          .map<Widget>(
                            (responsibility) => Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  responsibility,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .toList(),
                      SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}