import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/service_item.dart';
import '../widgets/testimonial_card.dart';
import '../widgets/client_item.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive logic
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 768 && width < 1024;
    final useLargeFonts = width >= 580;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.eerieBlack2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.jet),
        boxShadow: AppColors.shadow5,
      ),
      clipBehavior: Clip.antiAlias, // Clips content to the rounded corners
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(
          30,
        ), // Padding moved inside the scroll view
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Me',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.white2,
                    fontSize: useLargeFonts ? 32 : 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  width: 30,
                  height: 5,
                  decoration: const BoxDecoration(
                    gradient: AppColors.textGradientYellow,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // About Text
            Text(
              "I'm Vicente Nevarez, or VicentCodes as you prefer to call me. I'm a computer engineering student with experience in software development since 2018. My passion lies in Android development, web programming and desktop applications, as well as interface design with a focus on user experience.",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.lightGray,
                fontSize: useLargeFonts ? 15 : 14,
                fontWeight: FontWeight.w300,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "My goal is to turn complex ideas into simple, beautiful and intuitive designs that bring value to your projects. If you're looking for a developer committed to functionality and aesthetics, I'm here to help you stand out and take your ideas to the next level.",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.lightGray,
                fontSize: useLargeFonts ? 15 : 14,
                fontWeight: FontWeight.w300,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 40),

            // Services
            Text(
              "What I'm Doing",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.white2,
                fontSize: useLargeFonts ? 24 : 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),

            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (isDesktop || isTablet) ? 2 : 1;

                if (crossAxisCount == 2) {
                  double itemWidth = (constraints.maxWidth - 20) / 2;
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SizedBox(width: itemWidth, child: _buildServiceItem(0)),
                      SizedBox(width: itemWidth, child: _buildServiceItem(1)),
                      SizedBox(width: itemWidth, child: _buildServiceItem(2)),
                    ],
                  );
                }

                return Column(
                  children: [
                    _buildServiceItem(0),
                    const SizedBox(height: 20),
                    _buildServiceItem(1),
                    const SizedBox(height: 20),
                    _buildServiceItem(2),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            // Testimonials
            Text(
              "Testimonials",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.white2,
                fontSize: useLargeFonts ? 24 : 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 10, left: 0),
                  clipBehavior: Clip.none,
                  children: const [
                    TestimonialCard(
                      avatarPath: 'assets/images/avatar-1.png',
                      name: 'Eduardo Soto',
                      quote:
                          'Vicente developed and implemented an app for my service provider contracting business and I loved the result. The app is fast but visually very attractive that it\'s even a pleasure to enter it.',
                    ),
                    SizedBox(width: 30),
                    TestimonialCard(
                      avatarPath: 'assets/images/avatar-2.png',
                      name: 'Maria Sorlozano',
                      quote:
                          'I needed an app to develop and solve different mathematical operations but mainly matrix operations and Vicente created it for me in the agreed time with an interface although sober and elegant enough functional, I loved it.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Clients
            Text(
              "Clients",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.white2,
                fontSize: useLargeFonts ? 24 : 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ClientItem(logoPath: 'assets/images/logo-1-color.png'),
                  SizedBox(width: 40),
                  ClientItem(logoPath: 'assets/images/logo-2-color.png'),
                  SizedBox(width: 40),
                  ClientItem(logoPath: 'assets/images/logo-5-color.png'),
                ],
              ),
            ),

            // Add extra padding at bottom to avoid content being hidden by rounded corners or scroll edge
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(int index) {
    const services = [
      ServiceItem(
        iconPath: 'assets/images/icon-design.svg',
        title: 'Mobile Design',
        description:
            'The most modern and high-quality design made at a professional level.',
      ),
      ServiceItem(
        iconPath: 'assets/images/icon-dev.svg',
        title: 'Web Development',
        description:
            'High-quality development of sites at the professional level.',
      ),
      ServiceItem(
        iconPath: 'assets/images/icon-app.svg',
        title: 'Mobile Apps',
        description:
            'Professional development of applications for iOS and Android.',
      ),
    ];
    return services[index];
  }
}
