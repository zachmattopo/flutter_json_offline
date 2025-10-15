import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/post_repository.dart';
import '../../l10n/app_localizations.dart';
import '../cubits/post_detail_cubit/post_detail_cubit.dart';
import '../cubits/post_detail_cubit/post_detail_state.dart';
import '../cubits/bookmark_cubit/bookmark_cubit.dart';
import 'comments_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postRepository = context.read<PostRepository>();
    
    return BlocProvider(
      create: (context) => PostDetailCubit(postRepository),
      child: _DetailsPageContent(),
    );
  }
}

class _DetailsPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['id'] != null) {
      context.read<PostDetailCubit>().loadPost(args['id']);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.postDetails),
        actions: [
          BlocBuilder<PostDetailCubit, PostDetailState>(
            builder: (context, state) {
              if (state is PostDetailLoaded) {
                return BlocBuilder<BookmarkCubit, BookmarkState>(
                  builder: (context, bookmarkState) {
                    final isBookmarked = context.read<BookmarkCubit>().isBookmarked(state.post.id);
                    return IconButton(
                      icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                      tooltip: isBookmarked ? AppLocalizations.of(context)!.removeBookmark : AppLocalizations.of(context)!.addBookmark,
                      onPressed: () {
                        context.read<BookmarkCubit>().toggleBookmark(state.post);
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<PostDetailCubit, PostDetailState>(
        builder: (context, state) {
          if (state is PostDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostDetailLoaded) {
            return SafeArea(
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
                        state.post.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.post.body,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is PostDetailError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return Center(child: Text(AppLocalizations.of(context)!.pleaseWait));
        },
      ),
      floatingActionButton: BlocBuilder<PostDetailCubit, PostDetailState>(
        builder: (context, state) {
          return state is PostDetailLoaded
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(
                          postId: state.post.id,
                        ),
                      ),
                    );
                  },
                  tooltip: AppLocalizations.of(context)!.seeComments,
                  icon: const Icon(Icons.comment),
                  label: Text(AppLocalizations.of(context)!.comments),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
