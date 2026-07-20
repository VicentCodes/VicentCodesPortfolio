import 'package:flutter/material.dart';

class AppColors {
  // Solid Colors
  static const Color jet = Color(0xFF383838); // hsl(0, 0%, 22%)
  static const Color onyx = Color(0xFF2B2B2C); // hsl(240, 1%, 17%)
  static const Color eerieBlack1 = Color(0xFF202022); // hsl(240, 2%, 13%)
  static const Color eerieBlack2 = Color(0xFF1E1E1F); // hsl(240, 2%, 12%)
  static const Color smokyBlack = Color(0xFF121212); // hsl(0, 0%, 7%)
  static const Color white1 = Color(0xFFFFFFFF); // hsl(0, 0%, 100%)
  static const Color white2 = Color(0xFFFAFAFA); // hsl(0, 0%, 98%)
  static const Color orangeYellow = Color(0xFFFF5F00); // hsl(23, 100%, 50%)
  static const Color lightGray = Color(0xFFD6D6D6); // hsl(0, 0%, 84%)
  static const Color lightGray70 = Color(0xB3D6D6D6); // hsla(0, 0%, 84%, 0.7)

  // Gradients
  static const LinearGradient bgGradientOnyx = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFF404040), Color(0xFF303030)],
    stops: [0.03, 0.97],
  );

  static const LinearGradient borderGradientOnyx = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      // Darkened from 0xFF404040 to make the border subtler and closer to design
      Color(0xFF2A2A2A),
      Color(0x002A2A2A), // fading to transparent
    ],
    stops: [0.0, 0.5],
  );

  static const LinearGradient bgGradientJet = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(
        0xFF2E2E2F,
      ), // Increased opacity slightly for solid background feel? No, CSS uses hsla(240, 1%, 18%, 0.251) + Onyx base.
      // Wait, CSS service-item has background: border-gradient-onyx.
      // THE INNER pseudo-element has background: bg-gradient-jet.
      // bg-gradient-jet: linear-gradient(to bottom right, hsla(240, 1%, 18%, 0.251) 0%, hsla(240, 2%, 11%, 0) 100%), hsl(240, 2%, 13%);
      // It includes a base color `hsl(240, 2%, 13%)` (eerieBlack1) AND the gradient!
      // My previous implementation might have missed the base color mixing, causing it to look transparent/grey.
      // Let's approximate the mixed result.
      // Base: #202022. Gradient overlay: #2E2E2F (25%).
      // Result is effectively #222224 roughly.
      Color(0xFF222224),
      Color(0xFF1C1C1D),
    ],
  );

  static const LinearGradient textGradientYellow = LinearGradient(
    colors: [
      Color(0xFFFF5F00),
      Color(0xFFFFDB70), // hsl(45, 100%, 71%)
    ],
  );

  // Shadows - Updated for Desktop opacity (0.125 = ~0x20)
  static const List<BoxShadow> shadow1 = [
    BoxShadow(color: Color(0x20000000), offset: Offset(-4, 8), blurRadius: 24),
  ];

  static const List<BoxShadow> shadow2 = [
    BoxShadow(color: Color(0x20000000), offset: Offset(0, 16), blurRadius: 30),
  ];

  static const List<BoxShadow> shadow5 = [
    BoxShadow(color: Color(0x20000000), offset: Offset(0, 24), blurRadius: 80),
  ];
}
