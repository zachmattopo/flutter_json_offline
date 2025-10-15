import 'package:flutter/material.dart';
import 'all_posts_page.dart';
import 'bookmarked_posts_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Posts'),
              Tab(text: 'Bookmarked'),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            AllPostsPage(),
            BookmarkedPostsPage(),
          ],
        ),
      ),
    );
  }
}