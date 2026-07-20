import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/colors.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isExpanded = false; // For mobile toggle
  bool _isHoveringAvatar = false;

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 580;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      clipBehavior: Clip.antiAlias,
      width: isDesktop ? 250 : double.infinity,
      constraints: BoxConstraints(
        maxHeight: isDesktop ? double.infinity : (_isExpanded ? 500 : 112),
      ),
      decoration: BoxDecoration(
        color: AppColors.eerieBlack2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.jet, width: 1),
        boxShadow: AppColors.shadow1,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveringAvatar = true),
                onExit: (_) => setState(() => _isHoveringAvatar = false),
                child: Container(
                  width: isDesktop ? 120 : 80,
                  height: isDesktop ? 120 : 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppColors.bgGradientOnyx,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isHoveringAvatar ? 0.0 : 1.0,
                          child: Image.asset(
                            'assets/images/my-avatar.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isHoveringAvatar ? 1.0 : 0.0,
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                        ),
                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: _isHoveringAvatar ? 1.0 : 1.1,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: _isHoveringAvatar ? 1.0 : 0.0,
                            child: Image.asset(
                              'assets/images/logo-1-color.png',
                              width: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (!isDesktop) ...[
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vicente Nevarez',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.white2,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.onyx,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Web Developer',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.white1,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.borderGradientOnyx,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    boxShadow: AppColors.shadow2,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleSidebar,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text(
                              "Show Contacts",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.orangeYellow,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              _isExpanded
                                  ? Ionicons.chevron_up
                                  : Ionicons.chevron_down,
                              color: AppColors.orangeYellow,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),

          if (isDesktop) ...[
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Vicente Nevarez',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.white2,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.25,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.onyx,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Web Developer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.white1,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],

          if (isDesktop || _isExpanded) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: AppColors.jet, height: 1),
            ),

            Column(
              children: [
                _buildContactItem(
                  Ionicons.mail_outline,
                  'Email',
                  'vicentcodes@gmail.com',
                  'mailto:vicentcodes@gmail.com',
                ),
                _buildContactItem(
                  Ionicons.phone_portrait_outline,
                  'Phone',
                  '+52 (646) 190-2646',
                  'tel:+526461902646',
                ),
                _buildContactItem(
                  Ionicons.calendar_outline,
                  'Birthday',
                  'August 24, 2003',
                  null,
                ),
                _buildContactItem(
                  Ionicons.location_outline,
                  'Location',
                  'Ensenada, BC, Mexico',
                  null,
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: AppColors.jet, height: 1),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialIcon(
                    Ionicons.logo_facebook,
                    'https://facebook.com',
                  ),
                  _buildSocialIcon(
                    Ionicons.logo_twitter,
                    'https://twitter.com',
                  ),
                  _buildSocialIcon(
                    Ionicons.logo_instagram,
                    'https://instagram.com/vicentcodes',
                  ),
                  _buildSocialIcon(
                    Ionicons.logo_github,
                    'https://github.com/vicentcodes',
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String value,
    String? url,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: url != null ? () => _launchUrl(url) : null,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: AppColors.borderGradientOnyx,
                boxShadow: AppColors.shadow1,
              ),
              child: Center(
                child: Icon(icon, color: AppColors.orangeYellow, size: 18),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.lightGray70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.white2,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Icon(icon, color: AppColors.lightGray70, size: 20),
    );
  }
}
