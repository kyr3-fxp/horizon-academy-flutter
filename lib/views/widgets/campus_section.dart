import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CampusSection extends StatelessWidget {
  const CampusSection({super.key});

  static const List<Map<String, dynamic>> facilities = [
    {
      'title': 'Laboratorio STEAM & Robótica',
      'category': 'Innovación & Tecnología',
      'icon': Icons.precision_manufacturing_rounded,
      'desc': 'Impresoras 3D, kits de robótica avanzadas y licencias de software de diseño profesional.'
    },
    {
      'title': 'Complejo Deportivo & Alberca',
      'category': 'Salud & Deporte',
      'icon': Icons.pool_rounded,
      'desc': 'Alberca semi-olímpica climatizada, canchas de básquetbol de duela y campo de fútbol de pasto natural.'
    },
    {
      'title': 'Centro de Recursos & Biblioteca',
      'category': 'Investigación',
      'icon': Icons.local_library_rounded,
      'desc': 'Más de 15,000 volúmenes físicos y acceso a bases de datos académicas internacionales (JSTOR, EBSCO).'
    },
    {
      'title': 'Auditorio & Foro de las Artes',
      'category': 'Expresión & Cultura',
      'icon': Icons.theater_comedy_rounded,
      'desc': 'Capacidad para 600 espectadores con acústica profesional e iluminación escénica avanzada.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 40,
      ),
      child: Column(
        children: [
          Text(
            'Nuestras Instalaciones',
            style: AppTextStyle.heading(
              fontSize: isDesktop ? 36 : 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Espacios diseñados para estimular la curiosidad, el deporte y la creación en un entorno seguro de 15 hectáreas.',
            style: AppTextStyle.body(fontSize: 16, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          LayoutBuilder(
            builder: (context, constraints) {
              final isSingleColumn = constraints.maxWidth < 650;

              if (isSingleColumn) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: facilities.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final f = facilities[index];
                    return _FacilityCard(facility: f);
                  },
                );
              }

              final crossAxisCount = isDesktop ? 4 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: facilities.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isDesktop ? 0.85 : 0.90,
                ),
                itemBuilder: (context, index) {
                  final f = facilities[index];
                  return _FacilityCard(facility: f);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  final Map<String, dynamic> facility;

  const _FacilityCard({required this.facility});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderPaper),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accentGreenSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(facility['icon'] as IconData, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility['category'] as String,
                      style: AppTextStyle.body(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentAmber,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      facility['title'] as String,
                      style: AppTextStyle.heading(fontSize: 16, color: AppColors.primary, height: 1.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            facility['desc'] as String,
            style: AppTextStyle.body(fontSize: 12, color: AppColors.textMuted, height: 1.4),
          ),
        ],
      ),
    );
  }
}
