import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'package:ionicons/ionicons.dart';

class TestimonialCard extends StatelessWidget {
  final String avatarPath;
  final String name;
  final String quote;

  const TestimonialCard({
    super.key,
    required this.avatarPath,
    required this.name,
    required this.quote,
  });

  void _showTestimonialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: AppColors.eerieBlack2,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.jet),
            boxShadow: AppColors.shadow5,
          ),
          padding: const EdgeInsets.all(30),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: AppColors.bgGradientOnyx,
                          boxShadow: AppColors.shadow1,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(avatarPath, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.white2,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Text(
                        quote,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.lightGray,
                          fontSize:
                              15, // Slightly larger for readability in dialog
                          fontWeight: FontWeight.w300,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.onyx,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Ionicons.close,
                      color: AppColors.white2,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTestimonialDialog(context),
      child: SizedBox(
        width: 450, // Increased from 280 to 450 for rectangular shape
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: AppColors.eerieBlack2,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.jet),
                boxShadow: AppColors.shadow2,
              ),
              padding: const EdgeInsets.fromLTRB(
                25,
                50,
                25,
                20,
              ), // Reduced spacing
              child: Column(
                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.white2,
                      fontSize: 16, // Reduced from 18 slightly
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5), // Reduced from 10
                  Text(
                    quote,
                    maxLines: 3, // Reduced from 4
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.lightGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      height: 1.5, // Reduced line height slightly
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: AppColors.bgGradientOnyx,
                  boxShadow: AppColors.shadow1,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(avatarPath, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
