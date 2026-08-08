import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import 'widgets/notebook_paper_painter.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/programs_section.dart';
import 'widgets/stats_section.dart';
import 'widgets/calculator_section.dart';
import 'widgets/campus_section.dart';
import 'widgets/events_section.dart';
import 'widgets/testimonials_section.dart';
import 'widgets/faqs_section.dart';
import 'widgets/admissions_section.dart';
import 'widgets/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _programsKey = GlobalKey();
  final GlobalKey _statsKey = GlobalKey();
  final GlobalKey _calculatorKey = GlobalKey();
  final GlobalKey _campusKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _faqsKey = GlobalKey();
  final GlobalKey _admissionsKey = GlobalKey();

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    switch (section) {
      case 'hero':
        targetKey = _heroKey;
        break;
      case 'programs':
        targetKey = _programsKey;
        break;
      case 'stats':
        targetKey = _statsKey;
        break;
      case 'calculator':
        targetKey = _calculatorKey;
        break;
      case 'campus':
        targetKey = _campusKey;
        break;
      case 'events':
        targetKey = _eventsKey;
        break;
      case 'testimonials':
        targetKey = _testimonialsKey;
        break;
      case 'faqs':
        targetKey = _faqsKey;
        break;
      case 'admissions':
        targetKey = _admissionsKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: CustomAppBar(
        onAdmissionPressed: () => _scrollToSection('admissions'),
        onNavigateToSection: _scrollToSection,
      ),
      drawer: Drawer(
        backgroundColor: AppColors.bgSurfaceElevated,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.school_rounded, color: AppColors.accentAmber, size: 32),
                      const SizedBox(width: 10),
                      Text(
                        'HORIZON',
                        style: AppTextStyle.heading(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'INTERNATIONAL ACADEMY',
                    style: AppTextStyle.body(fontSize: 11, color: AppColors.accentAmber, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _DrawerTile(icon: Icons.home_rounded, title: 'Inicio', onTap: () => _scrollToSection('hero')),
            _DrawerTile(icon: Icons.menu_book_rounded, title: 'Programas Académicos', onTap: () => _scrollToSection('programs')),
            _DrawerTile(icon: Icons.bar_chart_rounded, title: 'Estadísticas', onTap: () => _scrollToSection('stats')),
            _DrawerTile(icon: Icons.calculate_rounded, title: 'Simulador Colegiaturas', onTap: () => _scrollToSection('calculator')),
            _DrawerTile(icon: Icons.business_rounded, title: 'Instalaciones', onTap: () => _scrollToSection('campus')),
            _DrawerTile(icon: Icons.event_rounded, title: 'Noticias & Eventos', onTap: () => _scrollToSection('events')),
            _DrawerTile(icon: Icons.rate_review_rounded, title: 'Testimonios', onTap: () => _scrollToSection('testimonials')),
            _DrawerTile(icon: Icons.help_outline_rounded, title: 'Preguntas Frecuentes', onTap: () => _scrollToSection('faqs')),
            _DrawerTile(icon: Icons.assignment_turned_in_rounded, title: 'Solicitud de Admisión', onTap: () => _scrollToSection('admissions')),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Fondo de cuaderno escolar dibujado con CustomPainter
          Positioned.fill(
            child: CustomPaint(
              painter: const NotebookPaperPainter(),
            ),
          ),

          // Contenido desplazable con scroll suave
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                KeyedSubtree(key: _heroKey, child: HeroSection(
                  onExplorePrograms: () => _scrollToSection('programs'),
                  onAdmissions: () => _scrollToSection('admissions'),
                )),
                KeyedSubtree(key: _programsKey, child: ProgramsSection(
                  onAdmissionsPressed: () => _scrollToSection('admissions'),
                )),
                KeyedSubtree(key: _statsKey, child: const StatsSection()),
                KeyedSubtree(key: _calculatorKey, child: CalculatorSection(
                  onAdmissionsPressed: () => _scrollToSection('admissions'),
                )),
                KeyedSubtree(key: _campusKey, child: const CampusSection()),
                KeyedSubtree(key: _eventsKey, child: const EventsSection()),
                KeyedSubtree(key: _testimonialsKey, child: const TestimonialsSection()),
                KeyedSubtree(key: _faqsKey, child: const FaqsSection()),
                KeyedSubtree(key: _admissionsKey, child: const AdmissionsSection()),
                const FooterSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTextStyle.body(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textMain)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
