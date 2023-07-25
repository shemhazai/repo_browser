import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_environment.freezed.dart';

/// A configuration for the app which depends on the environment.
@freezed
class AppEnvironment with _$AppEnvironment {
  static const AppEnvironment development = AppEnvironment(
    name: 'development',
    baseUrl: 'https://simpleclub-coding-challenges.web.app/navigating-dynamic-content/',
  );

  const factory AppEnvironment({
    required String name,
    required String baseUrl,
  }) = _AppEnvironment;
}
