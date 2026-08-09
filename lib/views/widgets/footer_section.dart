import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 40,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 40,
                runSpacing: 30,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: isDesktop ? 300 : constraints.maxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.school_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'HORIZON ACADEMY',
                              style: AppTextStyle.heading(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Horizon International Academy es una institución bilingüe autorizada para impartir el Programa del Diploma del IB.',
                          style: AppTextStyle.body(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: isDesktop ? 180 : 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Navegación', style: AppTextStyle.heading(fontSize: 16, color: AppColors.accentAmber)),
                        const SizedBox(height: 12),
                        const _FooterLink('Programas Académicos'),
                        const _FooterLink('Admisiones & Becas'),
                        const _FooterLink('Simulador de Colegiaturas'),
                        const _FooterLink('Calendario Escolar'),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: isDesktop ? 260 : constraints.maxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contacto & Ubicación', style: AppTextStyle.heading(fontSize: 16, color: AppColors.accentAmber)),
                        const SizedBox(height: 12),
                        const _FooterInfoRow(Icons.location_on_outlined, 'Av. de los Horizontes #1050, Campus Norte'),
                        const _FooterInfoRow(Icons.phone_outlined, '+52 (55) 8900-4500 / WhatsApp: +52 55 1234-5678'),
                        const _FooterInfoRow(Icons.email_outlined, 'admisiones@horizonacademy.edu.mx'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),

          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAlignment: WrapCrossAlignment.center,
            spacing: 20,
            runSpacing: 12,
            children: [
              Text(
                '© 2026 Horizon International Academy. Todos los derechos reservados.',
                style: AppTextStyle.body(fontSize: 12, color: Colors.white54),
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.facebook, color: Colors.white70, size: 20),
                  SizedBox(width: 14),
                  Icon(Icons.camera_alt_outlined, color: Colors.white70, size: 20),
                  SizedBox(width: 14),
                  Icon(Icons.language_rounded, color: Colors.white70, size: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: AppTextStyle.body(fontSize: 13, color: Colors.white70),
      ),
    );
  }
}

class _FooterInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FooterInfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentAmber, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.body(fontSize: 13, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
