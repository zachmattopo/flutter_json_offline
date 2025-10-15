import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tech_task/data/models/post.dart';

void main() {
  group('Post', () {
    const testId = 1;
    const testTitle = 'Test Title';
    const testBody = 'Test Body';

    test('should create Post instance with correct values', () {
      final post = Post(
        id: testId,
        title: testTitle,
        body: testBody,
      );

      expect(post.id, equals(testId));
      expect(post.title, equals(testTitle));
      expect(post.body, equals(testBody));
    });

    test('should create Post from JSON with correct values', () {
      final json = {
        'id': testId,
        'title': testTitle,
        'body': testBody,
      };

      final post = Post.fromJson(json);

      expect(post.id, equals(testId));
      expect(post.title, equals(testTitle));
      expect(post.body, equals(testBody));
    });

    test('should throw TypeError when JSON has invalid types', () {
      final invalidJson = {
        'id': 'invalid_id', // Should be int
        'title': 42, // Should be String
        'body': true, // Should be String
      };

      expect(
        () => Post.fromJson(invalidJson),
        throwsA(isA<TypeError>()),
      );
    });

    test('should throw when required JSON fields are missing', () {
      final incompleteJson = {
        'id': testId,
        // missing title
        'body': testBody,
      };

      expect(
        () => Post.fromJson(incompleteJson),
        throwsA(anything),
      );
    });
  });
}