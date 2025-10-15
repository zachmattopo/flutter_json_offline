import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post.dart';
import '../cubits/bookmark_cubit/bookmark_cubit.dart';

class BookmarkedDetailsPage extends StatelessWidget {
  final Post post;

  const BookmarkedDetailsPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BookmarkedDetailsContent(post: post);
  }
}

class _BookmarkedDetailsContent extends StatelessWidget {
  final Post post;

  const _BookmarkedDetailsContent({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post details'),
        actions: [
          BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              final isBookmarked = context.read<BookmarkCubit>().isBookmarked(post.id);
              return IconButton(
                icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                tooltip: isBookmarked ? 'Remove Bookmark' : 'Add Bookmark',
                onPressed: () {
                  context.read<BookmarkCubit>().toggleBookmark(post);
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  post.body,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
