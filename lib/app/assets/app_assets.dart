/// Builds paths to assets
abstract class AppAssets {
  static String getPath(String asset) {
    return 'assets/$asset';
  }
}
