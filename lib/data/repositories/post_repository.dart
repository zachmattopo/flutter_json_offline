import '../models/post.dart';
import '../models/comment.dart';
import '../services/http_service.dart';

class PostRepository {
  final HttpService _httpService;

  PostRepository({HttpService? httpService}) 
      : _httpService = httpService ?? HttpService();

  Future<List<Post>> getPosts() async {
    try {
      final jsonList = await _httpService.getList('/posts');
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<Post> getPostById(int id) async {
    try {
      final json = await _httpService.get('/posts/$id');
      return Post.fromJson(json);
    } catch (e) {
      throw Exception('Failed to load post details: $e');
    }
  }

  Future<List<Comment>> getPostComments(int postId) async {
    try {
      final jsonList = await _httpService.getList('/posts/$postId/comments');
      return jsonList.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  void dispose() {
    _httpService.dispose();
  }
}