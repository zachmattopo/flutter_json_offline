import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/post_repository.dart';
import 'post_detail_state.dart';

// Cubit
class PostDetailCubit extends Cubit<PostDetailState> {
  final PostRepository repository;

  PostDetailCubit(this.repository) : super(PostDetailInitial());

  Future<void> loadPost(int id) async {
    try {
      emit(PostDetailLoading());
      final post = await repository.getPostById(id);
      emit(PostDetailLoaded(post));
    } catch (e) {
      emit(PostDetailError(e.toString()));
    }
  }
}