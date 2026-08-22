import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {
  static const String _chavePinAdmin = 'pin_admin';
  static const String _pinPadrao = '1234';

  PreferenciasService._();

  static final PreferenciasService _instancia = PreferenciasService._();

  static PreferenciasService get instancia => _instancia;

  Future<String> obterPinAdministrativo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chavePinAdmin) ?? _pinPadrao;
  }

  Future<void> definirPinAdministrativo(String novoPin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chavePinAdmin, novoPin);
  }

  Future<bool> validarPinAdministrativo(String pinDigitado) async {
    final pinArmazenado = await obterPinAdministrativo();
    return pinDigitado.trim() == pinArmazenado.trim();
  }
}
