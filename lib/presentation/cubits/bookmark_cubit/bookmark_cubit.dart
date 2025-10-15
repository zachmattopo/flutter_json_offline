import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/post.dart';
import '../../../data/repositories/bookmark_repository.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final BookmarkRepository _bookmarkRepository;

  BookmarkCubit(this._bookmarkRepository) : super(BookmarkInitial()) {
    init();
  }

  Future<void> init() async {
    await _bookmarkRepository.init();
    emit(BookmarkLoaded(_bookmarkRepository.getAllBookmarkedPosts()));
  }

  Future<void> toggleBookmark(Post post) async {
    emit(BookmarkLoading());
    await _bookmarkRepository.toggleBookmark(post);
    emit(BookmarkLoaded(_bookmarkRepository.getAllBookmarkedPosts()));
  }

  bool isBookmarked(int postId) {
    return _bookmarkRepository.isBookmarked(postId);
  }

  List<Post> getBookmarkedPosts() {
    return _bookmarkRepository.getAllBookmarkedPosts();
  }
}
