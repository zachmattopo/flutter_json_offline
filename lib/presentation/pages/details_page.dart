import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/post_repository.dart';
import '../cubits/post_detail_cubit/post_detail_cubit.dart';
import '../cubits/post_detail_cubit/post_detail_state.dart';
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
        title: const Text('Post details'),
      ),
      body: BlocBuilder<PostDetailCubit, PostDetailState>(
        builder: (context, state) {
          if (state is PostDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostDetailLoaded) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
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
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Please wait...'));
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
                  tooltip: 'Comments',
                  icon: const Icon(Icons.comment),
                  label: const Text('Comments'),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
