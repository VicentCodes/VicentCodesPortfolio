import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';

class ServiceItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const ServiceItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.eerieBlack2, // Match Sidebar background
        borderRadius: BorderRadius.circular(
          20,
        ), // Match Sidebar radius (was 14)
        border: Border.all(
          color: AppColors.jet,
        ), // Match Sidebar border (Solid Jet)
        boxShadow: AppColors.shadow2,
      ),
      padding: const EdgeInsets.all(
        30,
      ), // Increased padding (was 20)? Sidebar is 30 on desktop?

      // CSS service-item padding 20px.
      // Sidebar padding 30px (desktop).
      // Let's use 20px but maybe slightly more spacious if desired, but 20 is standard for cards.
      // Let's stick to 20 for internal content, or 25.
      // User said "homogeneous", so matching Sidebar logic.
      // But Sidebar is a large container. ServiceItem is a small card.
      // 20px is probably fine.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 40,
            colorFilter: const ColorFilter.mode(
              AppColors.orangeYellow,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.white2,
                    fontSize:
                        18, // --fs-4? No, fs-4 is 16. Service title might be larger?
                    // CSS: .service-item-title { ... } -> h4 (fs-4 = 16px).
                    // But visual hierarchy might suggest 18 for better readability on desktop.
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.lightGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
