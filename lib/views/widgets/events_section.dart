import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../controllers/school_controller.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final controller = context.watch<SchoolController>();
    final events = controller.filteredEvents;

    final categories = ['Todos', 'Académicos', 'Deportes', 'Arte & Cultura'];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'Noticias & Eventos Destacados',
            style: AppTextStyle.heading(
              fontSize: isDesktop ? 36 : 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mantente informado sobre las actividades, logros estudiantiles y próximas fechas del calendario escolar.',
            style: AppTextStyle.body(fontSize: 16, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Pestañas / Chips de Selección
          Wrap(
            spacing: 12,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: categories.map((cat) {
              final isSelected = controller.selectedEventCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) controller.setEventCategory(cat);
                },
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.bgSurface,
                labelStyle: AppTextStyle.body(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.textMain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.borderPaper,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              );
            }).toList(),
          ),
          const SizedBox(height: 36),

          // Lista de Tarjetas de Eventos
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final e = events[index];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderPaper),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Caja de Fecha
                    Container(
                      width: 65,
                      height: 75,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e.dateDay,
                            style: AppTextStyle.heading(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentAmber,
                            ),
                          ),
                          Text(
                            e.dateMonth,
                            style: AppTextStyle.body(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Detalles del Evento
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGreenSoft,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  e.category,
                                  style: AppTextStyle.body(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textDim),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      e.location,
                                      style: AppTextStyle.body(fontSize: 11, color: AppColors.textDim),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Text(
                            e.title,
                            style: AppTextStyle.heading(fontSize: 17, color: AppColors.primary),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            e.description,
                            style: AppTextStyle.body(fontSize: 13, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
