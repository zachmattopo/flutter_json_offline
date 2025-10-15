// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Posts';

  @override
  String get allPosts => 'All Posts';

  @override
  String get bookmarked => 'Bookmarked';

  @override
  String get postDetails => 'Post details';

  @override
  String get noBookmarkedPosts => 'No bookmarked posts';

  @override
  String get comments => 'Comments';

  @override
  String get seeComments => 'See comments';

  @override
  String get addBookmark => 'Add Bookmark';

  @override
  String get removeBookmark => 'Remove Bookmark';

  @override
  String get pleaseWait => 'Please wait...';
}
