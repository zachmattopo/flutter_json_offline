import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/post_repository.dart';
import '../cubits/comments_cubit/comments_cubit.dart';
import '../cubits/comments_cubit/comments_state.dart';

class CommentsPage extends StatelessWidget {
  final int postId;

  const CommentsPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postRepository = context.read<PostRepository>();

    return BlocProvider(
      create: (context) => CommentsCubit(postRepository, postId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: BlocBuilder<CommentsCubit, CommentsState>(
          builder: (context, state) {
            if (state is CommentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommentsLoaded) {
              return SafeArea(
                bottom: false,
                top: false,
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.account_circle),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    comment.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              comment.body,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CommentsError) {
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
            return const Center(child: Text('Loading comments...'));
          },
        ),
      ),
    );
  }
}
