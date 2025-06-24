abstract class LanguageState {
  final String languageCode;

  const LanguageState(this.languageCode);
}

class LanguageInitial extends LanguageState {
  LanguageInitial() : super('en'); 
}

class LanguageChanged extends LanguageState {
  const LanguageChanged({required String languageCode}) : super(languageCode);
}