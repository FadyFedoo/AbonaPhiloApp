import 'package:flutter/material.dart';

ImageIcon defaultImageIcon(
    {required String assetsData, Color? color, double? size}) {
  return ImageIcon(
    AssetImage(
      assetsData,
    ),
    color: color,
    size: size,
  );
}
