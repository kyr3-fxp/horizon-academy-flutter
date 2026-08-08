class EventModel {
  final String id;
  final String title;
  final String category; // 'Académicos', 'Deportes', 'Arte & Cultura'
  final String dateDay;
  final String dateMonth;
  final String description;
  final String location;

  const EventModel({
    required this.id,
    required this.title,
    required this.category,
    required this.dateDay,
    required this.dateMonth,
    required this.description,
    required this.location,
  });

  static const List<EventModel> sampleEvents = [
    EventModel(
      id: 'e1',
      title: 'Feria de Ciencias & Innovación STEAM 2026',
      category: 'Académicos',
      dateDay: '15',
      dateMonth: 'OCT',
      description: 'Presentación de proyectos de robótica, energía renovable e inteligencia artificial por parte de nuestros alumnos.',
      location: 'Auditorio Principal Horizon',
    ),
    EventModel(
      id: 'e2',
      title: 'Torneo Interescolar de Natación y Atletismo',
      category: 'Deportes',
      dateDay: '28',
      dateMonth: 'OCT',
      description: 'Nuestros equipos representativos compiten por la copa regional en las instalaciones del complejo deportivo.',
      location: 'Complejo Deportivo Campus Norte',
    ),
    EventModel(
      id: 'e3',
      title: 'Exposición Anual de Arte Contemporáneo & Teatro',
      category: 'Arte & Cultura',
      dateDay: '10',
      dateMonth: 'NOV',
      description: 'Muestra gastronómica, esculturas, galerías de pintura y la obra musical "El Principito" interpretada por bachillerato.',
      location: 'Foro Cultural Horizon',
    ),
    EventModel(
      id: 'e4',
      title: 'Simulación Model United Nations (HorizonMUN)',
      category: 'Académicos',
      dateDay: '22',
      dateMonth: 'NOV',
      description: 'Debate geopolítico en inglés con delegaciones invitadas de más de 12 colegios internacionales.',
      location: 'Centro de Convenciones Horizon',
    ),
  ];
}
