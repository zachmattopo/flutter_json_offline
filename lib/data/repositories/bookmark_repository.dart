import 'package:hive/hive.dart';
import '../models/post.dart';

class BookmarkRepository {
  static const String _boxName = 'bookmarkedPosts';
  late Box<Post> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Post>(_boxName);
  }

  Future<void> toggleBookmark(Post post) async {
    if (isBookmarked(post.id)) {
      await removeBookmark(post.id);
    } else {
      await addBookmark(post);
    }
  }

  Future<void> addBookmark(Post post) async {
    await _box.put(post.id, post);
  }

  Future<void> removeBookmark(int postId) async {
    await _box.delete(postId);
  }

  bool isBookmarked(int postId) {
    return _box.containsKey(postId);
  }

  List<Post> getAllBookmarkedPosts() {
    return _box.values.toList();
  }
}