import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_tech_task/data/models/post.dart';
import 'package:flutter_tech_task/data/repositories/post_repository.dart';
import 'package:flutter_tech_task/presentation/cubits/posts_cubit/posts_cubit.dart';
import 'package:flutter_tech_task/presentation/cubits/posts_cubit/posts_state.dart';

@GenerateNiceMocks([MockSpec<PostRepository>()])
import 'posts_cubit_test.mocks.dart';

void main() {
  group('PostsCubit', () {
    late MockPostRepository mockRepository;
    late PostsCubit postsCubit;

    setUp(() {
      mockRepository = MockPostRepository();
      postsCubit = PostsCubit(mockRepository);
    });

    tearDown(() {
      postsCubit.close();
    });

    test('initial state should be PostsInitial', () {
      expect(postsCubit.state, isA<PostsInitial>());
    });

    group('loadPosts', () {
      final tPosts = [
        Post(id: 1, title: 'Test Post 1', body: 'Test Body 1'),
        Post(id: 2, title: 'Test Post 2', body: 'Test Body 2'),
      ];

      test('should emit [PostsLoading, PostsLoaded] when data is loaded successfully', () async {
        // Arrange
        when(mockRepository.getPosts()).thenAnswer((_) async => tPosts);

        // Assert later
        final expected = [
          PostsLoading(),
          PostsLoaded(tPosts),
        ];
        expectLater(postsCubit.stream, emitsInOrder(expected));

        // Act
        await postsCubit.loadPosts();

        // Assert
        verify(mockRepository.getPosts()).called(1);
      });

      test('should emit [PostsLoading, PostsError] when loading data fails', () async {
        // Arrange
        final tError = Exception('Test error message');
        when(mockRepository.getPosts()).thenThrow(tError);

        // Assert later
        final expected = [
          PostsLoading(),
          PostsError(tError.toString()),
        ];
        expectLater(postsCubit.stream, emitsInOrder(expected));

        // Act
        await postsCubit.loadPosts();

        // Assert
        verify(mockRepository.getPosts()).called(1);
      });

      test('should emit PostsError with correct error message on network error', () async {
        // Arrange
        final tError = Exception('No internet connection');
        when(mockRepository.getPosts()).thenThrow(tError);

        // Act
        await postsCubit.loadPosts();

        // Assert
        expect(postsCubit.state, PostsError(tError.toString()));
        verify(mockRepository.getPosts()).called(1);
      });
    });
  });
}
