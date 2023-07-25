import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageColorRecognizer {
  /// Returns the dominant color from the image or or null if not recognized.
  static Future<Color?> getDominantColor(String imageUrl) async {
    // TODO: move calculation to a separate isolote
    try {
      final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));
      return generator.vibrantColor?.color ?? generator.dominantColor?.color;
    } catch (err) {
      return null;
    }
  }
}
