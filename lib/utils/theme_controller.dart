import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> _saveThemeToPrefs(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _saveThemeToPrefs(isDarkMode.value);
  }
}