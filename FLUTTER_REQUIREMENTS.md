# 📱 Requisitos & Guía de Arquitectura: Recreación de Horizon International Academy en Flutter (Dart)

Este documento especifica todos los **requisitos funcionales, no funcionales, sistema de diseño y arquitectura de software** necesarios para recrear la landing page de **Horizon International Academy** utilizando **Flutter & Dart** (Web, Mobile y Desktop), manteniendo exactamente el mismo diseño, estética de cuaderno escolar y funciones interactivas.

---

## 🎯 1. Visión General del Proyecto

- **Framework**: Flutter (Web & Cross-Platform)
- **Lenguaje**: Dart (3.0+)
- **Patrón de Arquitectura**: MVC / Clean Architecture con Gestión de Estado Declarativa (`Provider`, `Riverpod` o `ChangeNotifier`).
- **Tema Visual**: Estilo **Cuaderno Escolar (Ruled Notebook Paper Theme)** con renglones azules, línea de margen roja a la izquierda, tipografía Serif *Playfair Display* y acentos Verde Bosque.

---

## 📦 2. Dependencias Recomendadas (`pubspec.yaml`)

```yaml
name: horizon_academy_flutter
description: Landing page de Horizon International Academy en Flutter Web & Cross-Platform.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Tipografías de Google (Playfair Display & Plus Jakarta Sans)
  google_fonts: ^6.1.0
  
  # Gestión de Estado declarativa (MVC / State Management)
  provider: ^6.1.1 # O flutter_riverpod: ^2.4.9
  
  # Carrusel interactivo para testimonios
  carousel_slider: ^4.2.1
  
  # Enlaces y apertura de mapas/correos/teléfonos
  url_launcher: ^6.2.2
  
  # Animaciones suaves al hacer scroll
  visibility_detector: ^0.4.0+2
  
  # Utilidades de diseño responsivo
  responsive_framework: ^1.1.1
  gap: ^3.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/hero.jpg
    - assets/images/steam_lab.jpg
    - assets/images/sports.jpg
    - assets/images/notebook_paper.jpg
```

---

## 🎨 3. Sistema de Diseño (Design System Tokens en Flutter)

### 3.1 Paleta de Colores (`AppColors`)

```dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color bgMain = Color(0xFFFCFCFB);         // Blanco papel crema
  static const Color bgSurface = Color(0xFFFFFFFF);      // Blanco puro tarjetas
  static const Color bgSurfaceElevated = Color(0xFFFAF8F5); // Fondo elevado modal
  static const Color borderPaper = Color(0xFFE2DCD2);    // Borde fibra de papel
  
  // Renglones de Cuaderno
  static const Color notebookBlueLine = Color(0x474A77CC); // Renglón azul (rgba(74,119,204,0.28))
  static const Color notebookRedMargin = Color(0xD9E85D5D); // Línea de margen roja

  // Marca & Acentos
  static const Color primary = Color(0xFF1B3826);        // Verde Bosque Profundo
  static const Color primaryHover = Color(0xFF12281A);
  static const Color primaryLight = Color(0xFF2C523A);   // Verde Sabio
  static const Color accentAmber = Color(0xFFB57A44);    // Terracota / Ocre
  static const Color accentRose = Color(0xFFD94343);
  
  // Texto
  static const Color textMain = Color(0xFF181B19);       // Tinta negra
  static const Color textMuted = Color(0xFF555A53);      // Gris taupe
  static const Color textDim = Color(0xFF82877E);
}
```

### 3.2 Tipografía (`AppTextStyle`)

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle heading({
    double fontSize = 32,
    FontWeight fontWeight = FontWeight.bold,
    Color color = AppColors.textMain,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle body({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textMuted,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.6,
    );
  }
}
```

---

## 🎨 4. Custom Painter: Fondo de Hoja de Cuaderno Escolar

En Flutter, el fondo de renglones azules con la línea roja de margen se recrea usando un `CustomPainter` de alto rendimiento dibuando sobre el canvas:

```dart
import 'package:flutter/material.dart';

class NotebookPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0x474A77CC) // Azul renglón
      ..strokeWidth = 1.0;

    final Paint marginPaint = Paint()
      ..color = const Color(0xD9E85D5D) // Rojo margen
      ..strokeWidth = 2.0;

    // 1. Dibujar Renglones Azules Horizontales (cada 32px)
    const double lineSpacing = 32.0;
    for (double y = lineSpacing; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 2. Dibujar Línea de Margen Roja Vertical (a 80px de la izquierda)
    const double marginX = 80.0;
    canvas.drawLine(Offset(marginX, 0), Offset(marginX, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
```

---

## 🏗️ 5. Arquitectura MVC en Flutter

La estructura de directorios sigue la separación estricta de responsabilidades:

```
lib/
├── main.dart                      # Entry point & MaterialApp config
├── constants/
│   ├── app_colors.dart            # Paleta de colores
│   └── app_styles.dart            # Tipografía Google Fonts
├── models/
│   ├── school_model.dart          # Modelo principal de datos
│   ├── program_model.dart         # Data model de nivel educativo
│   ├── event_model.dart           # Data model de eventos y noticias
│   ├── testimonial_model.dart     # Data model de testimonios
│   ├── faq_model.dart             # Data model de FAQs
│   └── tuition_calculation.dart   # Resultado de cálculo de colegiatura
├── controllers/
│   └── school_controller.dart     # Controller (ChangeNotifier / BLoC / State)
├── views/
│   ├── home_page.dart             # Scaffold principal con CustomScrollView
│   └── widgets/
│       ├── custom_app_bar.dart    # Sticky Navigation Header & Drawer
│       ├── hero_section.dart      # Banner Hero con badges flotantes
│       ├── programs_section.dart  # Grid de programas & Dialog modal
│       ├── stats_section.dart     # Contador animado de estadísticas
│       ├── calculator_section.dart# Simulador de colegiaturas en tiempo real
│       ├── campus_section.dart    # Galería de instalaciones
│       ├── events_section.dart    # Filtro de pestañas de eventos
│       ├── testimonials_section.dart # Carrusel de testimonios
│       ├── faqs_section.dart      # Acordeón de preguntas frecuentes (ExpansionTile)
│       ├── admissions_section.dart# Formulario validado de contacto
│       └── footer_section.dart    # Pie de página
```

---

## ⚡ 6. Requisitos Funcionales por Módulo

### 6.1 Navegación Pegajosa & Menú Drawer (`CustomAppBar`)
- **Desktop**: Bar pegajoso transparente que al hacer scroll se vuelve blanco con sombra suave (`SliverAppBar` o `Listener` sobre `ScrollController`).
- **Mobile**: Menú de hamburguesa que despliega un `Drawer` lateral con enlaces navegables usando `ScrollController.animateTo()`.

### 6.2 Sección Hero (`HeroSection`)
- Banner con título en *Playfair Display*, sub-banner y 2 botones CTA principales ("Explorar Programas" y "Tour Virtual 360°").
- Badge flotantes (`FloatingBadgeWidget`) animados con `AnimationController` / `TweenAnimationBuilder` usando `Transform.translate`.
- Botón "Tour Virtual": Abre un `showDialog()` con vista previa de video / imagen interactiva.

### 6.3 Programas Académicos (`ProgramsSection`)
- Muestra 4 tarjetas (Preschool, Primaria, Secundaria, Bachillerato IB).
- Cada tarjeta incluye botón "Ver plan de estudios" que invoca `showDialog()` o `showModalBottomSheet()` mostrando:
  - Horario, Rango de edad, Ratio docente/alumno.
  - Lista de ejes curriculares con checks verdes (`Icons.check_circle`).
  - Botón de acción hacia el formulario de admisiones.

### 6.4 Contador de Estadísticas Animado (`StatsSection`)
- Al entrar en el viewport (`visibility_detector`), los 4 números (1250+ Estudiantes, 99% Ingreso, 28 Clubes, 25 Años) incrementan desde 0 hasta su valor objetivo usando `TweenAnimationBuilder<double>`.

### 6.5 Calculadora Interactiva de Colegiaturas (`CalculatorSection`)
- **Inputs**:
  - `DropdownButtonFormField` para selección de nivel educativo.
  - `CheckboxListTile` para Transporte Escolar ($1,200 MXN) y Comedor Nutricional ($1,500 MXN).
  - `Slider` para número de talleres extracurriculares ($400 MXN c/u, de 0 a 4).
- **Output en Tiempo Real**:
  - Al cambiar cualquier input, el `SchoolController` recalcula inmediatamente la inversión mensual y notifica a la UI (`notifyListeners()`).

### 6.6 Filtro de Noticias & Eventos (`EventsSection`)
- Barra de pestañas (`SegmentedButton` o lista de `FilterChip` personalizados): *Todos*, *Académicos*, *Deportes*, *Arte & Cultura*.
- Filtra reactivamente la lista de tarjetas de eventos mostrando la caja de fecha en color verde bosque.

### 6.7 Carrusel de Testimonios (`TestimonialsSection`)
- Construido con `CarouselSlider` o `PageView.builder`.
- Incluye botones "Anterior" y "Siguiente", indicadores de punto (*dots indicator*) y auto-reproducción cada 7 segundos.

### 6.8 Acordeón de FAQs (`FaqsSection`)
- Lista de elementos expansibles construida con `ExpansionTile` animado o `AnimatedCrossFade`.
- Al abrir una pregunta, cierra automáticamente las demás.

### 6.9 Formulario de Admisiones & Feedback (`AdmissionsSection`)
- `Form` con validación mediante `GlobalKey<FormState>()`.
- Campos: Nombre Completo, Correo, Teléfono, Nivel de Interés y Mensaje.
- Al enviar válidamente:
  - Muestra un `ScaffoldMessenger.of(context).showSnackBar()` tipo Toast.
  - Abre un `showDialog()` de confirmación con ícono de verificación.

---

## 🚀 7. Requisitos No Funcionales & Optimización en Flutter Web

1. **Rendimiento a 60 FPS**:
   - Uso de `const` constructors en todos los widgets estáticos.
   - Evitar llamadas innecesarias a `setState()` usando `Selector` o `Consumer` de Provider.
   - Renderizado con CanvaKit / HTML Renderer según plataforma.
2. **Imágenes Ligeras**:
   - Carga diferida de imágenes con `FadeInImage.assetNetwork` o imágenes locales comprimidas en `assets/images/` (máximo 200 KB cada una).
3. **Diseño Responsivo**:
   - Uso de `LayoutBuilder` y `MediaQuery` para adaptar el layout entre móvil (`width < 768px`), tablet (`768px <= width < 1024px`) y desktop (`width >= 1024px`).
