import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/navbar.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    if (useNativeLiquidGlass) {
      // ── macOS / iOS: Scaffold with GlassBottomBar as bottomNavigationBar ──
      return Scaffold(
        backgroundColor: AppColors.smokyBlack,
        extendBody: true,
        body: isDesktop ? _buildDesktopBody() : _buildMobileBody(),
        bottomNavigationBar: const NavBar(),
      );
    } else {
      // ── Web / Other: NavBar placed manually in the layout ──
      if (isDesktop) {
        return Scaffold(
          backgroundColor: AppColors.smokyBlack,
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1250),
              margin: const EdgeInsets.all(60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 250, child: Sidebar()),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(child: child),
                        const Positioned(top: 0, right: 0, child: NavBar()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.smokyBlack,
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1250),
              margin: const EdgeInsets.all(15),
              child: _buildWebMobileLayout(),
            ),
          ),
        );
      }
    }
  }

  /// Desktop body for macOS/iOS — sidebar + content, no manual navbar positioning.
  Widget _buildDesktopBody() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1250),
        margin: const EdgeInsets.only(top: 60, bottom: 20, left: 60, right: 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 250, child: Sidebar()),
            const SizedBox(width: 25),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  /// Mobile body for macOS/iOS — scrollable content, navbar handled by Scaffold.
  Widget _buildMobileBody() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1250),
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [const Sidebar(), const SizedBox(height: 20), child],
          ),
        ),
      ),
    );
  }

  /// Web mobile layout — navbar manually positioned at bottom.
  Widget _buildWebMobileLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 70),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [const Sidebar(), const SizedBox(height: 20), child],
          ),
        ),
        const Positioned(bottom: 0, left: 0, right: 0, child: NavBar()),
      ],
    );
  }
}
