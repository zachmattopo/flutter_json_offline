import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/bookmark_cubit/bookmark_cubit.dart';
import '../../data/models/post.dart';
import '../../l10n/app_localizations.dart';
import 'bookmarked_details_page.dart';

class BookmarkedPostsPage extends StatelessWidget {
  const BookmarkedPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BookmarkedPostsView();
  }
}

class BookmarkedPostsView extends StatelessWidget {
  const BookmarkedPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookmarkLoaded) {
            return _buildPostsList(context, state.bookmarkedPosts);
          }
          return Center(child: Text(AppLocalizations.of(context)!.noBookmarkedPosts));
        },
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, List<Post> posts) {
    if (posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context)!.noBookmarkedPosts,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookmarkedDetailsPage(post: post),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
