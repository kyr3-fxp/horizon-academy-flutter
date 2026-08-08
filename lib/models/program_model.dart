class ProgramModel {
  final String id;
  final String title;
  final String subtitle;
  final String ageRange;
  final String schedule;
  final String ratio;
  final String description;
  final List<String> highlights;
  final String iconName;

  const ProgramModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.ageRange,
    required this.schedule,
    required this.ratio,
    required this.description,
    required this.highlights,
    required this.iconName,
  });

  static const List<ProgramModel> samplePrograms = [
    ProgramModel(
      id: 'preschool',
      title: 'Preschool & Early Learning',
      subtitle: 'Educación Temprana Bilingüe',
      ageRange: '2 a 5 años',
      schedule: '8:00 AM - 1:30 PM',
      ratio: '1 Docente por 8 Alumnos',
      description: 'Estimulación temprana, aprendizaje basado en el juego y primer contacto inmersivo con el idioma inglés.',
      highlights: [
        'Desarrollo socioemocional y motricidad fina',
        'Inmersión 100% en inglés',
        'Huerto escolar y laboratorio sensorial',
        'Talleres de expresión artística y música',
      ],
      iconName: 'child_care',
    ),
    ProgramModel(
      id: 'primary',
      title: 'Elementary School',
      subtitle: 'Primaria Bicultural',
      ageRange: '6 a 11 años',
      schedule: '7:45 AM - 2:30 PM',
      ratio: '1 Docente por 15 Alumnos',
      description: 'Fundamentos académicos sólidos con enfoque STEM, pensamiento crítico y hábitos de liderazgo.',
      highlights: [
        'Programa de Matemáticas Singapur',
        'Laboratorio de Robótica y Coding',
        'Feria anual de Ciencias e Innovación',
        'Deportes integrados: Natación, Fútbol y Baloncesto',
      ],
      iconName: 'school',
    ),
    ProgramModel(
      id: 'secondary',
      title: 'Middle School',
      subtitle: 'Secundaria Internacional',
      ageRange: '12 a 14 años',
      schedule: '7:30 AM - 3:00 PM',
      ratio: '1 Docente por 18 Alumnos',
      description: 'Desarrollo de pensamiento autónomo, investigación científica, debate y certificación de idiomas.',
      highlights: [
        'Certificaciones Cambridge B2/C1',
        'Club de Model United Nations (MUN)',
        'Proyectos de impacto comunitario',
        'Intercambios internacionales de verano',
      ],
      iconName: 'menu_book',
    ),
    ProgramModel(
      id: 'highschool',
      title: 'IB High School',
      subtitle: 'Bachillerato Internacional (IB)',
      ageRange: '15 a 18 años',
      schedule: '7:30 AM - 3:30 PM',
      ratio: '1 Docente por 12 Alumnos',
      description: 'Diploma Internacional IB que abre las puertas a las mejores universidades de México y el extranjero.',
      highlights: [
        'Diploma del Bachillerato Internacional (IBDP)',
        'Asesoría universitaria y orientación vocacional',
        'Pasantías y proyectos de emprendimiento',
        'Programa CAS (Creatividad, Actividad y Servicio)',
      ],
      iconName: 'workspace_premium',
    ),
  ];
}
