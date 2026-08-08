import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../controllers/school_controller.dart';

class AdmissionsSection extends StatefulWidget {
  const AdmissionsSection({super.key});

  @override
  State<AdmissionsSection> createState() => _AdmissionsSectionState();
}

class _AdmissionsSectionState extends State<AdmissionsSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedLevel = 'Preschool (2-5 años)';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<SchoolController>();
      final success = await controller.submitAdmissionForm(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        level: _selectedLevel,
        message: _messageController.text,
      );

      if (success && mounted) {
        // Limpiar campos
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();

        // Mostrar Diálogo de Éxito
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.bgSurfaceElevated,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            contentPadding: const EdgeInsets.all(28),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreenSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 56),
                ),
                const SizedBox(height: 20),
                Text(
                  '¡Solicitud Recibida!',
                  style: AppTextStyle.heading(fontSize: 22, color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Gracias por tu interés en Horizon International Academy. Nuestro equipo de admisiones se comunicará contigo en menos de 24 horas hábiles.',
                  style: AppTextStyle.body(fontSize: 14, color: AppColors.textMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Aceptar'),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final controller = context.watch<SchoolController>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'Proceso de Admisiones',
            style: AppTextStyle.heading(
              fontSize: isDesktop ? 36 : 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Inicia hoy la trayectoria académica internacional de tu hijo. Completa el formulario y agenda tu visita.',
            style: AppTextStyle.body(fontSize: 16, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          Container(
            padding: EdgeInsets.all(isDesktop ? 36 : 20),
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderPaper, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isRow = constraints.maxWidth > 650;
                      return Flex(
                        direction: isRow ? Axis.horizontal : Axis.vertical,
                        children: [
                          Expanded(
                            flex: isRow ? 1 : 0,
                            child: TextFormField(
                              controller: _nameController,
                              decoration: _inputDecoration('Nombre Completo del Padre o Tutor', Icons.person_outline),
                              validator: (val) => (val == null || val.trim().isEmpty) ? 'Ingresa tu nombre' : null,
                            ),
                          ),
                          if (isRow) const SizedBox(width: 16) else const SizedBox(height: 16),
                          Expanded(
                            flex: isRow ? 1 : 0,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration('Correo Electrónico', Icons.email_outlined),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) return 'Ingresa tu correo';
                                if (!val.contains('@')) return 'Correo no válido';
                                return null;
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isRow = constraints.maxWidth > 650;
                      return Flex(
                        direction: isRow ? Axis.horizontal : Axis.vertical,
                        children: [
                          Expanded(
                            flex: isRow ? 1 : 0,
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: _inputDecoration('Teléfono de Contacto / WhatsApp', Icons.phone_outlined),
                              validator: (val) => (val == null || val.trim().isEmpty) ? 'Ingresa un teléfono' : null,
                            ),
                          ),
                          if (isRow) const SizedBox(width: 16) else const SizedBox(height: 16),
                          Expanded(
                            flex: isRow ? 1 : 0,
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedLevel,
                              decoration: _inputDecoration('Nivel de Interés', Icons.school_outlined),
                              items: const [
                                DropdownMenuItem(value: 'Preschool (2-5 años)', child: Text('Preschool (2-5 años)')),
                                DropdownMenuItem(value: 'Primaria (6-11 años)', child: Text('Primaria (6-11 años)')),
                                DropdownMenuItem(value: 'Secundaria (12-14 años)', child: Text('Secundaria (12-14 años)')),
                                DropdownMenuItem(value: 'Bachillerato IB (15-18 años)', child: Text('Bachillerato IB (15-18 años)')),
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedLevel = val);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: _inputDecoration('Mensaje o Dudas Específicas', Icons.chat_bubble_outline),
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isSubmittingForm ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 3,
                      ),
                      child: controller.isSubmittingForm
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text('Enviar Solicitud de Admisión', style: AppTextStyle.button(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primaryLight, size: 20),
      filled: true,
      fillColor: AppColors.bgMain,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.borderPaper),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
