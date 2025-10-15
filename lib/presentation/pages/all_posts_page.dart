import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../cubits/posts_cubit/posts_cubit.dart';
import '../cubits/posts_cubit/posts_state.dart';
import '../../data/models/post.dart';

class AllPostsPage extends StatelessWidget {
  const AllPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return _buildPostsList(context, state.posts);
          } else if (state is PostsError) {
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
    );
  }

  Widget _buildPostsList(BuildContext context, List<Post> posts) {
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
              Navigator.of(context).pushNamed(
                'details/',
                arguments: {'id': post.id},
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
                  const SizedBox(height: 8),
                  Text(post.body),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
