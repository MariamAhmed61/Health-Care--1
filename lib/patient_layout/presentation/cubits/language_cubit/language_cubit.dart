import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/language_cubit/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  void changeLanguage(String languageCode) {
    emit(LanguageChanged(languageCode: languageCode));
  }
}
