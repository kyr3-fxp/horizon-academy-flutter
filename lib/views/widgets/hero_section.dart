import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExplorePrograms;
  final VoidCallback onAdmissions;

  const HeroSection({
    super.key,
    required this.onExplorePrograms,
    required this.onAdmissions,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _badgeAnimationController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _badgeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(
        parent: _badgeAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _badgeAnimationController.dispose();
    super.dispose();
  }

  void _showVirtualTourModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgSurfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.vrpano_rounded, color: AppColors.primary, size: 28),
            const SizedBox(width: 10),
            Text(
              'Tour Virtual 360°',
              style: AppTextStyle.heading(fontSize: 22, color: AppColors.primary),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryLight.withValues(alpha: 0.15),
                border: Border.all(color: AppColors.borderPaper),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.play_circle_fill_rounded, color: AppColors.accentAmber, size: 64),
                  const SizedBox(height: 12),
                  Text(
                    'Vista Panorámica del Campus',
                    style: AppTextStyle.heading(fontSize: 16, color: AppColors.primary),
                  ),
                  Text(
                    'Laboratorios STEAM, Aulas Inteligentes y Canchas Deportivas',
                    style: AppTextStyle.body(fontSize: 12, color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Explora nuestras 15 hectáreas de instalaciones vanguardistas diseñadas para la formación integral.',
              style: AppTextStyle.body(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar', style: AppTextStyle.body(fontWeight: FontWeight.bold, color: AppColors.primary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onAdmissions();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Agendar Visita Presencial'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 80 : 40,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texto & CTAs
              Expanded(
                flex: isDesktop ? 6 : 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Superior
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accentGreenSoft,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified_rounded, color: AppColors.primary, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Educación Bilingüe & Diploma IB Internacional',
                            style: AppTextStyle.body(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Título Principal
                    Text(
                      'Formando los Líderes e Innovadores del Mañana',
                      style: AppTextStyle.heading(
                        fontSize: isDesktop ? 48 : 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtítulo
                    Text(
                      'Una experiencia educativa de clase mundial inspirada en valores humanos, pensamiento crítico, ciencia avanzada y creatividad sin límites.',
                      style: AppTextStyle.body(
                        fontSize: isDesktop ? 18 : 15,
                        color: AppColors.textMuted,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Botones de Acción
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        ElevatedButton.icon(
                          onPressed: widget.onExplorePrograms,
                          icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                          label: Text('Explorar Programas', style: AppTextStyle.button()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            elevation: 3,
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _showVirtualTourModal(context),
                          icon: const Icon(Icons.vrpano_rounded, color: AppColors.accentAmber, size: 22),
                          label: Text(
                            'Tour Virtual 360°',
                            style: AppTextStyle.body(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.accentAmber, width: 1.8),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (isDesktop) ...[
                const SizedBox(width: 40),
                // Imagen / Ilustración con Badges Flotantes
                Expanded(
                  flex: 6,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Tarjeta Ilustrativa Principal
                      Container(
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.bgSurface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.borderPaper, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: const BoxDecoration(
                                color: AppColors.accentGreenSoft,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_stories_rounded,
                                color: AppColors.primary,
                                size: 80,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Horizon International Academy',
                              style: AppTextStyle.heading(fontSize: 22, color: AppColors.primary),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Excelencia Académica desde 2001',
                              style: AppTextStyle.body(fontSize: 14, color: AppColors.accentAmber),
                            ),
                          ],
                        ),
                      ),

                      // Badge Flotante 1: Tasa de Ingreso
                      AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Positioned(
                            top: 20 + _floatAnimation.value,
                            left: 10,
                            child: child!,
                          );
                        },
                        child: const _FloatingBadge(
                          icon: Icons.star_rounded,
                          iconColor: Colors.amber,
                          title: '99% Ingreso Universitario',
                          subtitle: 'Tec, UNAM, Cambridge, Harvard',
                        ),
                      ),

                      // Badge Flotante 2: Certificación IB
                      AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Positioned(
                            bottom: 20 - _floatAnimation.value,
                            right: 10,
                            child: child!,
                          );
                        },
                        child: const _FloatingBadge(
                          icon: Icons.workspace_premium_rounded,
                          iconColor: AppColors.primary,
                          title: 'Bachillerato IB World',
                          subtitle: 'Acreditación Internacional',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _FloatingBadge({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderPaper),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyle.body(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textMain),
              ),
              Text(
                subtitle,
                style: AppTextStyle.body(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
