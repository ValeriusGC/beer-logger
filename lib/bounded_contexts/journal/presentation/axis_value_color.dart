import 'package:flutter/material.dart';

/// Цвет подписи оси: отрицательные — [ColorScheme.error], иначе [ColorScheme.onSurface].
Color axisValueColor(ColorScheme colors, {required bool isNegative}) {
  return isNegative ? colors.error : colors.onSurface;
}
