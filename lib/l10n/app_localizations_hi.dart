// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get mixSounds => 'ध्वनियां मिलाएं';

  @override
  String activeSoundsRatio(int count, int max) {
    return 'सक्रिय: $count / $max';
  }

  @override
  String get timer => 'टाइमर';

  @override
  String activeSoundsCount(String count) {
    return 'सक्रिय ($count)';
  }

  @override
  String get aiAssistant => 'एआई कंपोजर';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get nature => 'प्रकृति';

  @override
  String get water => 'पानी';

  @override
  String get music => 'संगीत';

  @override
  String get mechanical => 'मैकेनिकल';

  @override
  String get exitConfirmTitle => 'क्या आप सुनिश्चित हैं?';

  @override
  String get exitConfirmContent => 'क्या आप ऐप बंद करना चाहते हैं?';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get activeSoundsTitle => 'सक्रिय ध्वनियां';

  @override
  String get saveMixDialogTitle => 'पसंदीदा में सहेजें';

  @override
  String get noActiveSounds => 'कोई सक्रिय ध्वनि नहीं';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get privacyPolicySub => 'हमारी गोपनीयता सुरक्षा नियमों को पढ़ें';

  @override
  String get acknowledgments => 'आभार';

  @override
  String get acknowledgmentsSub => 'लाइसेंस और तीसरे पक्ष के संसाधनों के लेखक';

  @override
  String get spaceModeTitle => 'स्पेस मोड सक्रिय';

  @override
  String get spaceModeDesc =>
      'अधिकतम विश्राम आराम सुनिश्चित करने के लिए एप्लिकेशन को स्थायी रूप से एक आरामदायक, अंधेरे रात के थीम के अनुकूल बनाया गया है।';

  @override
  String get approve => 'स्वीकार करें';

  @override
  String get changeLanguage => 'भाषा चुनें';

  @override
  String get changeLanguageSub => 'ऐप की भाषा बदलें (Polski / English / Hindi)';

  @override
  String get aiAssistantTitle => 'एआई स्लीप कंपोजर';

  @override
  String get aiAssistantSub => 'नींद के लिए सही पृष्ठभूमि उत्पन्न करें';

  @override
  String get chooseGoal => 'आज के लिए अपना लक्ष्य चुनें:';

  @override
  String get aiAssistantIntro =>
      'आर्टिफिशियल इंटेलिजेंस आपके लिए एक व्यक्तिगत, पूरी तरह से संतुलित परिवेशी ध्वनि परिदृश्य तैयार करेगा।';

  @override
  String get connectionFailed => 'कनेक्शन विफल रहा';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get backToGoals => 'लक्ष्यों पर वापस जाएं';

  @override
  String get aiAdviceTitle => 'एआई विश्राम सलाह';

  @override
  String get aiMixTitle => 'एआई व्यक्तिगत मिक्स';

  @override
  String get aiMixSub =>
      'विश्राम को आसान बनाने के लिए डिज़ाइन किए गए वॉल्यूम स्तर:';

  @override
  String get playAiMix => 'एआई परिवेश मिक्स चलाएं';

  @override
  String get stopAiMix => 'परिवेश मिक्स बंद करें';

  @override
  String get noSoundMatch =>
      'कैटलॉग में कोई मिलान परिवेश ध्वनि उपलब्ध नहीं है।';

  @override
  String get loadingTitle => 'एआई आपकी शांत प्रोफ़ाइल डिज़ाइन कर रहा है...';

  @override
  String get loadingDesc =>
      'हम आपको आराम करने में मदद करने के लिए सही वॉल्यूम स्तर चुनते हैं और व्यक्तिगत श्वास अभ्यास व्यवस्थित करते हैं।';

  @override
  String get categoryStress => '🧘 शांति और तनाव';

  @override
  String get categorySleep => '😴 नींद की समस्याएं';

  @override
  String get categoryNature => '🌌 ध्यान और प्रकृति';

  @override
  String get categoryKids => '👶 बच्चों के लिए';

  @override
  String get itemStressDay => 'काम पर तनावपूर्ण दिन';

  @override
  String get itemRacingThoughts => 'सोने से पहले विचारों की दौड़';

  @override
  String get itemAnxiety => 'चिंता और तनाव';

  @override
  String get itemTroubleSleeping => 'सोने में परेशानी';

  @override
  String get itemNightAwakening => 'रात में अचानक जागना';

  @override
  String get itemPowerNap => 'छोटी झपकी की आवश्यकता';

  @override
  String get itemDeepMeditation => 'गहरा ध्यान';

  @override
  String get itemFocusCalm => 'फोकस और शांति';

  @override
  String get itemQuietForest => 'शांत जंगल में सैर';

  @override
  String get itemBabySleep => 'बच्चे को सुलाना (सफेद शोर)';

  @override
  String get itemCalmKids => 'खेलने के बाद बच्चे को शांत करना';

  @override
  String get customDurationTitle => 'कस्टम अवधि';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get apply => 'लागू करें';

  @override
  String get setDuration => 'समय सेट करें';

  @override
  String get maxSoundsReached =>
      'एक ही समय में अधिकतम 6 ध्वनियां चलाई जा सकती हैं।';

  @override
  String get timeStarted => 'टाइमर शुरू हो गया है';

  @override
  String get start => 'शुरू करें';

  @override
  String get stop => 'बंद करें';

  @override
  String get sound_woodpecker => 'कटफोड़वा';

  @override
  String get sound_frog => 'मेंढक परिवेश';

  @override
  String get sound_strok => 'सारस';

  @override
  String get sound_city_park => 'सिटी पार्क';

  @override
  String get sound_fireplace => 'चूल्हा';

  @override
  String get sound_bonfire => 'अलाव';

  @override
  String get sound_bird => 'पक्षी';

  @override
  String get sound_thunder => 'गड़गड़ाहट';

  @override
  String get sound_cricket => 'झिंगुर';

  @override
  String get sound_forest => 'जंगल';

  @override
  String get sound_wind => 'हवा';

  @override
  String get sound_jungle => 'उष्णकटिबंधीय';

  @override
  String get sound_river => 'नदी';

  @override
  String get sound_small_creek => 'छोटी खाड़ी';

  @override
  String get sound_rain => 'बारिश';

  @override
  String get sound_rain_on_car_roof => 'कार की छत पर बारिश';

  @override
  String get sound_rain_on_car_windows => 'कार की खिड़कियों पर बारिश';

  @override
  String get sound_fountain_in_park => 'पार्क में फव्वारा';

  @override
  String get sound_rain_under_raincoat => 'रेनकोट के नीचे बारिश';

  @override
  String get sound_rain_on_windows => 'खिड़कियों पर बारिश';

  @override
  String get sound_sea => 'समुद्र';

  @override
  String get sound_cave => 'गुफा';

  @override
  String get sound_waterfall => 'झरना';

  @override
  String get sound_jacuzzi => 'जकूज़ी';

  @override
  String get sound_meditation => 'ध्यान';

  @override
  String get sound_healing_meditation => 'उपचार ध्यान';

  @override
  String get sound_yoga => 'योग';

  @override
  String get sound_asian_piano => 'एशियाई पियानो';

  @override
  String get sound_piano => 'पियानो';

  @override
  String get sound_background_piano => 'पृष्ठभूमि पियानो';

  @override
  String get sound_binaural => 'बाइनॉरल';

  @override
  String get sound_guitar_song => 'गिटार गीत';

  @override
  String get sound_background_guitar => 'पृष्ठभूमि गिटार';

  @override
  String get sound_om_surrounding => 'ओम परिवेश';

  @override
  String get sound_zen => 'ज़ेन';

  @override
  String get sound_flute => 'बांसुरी';

  @override
  String get sound_plane => 'विमान';

  @override
  String get sound_train => 'ट्रेन';

  @override
  String get sound_car_driving => 'कार ड्राइविंग';

  @override
  String get sound_bus => 'बस';

  @override
  String get sound_washing_machine => 'वाशिंग मशीन';

  @override
  String get sound_air_conditioner => 'एयर कंडीशनर';

  @override
  String get sound_vacuum_cleaner => 'वैक्यूम क्लीनर';

  @override
  String get sound_hair_dryer => 'हेयर ड्रायर';

  @override
  String get sound_keyboard => 'कीबोर्ड';

  @override
  String get soundsTitle => 'ध्वनि';

  @override
  String get favoriteMixes => 'पसंदीदा मिक्स';

  @override
  String get readyMixes => 'तैयार मिक्स';

  @override
  String get noFavoriteMixes => 'कोई पसंदीदा मिक्स नहीं';

  @override
  String get useAiToCreateMix =>
      'सही मिक्स बनाने और सहेजने के लिए AI सहायक का उपयोग करें।';

  @override
  String get mix_deep_sleep => 'गहरी नींद';

  @override
  String get mix_forest_silence => 'जंगल की शांति';

  @override
  String get mix_evening_bonfire => 'शाम का अलाव';

  @override
  String get mix_deep_meditation => 'गहन ध्यान';

  @override
  String get mix_calm_piano => 'शांत पियानो';

  @override
  String get mix_white_rain_noise => 'सफेद बारिश का शोर';

  @override
  String get mix_heavenly_zen => 'दिव्य ज़ेन';

  @override
  String get mix_train_journey => 'ट्रेन यात्रा';

  @override
  String get createWithAi => 'एआई के साथ बनाएं';

  @override
  String get inhale => 'सांस अंदर';

  @override
  String get exhale => 'सांस बाहर';

  @override
  String get aiMixFeedbackQuestion => 'क्या यह ध्वनि आपको पसंद आई?';

  @override
  String get aiMixFeedbackNo => 'नहीं, बदलें';

  @override
  String get aiMixFeedbackYes => 'हाँ, बिल्कुल सही';

  @override
  String get aiMixSaveQuestion =>
      'क्या आप इस ध्वनि को अपने पसंदीदा में जोड़ना चाहते हैं?';

  @override
  String get aiMixSaveYes => 'हाँ, सहेजें';

  @override
  String get aiMixSaveNo => 'नहीं';

  @override
  String get aiMixNameChoice => 'इस मिक्स के लिए एक नाम चुनें:';

  @override
  String get aiNameSuggestions => 'एआई नाम के सुझाव:';

  @override
  String get aiMixCoverChoice => 'अपने मिक्स के लिए एक कवर चुनें:';

  @override
  String get aiMixSaveLimit =>
      'पसंदीदा की अधिकतम सीमा 6 तक पहुँच गई है। पहले कुछ हटाएँ।';

  @override
  String aiMixSavedSuccess(String name) {
    return 'पसंदीदा में \"$name\" सहेजा गया!';
  }

  @override
  String get settingsTutorialTitle => 'इंटरैक्टिव ट्यूटोरियल';

  @override
  String get settingsTutorialSub =>
      'एप्लिकेशन सुविधाओं के लिए मार्गदर्शिका को पुनरारंभ करें';

  @override
  String get tutorialSkip => 'छोड़ें';

  @override
  String get tutorialNext => 'आगे';

  @override
  String get tutorialFinish => 'समाप्त';

  @override
  String get tutorialStep1Title => 'गुड ड्रीम में आपका स्वागत है!';

  @override
  String get tutorialStep1Desc =>
      'आइए ध्वनियों को मिलाने से शुरुआत करें। ऑडियो कंसोल खोलने और अपनी पहली सुखदायक आवाज़ों को चालू करने के लिए इस मिक्सर आइकन पर क्लिक करें।';

  @override
  String get tutorialStep2Title => 'चरण 2: ध्वनि चालू करें';

  @override
  String get tutorialStep2Desc =>
      'इसे सक्रिय करने और वास्तविक समय में प्राकृतिक परिवेश सुनने के लिए इस टाइल पर क्लिक करें (उदा. मेंढक या कटफोड़वा)।';

  @override
  String get tutorialStep3Title => 'चरण 3: रचना प्रबंधित करें';

  @override
  String get tutorialStep3Desc =>
      'अद्भुत! निचला प्लेइंग बार दिखाई दे गया है। सक्रिय ध्वनियों की पूरी सूची देखने के लिए \'सक्रिय: X / 6\' बटन पर क्लिक करें।';

  @override
  String get tutorialStep4Title => 'चरण 4: वॉल्यूम समायोजित करें';

  @override
  String get tutorialStep4Desc =>
      'बहुत बढ़िया! यहाँ आपकी सक्रिय ध्वनियों की सूची है। अब चयनित ध्वनि के स्तर को समायोजित करने के लिए वॉल्यूम स्लाइडर को बाएं या दाएं खींचें।';

  @override
  String get tutorialStep5Title => 'चरण 5: अपना कस्टम मिक्स सहेजें!';

  @override
  String get tutorialStep5Desc =>
      'क्या आपको बेहतरीन साउंडस्केप मिल गया? अपनी अनूठी रचना को स्थायी रूप से पसंदीदा में सहेजने के लिए इस सुनहरे दिल वाले आइकन पर क्लिक करें!';
}
