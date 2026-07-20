import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class ClientItem extends StatefulWidget {
  final String logoPath;

  const ClientItem({super.key, required this.logoPath});

  @override
  State<ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _isHovering ? 1.0 : 0.6, // Slight fade default
        // Original CSS opacity 0.5 -> 1.
        // But if it's in a card, maybe full opacity?
        // Let's keep the hover effect.
        child: Container(
          width: 150, // Fixed width card
          height: 100,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.eerieBlack2,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.jet),
            boxShadow: AppColors.shadow2,
          ),
          child: Center(
            child: Image.asset(widget.logoPath, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
