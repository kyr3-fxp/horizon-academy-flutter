import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../controllers/school_controller.dart';

class CalculatorSection extends StatelessWidget {
  final VoidCallback onAdmissionsPressed;

  const CalculatorSection({super.key, required this.onAdmissionsPressed});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final controller = context.watch<SchoolController>();
    final calc = controller.currentCalculation;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          // Título de Sección
          Text(
            'Simulador de Colegiaturas',
            style: AppTextStyle.heading(
              fontSize: isDesktop ? 36 : 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Personaliza los servicios y calcula la inversión educativa mensual para tu hijo en tiempo real.',
            style: AppTextStyle.body(fontSize: 16, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Tarjeta de la Calculadora
          Container(
            padding: EdgeInsets.all(isDesktop ? 36 : 20),
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderPaper, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Columna de Configuración (Inputs)
                    Expanded(
                      flex: isDesktop ? 7 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1. Selección de Nivel Académico',
                            style: AppTextStyle.heading(fontSize: 18, color: AppColors.primary),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: controller.selectedLevel,
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.bgMain,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: AppColors.borderPaper),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'preschool',
                                child: Text(
                                  'Preschool & Early Learning (\$7,200 MXN / mes)',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'primary',
                                child: Text(
                                  'Elementary School / Primaria (\$9,800 MXN / mes)',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'secondary',
                                child: Text(
                                  'Middle School / Secundaria (\$11,500 MXN / mes)',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'highschool',
                                child: Text(
                                  'IB High School / Bachillerato (\$14,200 MXN / mes)',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) controller.setLevel(val);
                            },
                          ),
                          const SizedBox(height: 28),

                          Text(
                            '2. Servicios Adicionales',
                            style: AppTextStyle.heading(fontSize: 18, color: AppColors.primary),
                          ),
                          const SizedBox(height: 10),

                          // Transporte
                          CheckboxListTile(
                            title: const Text('Transporte Escolar con GPS Monitorizado'),
                            subtitle: const Text('+\$1,200 MXN al mes (Ruta ida y vuelta)'),
                            activeColor: AppColors.primary,
                            value: controller.includeTransport,
                            onChanged: controller.toggleTransport,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          // Comedor
                          CheckboxListTile(
                            title: const Text('Comedor Nutricional Diseñado por Nutriólogos'),
                            subtitle: const Text('+\$1,500 MXN al mes (Menú saludable balanceado)'),
                            activeColor: AppColors.primary,
                            value: controller.includeCafeteria,
                            onChanged: controller.toggleCafeteria,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          const SizedBox(height: 24),

                          Text(
                            '3. Talleres & Clubes Extracurriculares',
                            style: AppTextStyle.heading(fontSize: 18, color: AppColors.primary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Robótica, Natación, Música, Danza, Debate (\$400 MXN c/u)',
                            style: AppTextStyle.body(fontSize: 13, color: AppColors.textMuted),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: controller.workshopCount.toDouble(),
                                  min: 0,
                                  max: 4,
                                  divisions: 4,
                                  activeColor: AppColors.primary,
                                  label: '${controller.workshopCount} Talleres',
                                  onChanged: (val) => controller.setWorkshopCount(val.toInt()),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGreenSoft,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${controller.workshopCount} ${controller.workshopCount == 1 ? "taller" : "talleres"}',
                                  style: AppTextStyle.body(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    if (isDesktop) const SizedBox(width: 40) else const SizedBox(height: 30),

                    // Columna de Resumen (Output en tiempo real)
                    Expanded(
                      flex: isDesktop ? 5 : 0,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calculate_rounded, color: AppColors.accentAmber, size: 24),
                                const SizedBox(width: 10),
                                Text(
                                  'Resumen de Inversión',
                                  style: AppTextStyle.heading(fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.white24, height: 24),

                            _CalcRow(label: 'Colegiatura Base (${calc.levelName})', value: '\$${calc.baseTuition.toInt()} MXN'),
                            if (calc.hasTransport) _CalcRow(label: 'Transporte Escolar', value: '+\$${calc.transportCost.toInt()} MXN'),
                            if (calc.hasCafeteria) _CalcRow(label: 'Comedor Nutricional', value: '+\$${calc.cafeteriaCost.toInt()} MXN'),
                            if (calc.workshopCount > 0)
                              _CalcRow(
                                label: 'Talleres (${calc.workshopCount} x \$${calc.workshopCostPerItem.toInt()})',
                                value: '+\$${calc.totalWorkshopsCost.toInt()} MXN',
                              ),

                            const Divider(color: Colors.white24, height: 24),

                            Text(
                              'Inversión Mensual Estimada',
                              style: AppTextStyle.body(fontSize: 13, color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${calc.totalMonthlyInvestment.toStringAsFixed(0)} MXN',
                              style: AppTextStyle.heading(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accentAmber,
                              ),
                            ),
                            Text(
                              'Inversión Anual (10 meses): \$${calc.annualInvestment.toStringAsFixed(0)} MXN',
                              style: AppTextStyle.body(fontSize: 12, color: Colors.white70),
                            ),
                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: onAdmissionsPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentAmber,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Text('Solicitar Plan de Becas / Información', style: AppTextStyle.button(fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  final String label;
  final String value;

  const _CalcRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.body(fontSize: 13, color: Colors.white.withValues(alpha: 0.9)),
            ),
          ),
          Text(
            value,
            style: AppTextStyle.body(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
