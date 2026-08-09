import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/program_model.dart';

class ProgramsSection extends StatelessWidget {
  final VoidCallback onAdmissionsPressed;

  const ProgramsSection({super.key, required this.onAdmissionsPressed});

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'child_care':
        return Icons.child_care_rounded;
      case 'school':
        return Icons.school_rounded;
      case 'menu_book':
        return Icons.menu_book_rounded;
      case 'workspace_premium':
        return Icons.workspace_premium_rounded;
      default:
        return Icons.auto_stories_rounded;
    }
  }

  void _showProgramDetailModal(BuildContext context, ProgramModel program) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgSurfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accentGreenSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getIcon(program.iconName), color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: AppTextStyle.heading(fontSize: 20, color: AppColors.primary),
                  ),
                  Text(
                    program.subtitle,
                    style: AppTextStyle.body(fontSize: 13, color: AppColors.accentAmber, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderPaper),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MetaItem(icon: Icons.cake_rounded, label: 'Edad', value: program.ageRange),
                    _MetaItem(icon: Icons.access_time_rounded, label: 'Horario', value: program.schedule),
                    _MetaItem(icon: Icons.groups_rounded, label: 'Ratio', value: program.ratio),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              Text(
                'Descripción General',
                style: AppTextStyle.heading(fontSize: 16, color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              Text(program.description, style: AppTextStyle.body(fontSize: 14)),
              const SizedBox(height: 18),

              Text(
                'Ejes Curriculares y Pilares',
                style: AppTextStyle.heading(fontSize: 16, color: AppColors.primary),
              ),
              const SizedBox(height: 10),

              ...program.highlights.map(
                (h) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.primaryLight, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          h,
                          style: AppTextStyle.body(fontSize: 14, color: AppColors.textMain),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar', style: AppTextStyle.body(fontWeight: FontWeight.bold, color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onAdmissionsPressed();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Solicitar Admisión en este Nivel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final programs = ProgramModel.samplePrograms;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 40,
      ),
      child: Column(
        children: [
          Text(
            'Programas Académicos',
            style: AppTextStyle.heading(
              fontSize: isDesktop ? 36 : 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Un recorrido educativo desde los primeros pasos hasta la preparación universitaria internacional.',
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
                  itemCount: programs.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _ProgramCard(
                      program: programs[index],
                      iconData: _getIcon(programs[index].iconName),
                      onTap: () => _showProgramDetailModal(context, programs[index]),
                    );
                  },
                );
              }

              final crossAxisCount = isDesktop ? 4 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: programs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isDesktop ? 0.78 : 0.82,
                ),
                itemBuilder: (context, index) {
                  return _ProgramCard(
                    program: programs[index],
                    iconData: _getIcon(programs[index].iconName),
                    onTap: () => _showProgramDetailModal(context, programs[index]),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final ProgramModel program;
  final IconData iconData;
  final VoidCallback onTap;

  const _ProgramCard({
    required this.program,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderPaper, width: 1.2),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentGreenSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconData, color: AppColors.primary, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.bgMain,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderPaper),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cake_outlined, size: 13, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      program.ageRange,
                      style: AppTextStyle.body(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Text(
            program.title,
            style: AppTextStyle.heading(fontSize: 17, color: AppColors.primary, height: 1.2),
          ),
          const SizedBox(height: 3),
          Text(
            program.subtitle,
            style: AppTextStyle.body(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.accentAmber,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            program.description,
            style: AppTextStyle.body(fontSize: 12, color: AppColors.textMuted, height: 1.4),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary, width: 1.4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: Text(
                'Ver Plan de Estudios',
                style: AppTextStyle.body(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 20),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyle.body(fontSize: 10, color: AppColors.textDim)),
        Text(value, style: AppTextStyle.body(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
      ],
    );
  }
}
