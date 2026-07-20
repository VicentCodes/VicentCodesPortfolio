import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../../../../core/constants/colors.dart';

/// Returns true only on native macOS or iOS (not web).
bool get useNativeLiquidGlass =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS);

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const _tabLabels = ['Aboungat', 'Resume', 'Portfolio', 'Blog', 'Contact'];

  @override
  Widget build(BuildContext context) {
    if (useNativeLiquidGlass) {
      return _buildGlassBottomBar();
    } else {
      final width = MediaQuery.of(context).size.width;
      final isDesktop = width >= 1024;
      return isDesktop ? _buildWebDesktopNavBar() : _buildWebMobileNavBar();
    }
  }

  // ─────────────────────────────────────────────────────────────
  // LIQUID GLASS — macOS & iOS only
  // Uses GlassBottomBar with CupertinoIcons, premium quality,
  // and optimized settings — matching the official example pattern.
  // ─────────────────────────────────────────────────────────────

  Widget _buildGlassBottomBar() {
    return GlassBottomBar(
      quality: GlassQuality.premium,
      glassSettings: LiquidGlassSettings(
        blur: 12,
        thickness: 20,
        glassColor: const Color.fromRGBO(255, 255, 255, 0.08),
        lightAngle: 0.75 * math.pi,
        lightIntensity: 0.7,
        ambientStrength: 0.5,
        saturation: 1.4,
        refractiveIndex: 1.2,
        chromaticAberration: 0.0,
      ),
      indicatorColor: Colors.white.withValues(alpha: 0.2),
      selectedIconColor: Colors.white,
      unselectedIconColor: Colors.white.withValues(alpha: 0.6),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      tabs: [
        GlassBottomBarTab(
          label: _tabLabels[0],
          icon: CupertinoIcons.person,
          selectedIcon: CupertinoIcons.person_fill,
        ),
        GlassBottomBarTab(
          label: _tabLabels[1],
          icon: CupertinoIcons.doc_text,
          selectedIcon: CupertinoIcons.doc_text_fill,
        ),
        GlassBottomBarTab(
          label: _tabLabels[2],
          icon: CupertinoIcons.briefcase,
          selectedIcon: CupertinoIcons.briefcase_fill,
        ),
        GlassBottomBarTab(
          label: _tabLabels[3],
          icon: CupertinoIcons.news,
          selectedIcon: CupertinoIcons.news_solid,
        ),
        GlassBottomBarTab(
          label: _tabLabels[4],
          icon: CupertinoIcons.envelope,
          selectedIcon: CupertinoIcons.envelope_fill,
        ),
      ],
      selectedIndex: _selectedIndex,
      onTabSelected: (index) => setState(() => _selectedIndex = index),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // WEB / OTHER PLATFORMS — styled navbar (no liquid glass)
  // ─────────────────────────────────────────────────────────────

  Widget _buildWebDesktopNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        gradient: AppColors.bgGradientOnyx,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.jet.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: AppColors.shadow1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_tabLabels.length, (i) {
          final isSelected = _selectedIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.transparent,
              ),
              child: Text(
                _tabLabels[i],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : AppColors.lightGray.withValues(alpha: 0.85),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWebMobileNavBar() {
    return Container(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
        gradient: AppColors.bgGradientOnyx,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.jet.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: AppColors.shadow2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_tabLabels.length, (i) {
          final isSelected = _selectedIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected
                        ? [
                            Icons.person,
                            Icons.description,
                            Icons.work,
                            Icons.article,
                            Icons.mail,
                          ][i]
                        : [
                            Icons.person_outline,
                            Icons.description_outlined,
                            Icons.work_outline,
                            Icons.article_outlined,
                            Icons.mail_outline,
                          ][i],
                    size: 22,
                    color: isSelected
                        ? Colors.white
                        : AppColors.lightGray.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _tabLabels[i],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? Colors.white
                          : AppColors.lightGray.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
