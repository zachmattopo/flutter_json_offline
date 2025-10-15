import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/post_repository.dart';
import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final PostRepository repository;
  final int postId;

  CommentsCubit(this.repository, this.postId) : super(CommentsInitial()) {
    loadComments();
  }

  Future<void> loadComments() async {
    try {
      emit(CommentsLoading());
      final comments = await repository.getPostComments(postId);
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }
}