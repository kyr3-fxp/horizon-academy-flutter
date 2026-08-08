import 'package:flutter/material.dart';
import '../models/tuition_calculation.dart';
import '../models/event_model.dart';

class SchoolController extends ChangeNotifier {
  // Calculadora de Colegiaturas
  String _selectedLevel = 'primary';
  bool _includeTransport = true;
  bool _includeCafeteria = false;
  int _workshopCount = 1;

  final Map<String, Map<String, dynamic>> _levelPrices = {
    'preschool': {'name': 'Preschool & Early Learning', 'price': 7200.0},
    'primary': {'name': 'Elementary School (Primaria)', 'price': 9800.0},
    'secondary': {'name': 'Middle School (Secundaria)', 'price': 11500.0},
    'highschool': {'name': 'IB High School (Bachillerato)', 'price': 14200.0},
  };

  static const double transportCost = 1200.0;
  static const double cafeteriaCost = 1500.0;
  static const double workshopUnitPrice = 400.0;

  // Filtro de Eventos
  String _selectedEventCategory = 'Todos';

  // Formulario de Admisión
  bool _isSubmittingForm = false;
  bool _formSubmittedSuccessfully = false;

  // Getters para Calculadora
  String get selectedLevel => _selectedLevel;
  bool get includeTransport => _includeTransport;
  bool get includeCafeteria => _includeCafeteria;
  int get workshopCount => _workshopCount;

  TuitionCalculation get currentCalculation {
    final levelData = _levelPrices[_selectedLevel] ?? _levelPrices['primary']!;
    return TuitionCalculation(
      levelId: _selectedLevel,
      levelName: levelData['name'] as String,
      baseTuition: levelData['price'] as double,
      hasTransport: _includeTransport,
      transportCost: transportCost,
      hasCafeteria: _includeCafeteria,
      cafeteriaCost: cafeteriaCost,
      workshopCount: _workshopCount,
      workshopCostPerItem: workshopUnitPrice,
    );
  }

  // Setters Calculadora
  void setLevel(String levelId) {
    if (_levelPrices.containsKey(levelId)) {
      _selectedLevel = levelId;
      notifyListeners();
    }
  }

  void toggleTransport(bool? value) {
    _includeTransport = value ?? false;
    notifyListeners();
  }

  void toggleCafeteria(bool? value) {
    _includeCafeteria = value ?? false;
    notifyListeners();
  }

  void setWorkshopCount(int count) {
    _workshopCount = count.clamp(0, 4);
    notifyListeners();
  }

  // Getters & Setters Eventos
  String get selectedEventCategory => _selectedEventCategory;

  void setEventCategory(String category) {
    _selectedEventCategory = category;
    notifyListeners();
  }

  List<EventModel> get filteredEvents {
    if (_selectedEventCategory == 'Todos') {
      return EventModel.sampleEvents;
    }
    return EventModel.sampleEvents
        .where((e) => e.category.toLowerCase() == _selectedEventCategory.toLowerCase())
        .toList();
  }

  // Métodos Formulario
  bool get isSubmittingForm => _isSubmittingForm;
  bool get formSubmittedSuccessfully => _formSubmittedSuccessfully;

  Future<bool> submitAdmissionForm({
    required String fullName,
    required String email,
    required String phone,
    required String level,
    required String message,
  }) async {
    _isSubmittingForm = true;
    notifyListeners();

    // Simulación de envío a API REST
    await Future.delayed(const Duration(milliseconds: 1200));

    _isSubmittingForm = false;
    _formSubmittedSuccessfully = true;
    notifyListeners();
    return true;
  }

  void resetFormState() {
    _formSubmittedSuccessfully = false;
    notifyListeners();
  }
}
