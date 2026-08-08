import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/testimonial_model.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final testimonials = TestimonialModel.sampleTestimonials;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'Lo que Dicen Nuestras Familias',
            style: AppTextStyle.heading(
              fontSize: isDesktop ? 36 : 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Historias de éxito, crecimiento y satisfacción compartidas por padres de familia y alumnos.',
            style: AppTextStyle.body(fontSize: 16, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Carrusel de Testimonios
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: testimonials.length,
                options: CarouselOptions(
                  height: isDesktop ? 260 : 320,
                  viewportFraction: isDesktop ? 0.65 : 0.95,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  final t = testimonials[index];
                  return Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.bgSurface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.borderPaper, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Estrellas
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (i) => const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Cita
                        Text(
                          '"${t.quote}"',
                          style: AppTextStyle.body(
                            fontSize: isDesktop ? 15 : 13,
                            fontStyle: FontStyle.italic,
                            color: AppColors.textMain,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 20),

                        // Autor
                        Text(
                          t.authorName,
                          style: AppTextStyle.heading(fontSize: 16, color: AppColors.primary),
                        ),
                        Text(
                          t.role,
                          style: AppTextStyle.body(fontSize: 12, color: AppColors.accentAmber, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Botones Anterior / Siguiente (Solo Desktop)
              if (isDesktop) ...[
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary, size: 28),
                    onPressed: () => _carouselController.previousPage(),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 28),
                    onPressed: () => _carouselController.nextPage(),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),

          // Indicador de Puntos (Dots Indicator)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: testimonials.asMap().entries.map((entry) {
              final isSelected = _currentIndex == entry.key;
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSelected ? 24 : 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.borderPaper,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
