import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/post_repository.dart';
import 'posts_state.dart';

// Cubit
class PostsCubit extends Cubit<PostsState> {
  final PostRepository repository;

  PostsCubit(this.repository) : super(PostsInitial());

  Future<void> loadPosts() async {
    try {
      emit(PostsLoading());
      final posts = await repository.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}