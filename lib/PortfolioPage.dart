import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<PortfolioItem> portfolioItems = [
    PortfolioItem(
      title: 'APPIXO',
      category: 'Android Application',
      imagePath: 'assets/images/appixo.png',
      backgroundColor: Colors.white,
      url:
          'https://play.google.com/store/apps/details?id=com.manishsahu.myappixo.app&pcampaignid=web_share',
    ),
    PortfolioItem(
      title: 'Fix Hr',
      category: 'Android & IOS',
      imagePath: 'assets/images/fixhr.png',
      backgroundColor: Colors.white,
      url: 'https://play.google.com/store/apps/details?id=com.fd.fixHR&hl=en_IN',
    ),
    PortfolioItem(
      title: 'Collegiate Backer',
      category: 'Application & Web',
      imagePath: 'assets/images/Collegiate.png',
      backgroundColor: Colors.white,
      url: 'https://app.collegiatebacker.com/',
    ),
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Portfolio',
          style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),

        // Yellow underline
        Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(2)),
        ),

        const SizedBox(height: 40),

        // Portfolio Grid
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children:
              portfolioItems.map((item) {
                return PortfolioCard(
                  item: item,
                  onTap: () {
                    _launchURL(item.url);
                  },
                );
              }).toList(),
        ),
        SizedBox(
          height: 400,
        )
      ],
    );
  }


}

class PortfolioItem {
  final String title;
  final String category;
  final String imagePath;
  final Color backgroundColor;
  final String url;

  PortfolioItem({
    required this.title,
    required this.category,
    required this.imagePath,
    required this.backgroundColor,
    required this.url,
  });
}

class PortfolioCard extends StatelessWidget {
  final PortfolioItem item;
  final VoidCallback onTap;

  const PortfolioCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              color: item.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(item.imagePath),
          ),
          Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(item.category, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
