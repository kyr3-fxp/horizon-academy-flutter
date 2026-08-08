# 📱 Horizon International Academy — Flutter Web & Cross-Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.44.8-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.style=for-the-badge)](#licencia)
[![Platform](https://img.shields.io/badge/Platform-Web%20%7C%20Android%20%7C%20iOS%20%7C%20Desktop-blue.svg?style=for-the-badge)](#soporte-multiplataforma)

Landing page multiplataforma (Web, Móvil y Escritorio) para **Horizon International Academy**, desarrollada con **Flutter & Dart**. Presenta una estética visual inspirada en un **cuaderno escolar tradicional** (*Ruled Notebook Paper Theme*) combinada con las mejores prácticas de diseño moderno, animaciones fluidas a 60 FPS y una arquitectura modular reactiva (MVC).

---

## 🎨 Identidad Visual & Sistema de Diseño

El sistema de diseño recrea la experiencia de un cuaderno escolar tradicional mediante un renderizado vectorial personalizado en tiempo real:

- **Fondo de Cuaderno Escolar (`CustomPainter`)**: Renglones horizontales en azul tenue (`#4A77CC`) y línea de margen vertical roja (`#E85D5D`).
- **Paleta de Colores de Marca**:
  - 🌲 **Verde Bosque Profundo** (`#1B3826`): Identidad institucional y elementos primarios.
  - 🌾 **Terracota / Ocre** (`#B57A44`): Acentos, badges y destacados.
  - 📜 **Papel Crema** (`#FCFCFB`): Fondo general suave para reducir fatiga visual.
- **Tipografías (Google Fonts)**:
  - **Playfair Display**: Encabezados elegantes y serifados.
  - **Plus Jakarta Sans**: Cuerpo de texto moderno, legible y limpio.

---

## ✨ Características y Módulos Interactivos

| Módulo | Descripción | Componente |
| :--- | :--- | :--- |
| 📌 **Header Sticky & Menú** | Navegación pegajosa superior en escritorio y menú desplegable *Drawer* responsivo en móviles. | [`CustomAppBar`](lib/views/widgets/custom_app_bar.dart) |
| 🚀 **Hero Banner & Tour 360°** | Presentación principal con badges flotantes animados y diálogo modal interactivo de Tour Virtual. | [`HeroSection`](lib/views/widgets/hero_section.dart) |
| 🎓 **Programas Académicos** | Tarjetas de niveles educativos (Preschool, Primaria, Secundaria, Bachillerato IB) con modales detallados de plan de estudios. | [`ProgramsSection`](lib/views/widgets/programs_section.dart) |
| 📊 **Contador de Métricas** | Animación numérica de estadísticas (alumnos, % ingreso universitario, clubes) activada al hacer scroll. | [`StatsSection`](lib/views/widgets/stats_section.dart) |
| 🧮 **Calculadora de Colegiaturas** | Simulador en tiempo real con dropdowns, sliders y checkboxes para desglosar inversión mensual y anual. | [`CalculatorSection`](lib/views/widgets/calculator_section.dart) |
| 🏫 **Galería del Campus** | Exposición visual de instalaciones (STEAM Lab, Alberca, Auditorio, Biblioteca). | [`CampusSection`](lib/views/widgets/campus_section.dart) |
| 📰 **Filtro de Eventos** | Filtro dinámico por pestañas (*Todos*, *Académicos*, *Deportes*, *Arte & Cultura*). | [`EventsSection`](lib/views/widgets/events_section.dart) |
| 💬 **Carrusel de Testimonios** | Slider interactivo con opiniones de familias y exalumnos con autodesplazamiento. | [`TestimonialsSection`](lib/views/widgets/testimonials_section.dart) |
| ❓ **Preguntas Frecuentes** | Acordeón animado (`ExpansionTile`) para resolver dudas frecuentes sobre admisiones y becas. | [`FaqsSection`](lib/views/widgets/faqs_section.dart) |
| 📝 **Formulario de Admisiones** | Formulario con validación de campos, animaciones de carga y cuadros de diálogo de confirmación. | [`AdmissionsSection`](lib/views/widgets/admissions_section.dart) |

---

## 🏗️ Arquitectura del Proyecto (MVC)

El proyecto sigue una separación limpia de responsabilidades:

```text
lib/
├── main.dart                      # Punto de entrada principal, Provider & MaterialApp
├── constants/
│   ├── app_colors.dart            # Tokens de color del Design System
│   └── app_styles.dart            # Estilos de tipografía con Google Fonts
├── models/
│   ├── program_model.dart         # Modelo de datos de programas académicos
│   ├── event_model.dart           # Modelo de noticias y eventos
│   ├── testimonial_model.dart     # Modelo de testimonios
│   ├── faq_model.dart             # Modelo de preguntas frecuentes
│   └── tuition_calculation.dart   # Modelo del simulador de colegiaturas
├── controllers/
│   └── school_controller.dart     # Controlador de estado principal (ChangeNotifier)
└── views/
    ├── home_page.dart             # Scaffold principal con CustomScrollView y CustomPaint
    └── widgets/                   # Componentes modulares reutilizables
        ├── notebook_paper_painter.dart # CustomPainter para las líneas de cuaderno
        ├── custom_app_bar.dart    # Barra de navegación pegajosa
        ├── hero_section.dart      # Banner Hero principal
        ├── programs_section.dart  # Grid de programas educativos
        ├── stats_section.dart     # Contador animado de métricas
        ├── calculator_section.dart# Simulador reactivo de colegiaturas
        ├── campus_section.dart    # Instalaciones del campus
        ├── events_section.dart    # Filtro interactivo de noticias
        ├── testimonials_section.dart # Carrusel de testimonios
        ├── faqs_section.dart      # Acordeón de FAQs
        ├── admissions_section.dart# Formulario validado de contacto
        └── footer_section.dart    # Pie de página institucional
```

---

## 📦 Dependencias Clave

- **[`provider`](https://pub.dev/packages/provider)**: Gestión de estado declarativa reactiva.
- **[`google_fonts`](https://pub.dev/packages/google_fonts)**: Carga dinámica de tipografías Playfair Display y Plus Jakarta Sans.
- **[`carousel_slider`](https://pub.dev/packages/carousel_slider)**: Carrusel responsivo para testimonios.
- **[`visibility_detector`](https://pub.dev/packages/visibility_detector)**: Disparo de animaciones al desplazar la vista.
- **[`url_launcher`](https://pub.dev/packages/url_launcher)**: Enlaces externos y apertura de canales de contacto.
- **[`gap`](https://pub.dev/packages/gap)**: Utilidades de espaciado limpio en maquetación.

---

## ⚡ Guía de Instalación y Ejecución

### Prerrequisitos
- **Flutter SDK**: `>= 3.0.0`
- **Dart SDK**: `>= 3.0.0`
- **Navegador Web** (Chrome / Edge / Firefox) o **Android Studio** para emuladores.

### 1. Clonar el repositorio
```bash
git clone https://github.com/kyr3-fxp/horizon-academy-flutter.git
cd horizon-academy-flutter
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Ejecutar en modo desarrollo
Para ejecutar en **Web (Chrome)**:
```bash
flutter run -d chrome
```

Para ejecutar en **Móvil / Escritorio**:
```bash
flutter run
```

### 4. Compilar para Producción
Para generar el bundle web optimizado:
```bash
flutter build web --release
```

---

## 📄 Licencia

Este proyecto se distribuye bajo la licencia MIT. Consulta el archivo `LICENSE` para obtener más información.
