class FaqModel {
  final String id;
  final String question;
  final String answer;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  static const List<FaqModel> sampleFaqs = [
    FaqModel(
      id: 'f1',
      question: '¿Cuál es el proceso de admisión y evaluación de ingreso?',
      answer: 'El proceso inicia con una solicitud en línea, seguida de una sesión de evaluación psicopedagógica y diagnóstica de idiomas, finalizando con una entrevista familiar con la dirección académica.',
    ),
    FaqModel(
      id: 'f2',
      question: '¿El colegio ofrece programas de becas o descuentos por hermanos?',
      answer: 'Sí. Contamos con becas de excelencia académica y deportiva a partir de 5° de primaria, así como un 10% de descuento en colegiatura para el segundo hermano y 15% a partir del tercero.',
    ),
    FaqModel(
      id: 'f3',
      question: '¿Qué certificaciones internacionales obtienen los graduados?',
      answer: 'Los estudiantes obtienen certificaciones Cambridge English (B2 First / C1 Advanced), DELF Francés (B1/B2), certificación de código Python/STEM y el Diploma del Bachillerato Internacional (IB).',
    ),
    FaqModel(
      id: 'f4',
      question: '¿Cuentan con servicio de transporte escolar y comedor nutricional?',
      answer: 'Sí, disponemos de rutas de transporte escolar monitoreadas por GPS con supervisores a bordo, y un servicio de comedor con menús balanceados diseñados por nutriólogos infantiles.',
    ),
    FaqModel(
      id: 'f5',
      question: '¿Cuáles son los horarios escolares y de actividades extracurriculares?',
      answer: 'La jornada académica regular concluye entre 1:30 PM y 3:30 PM según el nivel escolar. Los talleres deportivos, artísticos y tecnológicos se imparten de 3:30 PM a 5:30 PM.',
    ),
  ];
}
