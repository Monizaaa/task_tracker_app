import 'package:get/get.dart';
import 'package:task_tracker_app/core/i18n/en.dart';
import 'package:task_tracker_app/core/i18n/th.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'th_TH': th};
}
