part of 'bookmark_cubit.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<Post> bookmarkedPosts;

  const BookmarkLoaded(this.bookmarkedPosts);

  @override
  List<Object> get props => [bookmarkedPosts];
}