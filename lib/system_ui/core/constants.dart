/// Design System: Breakpoints
/// "Consistent points for responsive layout"
class AppBreakpoints {
  static const double mobile = 320;
  static const double tablet = 768;
  static const double laptop = 1024;
  static const double desktop = 1280;
  static const double ultraWide = 1536;
}

/// Design System: Spacing Scale
/// "Based on multiples of 8px"
class AppSpacing {
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 32.0;
  static const double xl = 64.0;

  // Extra granular options if needed
  static const double xs = 4.0;
  static const double xxl = 128.0;
}

/// Design System: Z-Index (Elevation/Stacking)
/// "To manage depth and overlay order"
class AppZIndex {
  static const double background = 0;
  static const double card = 1;
  static const double dropdown = 2; // Popovers usually
  static const double modal = 3; // Dialogs
  static const double toast = 4; // Notifications
  static const double max = 9999;
}
