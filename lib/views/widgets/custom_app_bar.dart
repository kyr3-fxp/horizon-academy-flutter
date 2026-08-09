import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAdmissionPressed;
  final Function(String sectionKey) onNavigateToSection;

  const CustomAppBar({
    super.key,
    required this.onAdmissionPressed,
    required this.onNavigateToSection,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: AppColors.bgSurface.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderPaper, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & Marca
              Flexible(
                child: InkWell(
                  onTap: () => onNavigateToSection('hero'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: AppColors.accentAmber,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'HORIZON',
                              style: AppTextStyle.heading(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                height: 1.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'INTERNATIONAL ACADEMY',
                              style: AppTextStyle.body(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentAmber,
                                height: 1.0,
                              ).copyWith(letterSpacing: 1.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Navegación Desktop / Menú Móvil
              if (isDesktop)
                Row(
                  children: [
                    _NavButton(
                      label: 'Programas',
                      onPressed: () => onNavigateToSection('programs'),
                    ),
                    _NavButton(
                      label: 'Estadísticas',
                      onPressed: () => onNavigateToSection('stats'),
                    ),
                    _NavButton(
                      label: 'Colegiaturas',
                      onPressed: () => onNavigateToSection('calculator'),
                    ),
                    _NavButton(
                      label: 'Eventos',
                      onPressed: () => onNavigateToSection('events'),
                    ),
                    _NavButton(
                      label: 'Testimonios',
                      onPressed: () => onNavigateToSection('testimonials'),
                    ),
                    _NavButton(
                      label: 'FAQs',
                      onPressed: () => onNavigateToSection('faqs'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: onAdmissionPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 2,
                      ),
                      child: Text('Admisiones', style: AppTextStyle.button(fontSize: 14)),
                    ),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: AppColors.primary, size: 28),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _NavButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textMain,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      child: Text(
        label,
        style: AppTextStyle.body(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textMain,
        ),
      ),
    );
  }
}
