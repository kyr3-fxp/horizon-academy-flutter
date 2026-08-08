class TestimonialModel {
  final String id;
  final String authorName;
  final String role; // p. ej. 'Madre de Alumno de Primaria'
  final String quote;
  final double rating;
  final String avatarUrl;

  const TestimonialModel({
    required this.id,
    required this.authorName,
    required this.role,
    required this.quote,
    required this.rating,
    required this.avatarUrl,
  });

  static const List<TestimonialModel> sampleTestimonials = [
    TestimonialModel(
      id: 't1',
      authorName: 'Dra. María Elena Garza',
      role: 'Madre de alumna en Primaria & Secundaria',
      quote: 'Horizon International Academy no solo ofreció a mis hijas un nivel académico bilingüe de excelencia, sino un ambiente seguro donde desarrollan pensamiento crítico y valores humanos firmes.',
      rating: 5.0,
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=250&q=80',
    ),
    TestimonialModel(
      id: 't2',
      authorName: 'Ing. Carlos Mendoza',
      role: 'Padre de alumno graduado del Bachillerato IB',
      quote: 'Gracias al diploma IB de Horizon, mi hijo fue admitido en el Tec de Monterrey con beca académica y créditos revalidados. El nivel en matemáticas y ciencias es insuperable.',
      rating: 5.0,
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80',
    ),
    TestimonialModel(
      id: 't3',
      authorName: 'Sofia Ramírez',
      role: 'Exalumna generación 2024 (Estudiante en King\'s College London)',
      quote: 'El modelo educativo de Horizon me enseñó a investigar, debatir y adaptarme a cualquier entorno cultural. Me sentí completamente preparada para la vida universitaria internacional.',
      rating: 5.0,
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=250&q=80',
    ),
  ];
}
