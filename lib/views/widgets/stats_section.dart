import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return VisibilityDetector(
      key: const Key('stats_section_key'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isDesktop ? 60 : 20,
          vertical: 40,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 650;
            return Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 30,
              runSpacing: 30,
              children: [
                _StatCard(
                  targetValue: 1250,
                  suffix: '+',
                  label: 'Estudiantes Activos',
                  isVisible: _isVisible,
                  width: isMobile ? (constraints.maxWidth - 20) / 2 : 180,
                ),
                _StatCard(
                  targetValue: 99,
                  suffix: '%',
                  label: 'Ingreso Universitario',
                  isVisible: _isVisible,
                  width: isMobile ? (constraints.maxWidth - 20) / 2 : 180,
                ),
                _StatCard(
                  targetValue: 28,
                  suffix: '',
                  label: 'Clubes & Talleres STEAM',
                  isVisible: _isVisible,
                  width: isMobile ? (constraints.maxWidth - 20) / 2 : 180,
                ),
                _StatCard(
                  targetValue: 25,
                  suffix: ' Años',
                  label: 'Excelencia Educativa',
                  isVisible: _isVisible,
                  width: isMobile ? (constraints.maxWidth - 20) / 2 : 180,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final int targetValue;
  final String suffix;
  final String label;
  final bool isVisible;
  final double width;

  const _StatCard({
    required this.targetValue,
    required this.suffix,
    required this.label,
    required this.isVisible,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: isVisible ? targetValue.toDouble() : 0),
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Text(
                '${value.toInt()}$suffix',
                style: AppTextStyle.heading(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentAmber,
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyle.body(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
