import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('pl')
  ];

  /// No description provided for @mixSounds.
  ///
  /// In pl, this message translates to:
  /// **'Miksuj Dźwięki'**
  String get mixSounds;

  /// No description provided for @activeSoundsRatio.
  ///
  /// In pl, this message translates to:
  /// **'Aktywne: {count} / {max}'**
  String activeSoundsRatio(int count, int max);

  /// No description provided for @timer.
  ///
  /// In pl, this message translates to:
  /// **'Timer'**
  String get timer;

  /// No description provided for @activeSoundsCount.
  ///
  /// In pl, this message translates to:
  /// **'Aktywne ({count})'**
  String activeSoundsCount(String count);

  /// No description provided for @aiAssistant.
  ///
  /// In pl, this message translates to:
  /// **'Kompozytor AI'**
  String get aiAssistant;

  /// No description provided for @settings.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settings;

  /// No description provided for @nature.
  ///
  /// In pl, this message translates to:
  /// **'NATURA'**
  String get nature;

  /// No description provided for @water.
  ///
  /// In pl, this message translates to:
  /// **'WODA'**
  String get water;

  /// No description provided for @music.
  ///
  /// In pl, this message translates to:
  /// **'MUZYKA'**
  String get music;

  /// No description provided for @mechanical.
  ///
  /// In pl, this message translates to:
  /// **'MECHANICZNE'**
  String get mechanical;

  /// No description provided for @exitConfirmTitle.
  ///
  /// In pl, this message translates to:
  /// **'Czy jesteś pewien?'**
  String get exitConfirmTitle;

  /// No description provided for @exitConfirmContent.
  ///
  /// In pl, this message translates to:
  /// **'Czy chcesz wyjść z aplikacji?'**
  String get exitConfirmContent;

  /// No description provided for @yes.
  ///
  /// In pl, this message translates to:
  /// **'Tak'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In pl, this message translates to:
  /// **'Nie'**
  String get no;

  /// No description provided for @activeSoundsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Aktywne Dźwięki'**
  String get activeSoundsTitle;

  /// No description provided for @saveMixDialogTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz do ulubionych'**
  String get saveMixDialogTitle;

  /// No description provided for @noActiveSounds.
  ///
  /// In pl, this message translates to:
  /// **'Brak aktywnych dźwięków'**
  String get noActiveSounds;

  /// No description provided for @settingsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settingsTitle;

  /// No description provided for @privacyPolicy.
  ///
  /// In pl, this message translates to:
  /// **'Polityka prywatności'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicySub.
  ///
  /// In pl, this message translates to:
  /// **'Przeczytaj nasze zasady ochrony prywatności'**
  String get privacyPolicySub;

  /// No description provided for @acknowledgments.
  ///
  /// In pl, this message translates to:
  /// **'Podziękowania'**
  String get acknowledgments;

  /// No description provided for @acknowledgmentsSub.
  ///
  /// In pl, this message translates to:
  /// **'Licencje i autorzy zewnętrznych zasobów'**
  String get acknowledgmentsSub;

  /// No description provided for @spaceModeTitle.
  ///
  /// In pl, this message translates to:
  /// **'Tryb Kosmiczny Aktywny'**
  String get spaceModeTitle;

  /// No description provided for @spaceModeDesc.
  ///
  /// In pl, this message translates to:
  /// **'Aplikacja została na stałe dostosowana do klimatycznego, ciemnego motywu nocnego w celu zapewnienia maksymalnego komfortu relaksacyjnego.'**
  String get spaceModeDesc;

  /// No description provided for @approve.
  ///
  /// In pl, this message translates to:
  /// **'Zatwierdź'**
  String get approve;

  /// No description provided for @changeLanguage.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz język'**
  String get changeLanguage;

  /// No description provided for @changeLanguageSub.
  ///
  /// In pl, this message translates to:
  /// **'Zmień język aplikacji (Polski / English / Hindi)'**
  String get changeLanguageSub;

  /// No description provided for @aiAssistantTitle.
  ///
  /// In pl, this message translates to:
  /// **'Kompozytor Snu AI'**
  String get aiAssistantTitle;

  /// No description provided for @aiAssistantSub.
  ///
  /// In pl, this message translates to:
  /// **'Generuj idealne tło do snu'**
  String get aiAssistantSub;

  /// No description provided for @chooseGoal.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz swój dzisiejszy cel:'**
  String get chooseGoal;

  /// No description provided for @aiAssistantIntro.
  ///
  /// In pl, this message translates to:
  /// **'Sztuczna inteligencja zaprojektuje dla Ciebie spersonalizowany, idealnie zbalansowany miks relaksacyjnych dźwięków.'**
  String get aiAssistantIntro;

  /// No description provided for @connectionFailed.
  ///
  /// In pl, this message translates to:
  /// **'Połączenie nieudane'**
  String get connectionFailed;

  /// No description provided for @tryAgain.
  ///
  /// In pl, this message translates to:
  /// **'Spróbuj ponownie'**
  String get tryAgain;

  /// No description provided for @backToGoals.
  ///
  /// In pl, this message translates to:
  /// **'Wróć do celów'**
  String get backToGoals;

  /// No description provided for @aiAdviceTitle.
  ///
  /// In pl, this message translates to:
  /// **'Porada Relaksacyjna AI'**
  String get aiAdviceTitle;

  /// No description provided for @aiMixTitle.
  ///
  /// In pl, this message translates to:
  /// **'Spersonalizowany Miks AI'**
  String get aiMixTitle;

  /// No description provided for @aiMixSub.
  ///
  /// In pl, this message translates to:
  /// **'Zaprojektowane proporcje głośności dla ułatwienia relaksu:'**
  String get aiMixSub;

  /// No description provided for @playAiMix.
  ///
  /// In pl, this message translates to:
  /// **'Odtwórz Miks Ambient AI'**
  String get playAiMix;

  /// No description provided for @stopAiMix.
  ///
  /// In pl, this message translates to:
  /// **'Zatrzymaj Miks Ambient'**
  String get stopAiMix;

  /// No description provided for @noSoundMatch.
  ///
  /// In pl, this message translates to:
  /// **'Brak dostępnych dopasowań dźwiękowych w katalogu.'**
  String get noSoundMatch;

  /// No description provided for @loadingTitle.
  ///
  /// In pl, this message translates to:
  /// **'AI projektuje Twój profil wyciszenia...'**
  String get loadingTitle;

  /// No description provided for @loadingDesc.
  ///
  /// In pl, this message translates to:
  /// **'Dobieramy idealne proporcje głośności i układamy spersonalizowane ćwiczenia oddechowe, by pomóc Ci się odprężyć.'**
  String get loadingDesc;

  /// No description provided for @categoryStress.
  ///
  /// In pl, this message translates to:
  /// **'🧘 Wyciszenie i Stres'**
  String get categoryStress;

  /// No description provided for @categorySleep.
  ///
  /// In pl, this message translates to:
  /// **'😴 Problem ze Snem'**
  String get categorySleep;

  /// No description provided for @categoryNature.
  ///
  /// In pl, this message translates to:
  /// **'🌌 Medytacja i Natura'**
  String get categoryNature;

  /// No description provided for @categoryKids.
  ///
  /// In pl, this message translates to:
  /// **'👶 Dla Najmłodszych'**
  String get categoryKids;

  /// No description provided for @itemStressDay.
  ///
  /// In pl, this message translates to:
  /// **'Stresujący dzień w pracy'**
  String get itemStressDay;

  /// No description provided for @itemRacingThoughts.
  ///
  /// In pl, this message translates to:
  /// **'Gonitwa myśli przed senem'**
  String get itemRacingThoughts;

  /// No description provided for @itemAnxiety.
  ///
  /// In pl, this message translates to:
  /// **'Niepokój i napięcie'**
  String get itemAnxiety;

  /// No description provided for @itemTroubleSleeping.
  ///
  /// In pl, this message translates to:
  /// **'Trudności z zaśnięciem'**
  String get itemTroubleSleeping;

  /// No description provided for @itemNightAwakening.
  ///
  /// In pl, this message translates to:
  /// **'Nagłe przebudzenie w nocy'**
  String get itemNightAwakening;

  /// No description provided for @itemPowerNap.
  ///
  /// In pl, this message translates to:
  /// **'Potrzeba krótkiej drzemki'**
  String get itemPowerNap;

  /// No description provided for @itemDeepMeditation.
  ///
  /// In pl, this message translates to:
  /// **'Głęboka medytacja'**
  String get itemDeepMeditation;

  /// No description provided for @itemFocusCalm.
  ///
  /// In pl, this message translates to:
  /// **'Skupienie i wyciszenie'**
  String get itemFocusCalm;

  /// No description provided for @itemQuietForest.
  ///
  /// In pl, this message translates to:
  /// **'Spacer po cichym lesie'**
  String get itemQuietForest;

  /// No description provided for @itemBabySleep.
  ///
  /// In pl, this message translates to:
  /// **'Usypianie niemowlaka (szumy)'**
  String get itemBabySleep;

  /// No description provided for @itemCalmKids.
  ///
  /// In pl, this message translates to:
  /// **'Wyciszenie dziecka po zabawie'**
  String get itemCalmKids;

  /// No description provided for @customDurationTitle.
  ///
  /// In pl, this message translates to:
  /// **'Własny czas trwania'**
  String get customDurationTitle;

  /// No description provided for @cancel.
  ///
  /// In pl, this message translates to:
  /// **'Anuluj'**
  String get cancel;

  /// No description provided for @apply.
  ///
  /// In pl, this message translates to:
  /// **'Zastosuj'**
  String get apply;

  /// No description provided for @setDuration.
  ///
  /// In pl, this message translates to:
  /// **'Ustaw czas'**
  String get setDuration;

  /// No description provided for @maxSoundsReached.
  ///
  /// In pl, this message translates to:
  /// **'Możesz odtwarzać maksymalnie 6 dźwięków jednocześnie.'**
  String get maxSoundsReached;

  /// No description provided for @timeStarted.
  ///
  /// In pl, this message translates to:
  /// **'Czas został uruchomiony'**
  String get timeStarted;

  /// No description provided for @start.
  ///
  /// In pl, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In pl, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @sound_woodpecker.
  ///
  /// In pl, this message translates to:
  /// **'Dzięcioł'**
  String get sound_woodpecker;

  /// No description provided for @sound_frog.
  ///
  /// In pl, this message translates to:
  /// **'Żaby'**
  String get sound_frog;

  /// No description provided for @sound_strok.
  ///
  /// In pl, this message translates to:
  /// **'Bocian'**
  String get sound_strok;

  /// No description provided for @sound_city_park.
  ///
  /// In pl, this message translates to:
  /// **'Park miejski'**
  String get sound_city_park;

  /// No description provided for @sound_fireplace.
  ///
  /// In pl, this message translates to:
  /// **'Kominek'**
  String get sound_fireplace;

  /// No description provided for @sound_bonfire.
  ///
  /// In pl, this message translates to:
  /// **'Ognisko'**
  String get sound_bonfire;

  /// No description provided for @sound_bird.
  ///
  /// In pl, this message translates to:
  /// **'Ptaki'**
  String get sound_bird;

  /// No description provided for @sound_thunder.
  ///
  /// In pl, this message translates to:
  /// **'Burza'**
  String get sound_thunder;

  /// No description provided for @sound_cricket.
  ///
  /// In pl, this message translates to:
  /// **'Świerszcze'**
  String get sound_cricket;

  /// No description provided for @sound_forest.
  ///
  /// In pl, this message translates to:
  /// **'Las'**
  String get sound_forest;

  /// No description provided for @sound_wind.
  ///
  /// In pl, this message translates to:
  /// **'Wiatr'**
  String get sound_wind;

  /// No description provided for @sound_jungle.
  ///
  /// In pl, this message translates to:
  /// **'Tropiki'**
  String get sound_jungle;

  /// No description provided for @sound_river.
  ///
  /// In pl, this message translates to:
  /// **'Rzeka'**
  String get sound_river;

  /// No description provided for @sound_small_creek.
  ///
  /// In pl, this message translates to:
  /// **'Strumyk'**
  String get sound_small_creek;

  /// No description provided for @sound_rain.
  ///
  /// In pl, this message translates to:
  /// **'Deszcz'**
  String get sound_rain;

  /// No description provided for @sound_rain_on_car_roof.
  ///
  /// In pl, this message translates to:
  /// **'Deszcz na dachu auta'**
  String get sound_rain_on_car_roof;

  /// No description provided for @sound_rain_on_car_windows.
  ///
  /// In pl, this message translates to:
  /// **'Wycieraczki w deszczu'**
  String get sound_rain_on_car_windows;

  /// No description provided for @sound_fountain_in_park.
  ///
  /// In pl, this message translates to:
  /// **'Fontanna w parku'**
  String get sound_fountain_in_park;

  /// No description provided for @sound_rain_under_raincoat.
  ///
  /// In pl, this message translates to:
  /// **'Deszcz pod płaszczem'**
  String get sound_rain_under_raincoat;

  /// No description provided for @sound_rain_on_windows.
  ///
  /// In pl, this message translates to:
  /// **'Deszcz o szyby'**
  String get sound_rain_on_windows;

  /// No description provided for @sound_sea.
  ///
  /// In pl, this message translates to:
  /// **'Morze'**
  String get sound_sea;

  /// No description provided for @sound_cave.
  ///
  /// In pl, this message translates to:
  /// **'Jaskinia'**
  String get sound_cave;

  /// No description provided for @sound_waterfall.
  ///
  /// In pl, this message translates to:
  /// **'Wodospad'**
  String get sound_waterfall;

  /// No description provided for @sound_jacuzzi.
  ///
  /// In pl, this message translates to:
  /// **'Dżakuzi'**
  String get sound_jacuzzi;

  /// No description provided for @sound_meditation.
  ///
  /// In pl, this message translates to:
  /// **'Medytacja'**
  String get sound_meditation;

  /// No description provided for @sound_healing_meditation.
  ///
  /// In pl, this message translates to:
  /// **'Uzdrawiająca medytacja'**
  String get sound_healing_meditation;

  /// No description provided for @sound_yoga.
  ///
  /// In pl, this message translates to:
  /// **'Joga'**
  String get sound_yoga;

  /// No description provided for @sound_asian_piano.
  ///
  /// In pl, this message translates to:
  /// **'Azjatyckie pianino'**
  String get sound_asian_piano;

  /// No description provided for @sound_piano.
  ///
  /// In pl, this message translates to:
  /// **'Pianino'**
  String get sound_piano;

  /// No description provided for @sound_background_piano.
  ///
  /// In pl, this message translates to:
  /// **'Pianino w tle'**
  String get sound_background_piano;

  /// No description provided for @sound_binaural.
  ///
  /// In pl, this message translates to:
  /// **'Binauralne'**
  String get sound_binaural;

  /// No description provided for @sound_guitar_song.
  ///
  /// In pl, this message translates to:
  /// **'Utwór gitarowy'**
  String get sound_guitar_song;

  /// No description provided for @sound_background_guitar.
  ///
  /// In pl, this message translates to:
  /// **'Gitara w tle'**
  String get sound_background_guitar;

  /// No description provided for @sound_om_surrounding.
  ///
  /// In pl, this message translates to:
  /// **'Dźwięk Om'**
  String get sound_om_surrounding;

  /// No description provided for @sound_zen.
  ///
  /// In pl, this message translates to:
  /// **'Zen'**
  String get sound_zen;

  /// No description provided for @sound_flute.
  ///
  /// In pl, this message translates to:
  /// **'Flet'**
  String get sound_flute;

  /// No description provided for @sound_plane.
  ///
  /// In pl, this message translates to:
  /// **'Samolot'**
  String get sound_plane;

  /// No description provided for @sound_train.
  ///
  /// In pl, this message translates to:
  /// **'Pociąg'**
  String get sound_train;

  /// No description provided for @sound_car_driving.
  ///
  /// In pl, this message translates to:
  /// **'Jazda autem'**
  String get sound_car_driving;

  /// No description provided for @sound_bus.
  ///
  /// In pl, this message translates to:
  /// **'Autobus'**
  String get sound_bus;

  /// No description provided for @sound_washing_machine.
  ///
  /// In pl, this message translates to:
  /// **'Pralka'**
  String get sound_washing_machine;

  /// No description provided for @sound_air_conditioner.
  ///
  /// In pl, this message translates to:
  /// **'Klimatyzator'**
  String get sound_air_conditioner;

  /// No description provided for @sound_vacuum_cleaner.
  ///
  /// In pl, this message translates to:
  /// **'Odkurzacz'**
  String get sound_vacuum_cleaner;

  /// No description provided for @sound_hair_dryer.
  ///
  /// In pl, this message translates to:
  /// **'Suszarka do włosów'**
  String get sound_hair_dryer;

  /// No description provided for @sound_keyboard.
  ///
  /// In pl, this message translates to:
  /// **'Klawiatura'**
  String get sound_keyboard;

  /// No description provided for @soundsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Dźwięki'**
  String get soundsTitle;

  /// No description provided for @favoriteMixes.
  ///
  /// In pl, this message translates to:
  /// **'Ulubione utwory'**
  String get favoriteMixes;

  /// No description provided for @readyMixes.
  ///
  /// In pl, this message translates to:
  /// **'Gotowe mixy'**
  String get readyMixes;

  /// No description provided for @noFavoriteMixes.
  ///
  /// In pl, this message translates to:
  /// **'Brak ulubionych miksów'**
  String get noFavoriteMixes;

  /// No description provided for @useAiToCreateMix.
  ///
  /// In pl, this message translates to:
  /// **'Użyj Asystenta AI, aby stworzyć i zapisać idealny miks.'**
  String get useAiToCreateMix;

  /// No description provided for @mix_deep_sleep.
  ///
  /// In pl, this message translates to:
  /// **'Głęboki Sen'**
  String get mix_deep_sleep;

  /// No description provided for @mix_forest_silence.
  ///
  /// In pl, this message translates to:
  /// **'Leśna Cisza'**
  String get mix_forest_silence;

  /// No description provided for @mix_evening_bonfire.
  ///
  /// In pl, this message translates to:
  /// **'Wieczorne Ognisko'**
  String get mix_evening_bonfire;

  /// No description provided for @mix_deep_meditation.
  ///
  /// In pl, this message translates to:
  /// **'Głęboka Medytacja'**
  String get mix_deep_meditation;

  /// No description provided for @mix_calm_piano.
  ///
  /// In pl, this message translates to:
  /// **'Spokojne Piano'**
  String get mix_calm_piano;

  /// No description provided for @mix_white_rain_noise.
  ///
  /// In pl, this message translates to:
  /// **'Biały Szum Deszczu'**
  String get mix_white_rain_noise;

  /// No description provided for @mix_heavenly_zen.
  ///
  /// In pl, this message translates to:
  /// **'Niebiański Zen'**
  String get mix_heavenly_zen;

  /// No description provided for @mix_train_journey.
  ///
  /// In pl, this message translates to:
  /// **'Podróż Pociągiem'**
  String get mix_train_journey;

  /// No description provided for @createWithAi.
  ///
  /// In pl, this message translates to:
  /// **'Stwórz z AI'**
  String get createWithAi;

  /// No description provided for @inhale.
  ///
  /// In pl, this message translates to:
  /// **'Wdech'**
  String get inhale;

  /// No description provided for @exhale.
  ///
  /// In pl, this message translates to:
  /// **'Wydech'**
  String get exhale;

  /// No description provided for @aiMixFeedbackQuestion.
  ///
  /// In pl, this message translates to:
  /// **'Czy pasuje Ci ten dźwięk?'**
  String get aiMixFeedbackQuestion;

  /// No description provided for @aiMixFeedbackNo.
  ///
  /// In pl, this message translates to:
  /// **'Nie, zmień'**
  String get aiMixFeedbackNo;

  /// No description provided for @aiMixFeedbackYes.
  ///
  /// In pl, this message translates to:
  /// **'Tak, idealnie'**
  String get aiMixFeedbackYes;

  /// No description provided for @aiMixSaveQuestion.
  ///
  /// In pl, this message translates to:
  /// **'Czy chcesz dodać ten dźwięk do ulubionych?'**
  String get aiMixSaveQuestion;

  /// No description provided for @aiMixSaveYes.
  ///
  /// In pl, this message translates to:
  /// **'Tak, zapisz'**
  String get aiMixSaveYes;

  /// No description provided for @aiMixSaveNo.
  ///
  /// In pl, this message translates to:
  /// **'Nie'**
  String get aiMixSaveNo;

  /// No description provided for @aiMixNameChoice.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz nazwę dla tego miksu:'**
  String get aiMixNameChoice;

  /// No description provided for @aiNameSuggestions.
  ///
  /// In pl, this message translates to:
  /// **'Propozycje nazw od AI:'**
  String get aiNameSuggestions;

  /// No description provided for @aiMixCoverChoice.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz okładkę dla swojego miksu:'**
  String get aiMixCoverChoice;

  /// No description provided for @aiMixSaveLimit.
  ///
  /// In pl, this message translates to:
  /// **'Osiągnięto limit 6 ulubionych. Usuń coś najpierw.'**
  String get aiMixSaveLimit;

  /// No description provided for @aiMixSavedSuccess.
  ///
  /// In pl, this message translates to:
  /// **'Zapisano \"{name}\" do ulubionych!'**
  String aiMixSavedSuccess(String name);

  /// No description provided for @settingsTutorialTitle.
  ///
  /// In pl, this message translates to:
  /// **'Interaktywny samouczek'**
  String get settingsTutorialTitle;

  /// No description provided for @settingsTutorialSub.
  ///
  /// In pl, this message translates to:
  /// **'Uruchom ponownie przewodnik po funkcjach aplikacji'**
  String get settingsTutorialSub;

  /// No description provided for @tutorialSkip.
  ///
  /// In pl, this message translates to:
  /// **'Pomiń'**
  String get tutorialSkip;

  /// No description provided for @tutorialNext.
  ///
  /// In pl, this message translates to:
  /// **'Dalej'**
  String get tutorialNext;

  /// No description provided for @tutorialFinish.
  ///
  /// In pl, this message translates to:
  /// **'Zakończ'**
  String get tutorialFinish;

  /// No description provided for @tutorialStep1Title.
  ///
  /// In pl, this message translates to:
  /// **'Witaj w Good Dream!'**
  String get tutorialStep1Title;

  /// No description provided for @tutorialStep1Desc.
  ///
  /// In pl, this message translates to:
  /// **'Zacznijmy od miksowania dźwięków. Kliknij tę ikonę suwaków, aby otworzyć mikser i włączyć swoje pierwsze kojące brzmienia.'**
  String get tutorialStep1Desc;

  /// No description provided for @tutorialStep2Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 2: Włącz dźwięk'**
  String get tutorialStep2Title;

  /// No description provided for @tutorialStep2Desc.
  ///
  /// In pl, this message translates to:
  /// **'Kliknij w ten kafelek (np. Żaby lub Dzięcioł), aby go aktywować i usłyszeć naturalne brzmienie w czasie rzeczywistym.'**
  String get tutorialStep2Desc;

  /// No description provided for @tutorialStep3Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 3: Zarządzaj kompozycją'**
  String get tutorialStep3Title;

  /// No description provided for @tutorialStep3Desc.
  ///
  /// In pl, this message translates to:
  /// **'Wspaniale! Pojawił się dolny pasek odtwarzacza. Kliknij w przycisk \'Aktywne: X / 6\', aby zobaczyć pełną listę aktywnych dźwięków.'**
  String get tutorialStep3Desc;

  /// No description provided for @tutorialStep4Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 4: Dopasuj głośność'**
  String get tutorialStep4Title;

  /// No description provided for @tutorialStep4Desc.
  ///
  /// In pl, this message translates to:
  /// **'Super! Tutaj widnieje lista Twoich aktywnych dźwięków. Teraz przesuń suwak głośności w lewo lub w prawo, aby dostosować poziom wybranego dźwięku.'**
  String get tutorialStep4Desc;

  /// No description provided for @tutorialStep5Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 5: Zapisz swój własny miks!'**
  String get tutorialStep5Title;

  /// No description provided for @tutorialStep5Desc.
  ///
  /// In pl, this message translates to:
  /// **'Znalazłeś idealne brzmienie? Kliknij to złote serduszko, aby zapisać swoją unikalną kompozycję na stałe w zakładce Ulubione!'**
  String get tutorialStep5Desc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
