import '../../models/vocabulary_model.dart';

class VocabularyCatalog {
  VocabularyCatalog._();

  static const _entries = '''
Greetings|Goodbye|Adiós|Au revoir|Auf Wiedersehen|さようなら|sayōnara|إلى اللقاء|ilā al-liqā'|الوداع|phrase
Greetings|Sorry|Lo siento|Je suis désolé|Es tut mir leid|ごめんなさい|gomen nasai|آسف|āsif|مجھے افسوس ہے|phrase
Greetings|Excuse me|Disculpe|Excusez-moi|Entschuldigung|すみません|sumimasen|عذرًا|ʿudhran|معاف کیجیے|phrase
Greetings|Welcome|Bienvenido|Bienvenue|Willkommen|ようこそ|yōkoso|أهلًا وسهلًا|ahlan wa sahlan|خوش آمدید|phrase
Greetings|Good evening|Buenas tardes|Bonsoir|Guten Abend|こんばんは|konbanwa|مساء الخير|masā' al-khayr|شام بخیر|phrase
Greetings|See you later|Hasta luego|À plus tard|Bis später|またあとで|mata ato de|أراك لاحقًا|arāka lāḥiqan|پھر ملیں گے|phrase
Greetings|Good night|Buenas noches|Bonne nuit|Gute Nacht|おやすみなさい|oyasuminasai|تصبح على خير|tuṣbiḥ ʿalā khayr|شب بخیر|phrase
Greetings|How are you?|¿Cómo estás?|Comment ça va ?|Wie geht es dir?|お元気ですか|ogenki desu ka|كيف حالك؟|kayfa ḥāluka|آپ کیسے ہیں؟|phrase
Food & Dining|Bread|el pan|le pain|das Brot|パン|pan|خبز|khubz|روٹی|noun
Food & Dining|Rice|el arroz|le riz|der Reis|ご飯|gohan|أرز|aruzz|چاول|noun
Food & Dining|Milk|la leche|le lait|die Milch|牛乳|gyūnyū|حليب|ḥalīb|دودھ|noun
Food & Dining|Tea|el té|le thé|der Tee|お茶|ocha|شاي|shāy|چائے|noun
Food & Dining|Coffee|el café|le café|der Kaffee|コーヒー|kōhī|قهوة|qahwa|کافی|noun
Food & Dining|Apple|la manzana|la pomme|der Apfel|りんご|ringo|تفاحة|tuffāḥa|سیب|noun
Food & Dining|Banana|el plátano|la banane|die Banane|バナナ|banana|موزة|mawza|کیلا|noun
Food & Dining|Egg|el huevo|l'œuf|das Ei|卵|tamago|بيضة|bayḍa|انڈا|noun
Food & Dining|Cheese|el queso|le fromage|der Käse|チーズ|chīzu|جبن|jubn|پنیر|noun
Food & Dining|Soup|la sopa|la soupe|die Suppe|スープ|sūpu|حساء|ḥasā'|سوپ|noun
Food & Dining|Vegetables|las verduras|les légumes|das Gemüse|野菜|yasai|خضروات|khuḍrawāt|سبزیاں|noun
Food & Dining|Chicken|el pollo|le poulet|das Hähnchen|鶏肉|toriniku|دجاج|dajāj|مرغی|noun
Food & Dining|Fish|el pescado|le poisson|der Fisch|魚|sakana|سمك|samak|مچھلی|noun
Travel|Train|el tren|le train|der Zug|電車|densha|قطار|qiṭār|ٹرین|noun
Travel|Bus|el autobús|le bus|der Bus|バス|basu|حافلة|ḥāfila|بس|noun
Travel|Airport|el aeropuerto|l'aéroport|der Flughafen|空港|kūkō|مطار|maṭār|ہوائی اڈہ|noun
Travel|Hotel|el hotel|l'hôtel|das Hotel|ホテル|hoteru|فندق|funduq|ہوٹل|noun
Travel|Map|el mapa|la carte|die Karte|地図|chizu|خريطة|kharīṭa|نقشہ|noun
Travel|Street|la calle|la rue|die Straße|通り|tōri|شارع|shāriʿ|سڑک|noun
Travel|Left|izquierda|à gauche|links|左|hidari|يسار|yasār|بائیں|adverb
Travel|Right|derecha|à droite|rechts|右|migi|يمين|yamīn|دائیں|adverb
Travel|Near|cerca|près|nah|近い|chikai|قريب|qarīb|قریب|adjective
Travel|Far|lejos|loin|weit|遠い|tōi|بعيد|baʿīd|دور|adjective
Numbers|Four|cuatro|quatre|vier|四|yon|أربعة|arbaʿa|چار|number
Numbers|Five|cinco|cinq|fünf|五|go|خمسة|khamsa|پانچ|number
Numbers|Six|seis|six|sechs|六|roku|ستة|sitta|چھ|number
Numbers|Seven|siete|sept|sieben|七|nana|سبعة|sabʿa|سات|number
Numbers|Eight|ocho|huit|acht|八|hachi|ثمانية|thamāniya|آٹھ|number
Numbers|Nine|nueve|neuf|neun|九|kyū|تسعة|tisʿa|نو|number
Numbers|Ten|diez|dix|zehn|十|jū|عشرة|ʿashara|دس|number
Numbers|Eleven|once|onze|elf|十一|jūichi|أحد عشر|aḥada ʿashar|گیارہ|number
Numbers|Twelve|doce|douze|zwölf|十二|jūni|اثنا عشر|ithnā ʿashar|بارہ|number
Numbers|Twenty|veinte|vingt|zwanzig|二十|nijū|عشرون|ʿishrūn|بیس|number
Family|Mother|la madre|la mère|die Mutter|母|haha|أم|umm|ماں|noun
Family|Father|el padre|le père|der Vater|父|chichi|أب|ab|والد|noun
Family|Sister|la hermana|la sœur|die Schwester|姉妹|shimai|أخت|ukht|بہن|noun
Family|Brother|el hermano|le frère|der Bruder|兄弟|kyōdai|أخ|akh|بھائی|noun
Family|Son|el hijo|le fils|der Sohn|息子|musuko|ابن|ibn|بیٹا|noun
Family|Daughter|la hija|la fille|die Tochter|娘|musume|ابنة|ibna|بیٹی|noun
Family|Grandmother|la abuela|la grand-mère|die Großmutter|祖母|sobo|جدة|jadda|دادی/نانی|noun
Family|Friend|el amigo|l'ami|der Freund|友達|tomodachi|صديق|ṣadīq|دوست|noun
Home|House|la casa|la maison|das Haus|家|ie|بيت|bayt|گھر|noun
Home|Room|la habitación|la chambre|das Zimmer|部屋|heya|غرفة|ghurfa|کمرہ|noun
Home|Kitchen|la cocina|la cuisine|die Küche|台所|daidokoro|مطبخ|maṭbakh|باورچی خانہ|noun
Home|Door|la puerta|la porte|die Tür|ドア|doa|باب|bāb|دروازہ|noun
Home|Window|la ventana|la fenêtre|das Fenster|窓|mado|نافذة|nāfidha|کھڑکی|noun
Home|Table|la mesa|la table|der Tisch|テーブル|tēburu|طاولة|ṭāwila|میز|noun
Home|Chair|la silla|la chaise|der Stuhl|椅子|isu|كرسي|kursī|کرسی|noun
Home|Bed|la cama|le lit|das Bett|ベッド|beddo|سرير|sarīr|بستر|noun
Education|Book|el libro|le livre|das Buch|本|hon|كتاب|kitāb|کتاب|noun
Education|School|la escuela|l'école|die Schule|学校|gakkō|مدرسة|madrasa|اسکول|noun
Education|Teacher|el maestro|le professeur|der Lehrer|先生|sensei|معلم|muʿallim|استاد|noun
Education|Student|el estudiante|l'étudiant|der Schüler|学生|gakusei|طالب|ṭālib|طالب علم|noun
Education|Question|la pregunta|la question|die Frage|質問|shitsumon|سؤال|su'āl|سوال|noun
Education|Answer|la respuesta|la réponse|die Antwort|答え|kotae|إجابة|ijāba|جواب|noun
Education|To read|leer|lire|lesen|読む|yomu|قرأ|qara'a|پڑھنا|verb
Education|To write|escribir|écrire|schreiben|書く|kaku|كتب|kataba|لکھنا|verb
Animals|Dog|el perro|le chien|der Hund|犬|inu|كلب|kalb|کتا|noun
Animals|Cat|el gato|le chat|die Katze|猫|neko|قطة|qiṭṭa|بلی|noun
Animals|Bird|el pájaro|l'oiseau|der Vogel|鳥|tori|طائر|ṭā'ir|پرندہ|noun
Animals|Horse|el caballo|le cheval|das Pferd|馬|uma|حصان|ḥiṣān|گھوڑا|noun
Animals|Cow|la vaca|la vache|die Kuh|牛|ushi|بقرة|baqara|گائے|noun
Animals|Rabbit|el conejo|le lapin|das Kaninchen|うさぎ|usagi|أرنب|arnab|خرگوش|noun
Animals|Elephant|el elefante|l'éléphant|der Elefant|象|zō|فيل|fīl|ہاتھی|noun
Weather|Sun|el sol|le soleil|die Sonne|太陽|taiyō|شمس|shams|سورج|noun
Weather|Rain|la lluvia|la pluie|der Regen|雨|ame|مطر|maṭar|بارش|noun
Weather|Wind|el viento|le vent|der Wind|風|kaze|ريح|rīḥ|ہوا|noun
Weather|Snow|la nieve|la neige|der Schnee|雪|yuki|ثلج|thalj|برف|noun
Weather|Cloud|la nube|le nuage|die Wolke|雲|kumo|سحابة|saḥāba|بادل|noun
Weather|Hot|caliente|chaud|heiß|暑い|atsui|حار|ḥārr|گرم|adjective
Weather|Cold|frío|froid|kalt|寒い|samui|بارد|bārid|ٹھنڈا|adjective
Shopping|Market|el mercado|le marché|der Markt|市場|ichiba|سوق|sūq|بازار|noun
Shopping|Money|el dinero|l'argent|das Geld|お金|okane|مال|māl|پیسہ|noun
Shopping|Price|el precio|le prix|der Preis|値段|nedan|سعر|siʿr|قیمت|noun
Shopping|Cheap|barato|bon marché|günstig|安い|yasui|رخيص|rakhīṣ|سستا|adjective
Shopping|Expensive|caro|cher|teuer|高い|takai|غالي|ghālī|مہنگا|adjective
Shopping|Size|la talla|la taille|die Größe|サイズ|saizu|مقاس|maqās|سائز|noun
Shopping|Receipt|el recibo|le reçu|der Kassenbon|レシート|reshīto|إيصال|īṣāl|رسید|noun
Work|Office|la oficina|le bureau|das Büro|事務所|jimusho|مكتب|maktab|دفتر|noun
Work|Meeting|la reunión|la réunion|das Treffen|会議|kaigi|اجتماع|ijtimāʿ|میٹنگ|noun
Work|Computer|el ordenador|l'ordinateur|der Computer|コンピューター|konpyūtā|حاسوب|ḥāsūb|کمپیوٹر|noun
Work|Colleague|el compañero|le collègue|der Kollege|同僚|dōryō|زميل|zamīl|ساتھی|noun
Work|To work|trabajar|travailler|arbeiten|働く|hataraku|عمل|ʿamila|کام کرنا|verb
Work|Busy|ocupado|occupé|beschäftigt|忙しい|isogashii|مشغول|mashghūl|مصروف|adjective
Work|Help|la ayuda|l'aide|die Hilfe|助け|tasuke|مساعدة|musāʿada|مدد|noun
Daily Activities|To eat|comer|manger|essen|食べる|taberu|أكل|akala|کھانا|verb
Daily Activities|To drink|beber|boire|trinken|飲む|nomu|شرب|shariba|پینا|verb
Daily Activities|To sleep|dormir|dormir|schlafen|寝る|neru|نام|nāma|سونا|verb
Daily Activities|To walk|caminar|marcher|gehen|歩く|aruku|مشى|mashā|چلنا|verb
Daily Activities|To open|abrir|ouvrir|öffnen|開ける|akeru|فتح|fataḥa|کھولنا|verb
Daily Activities|To close|cerrar|fermer|schließen|閉める|shimeru|أغلق|aghlaqa|بند کرنا|verb
Daily Activities|Morning|la mañana|le matin|der Morgen|朝|asa|صباح|ṣabāḥ|صبح|noun
Health|Doctor|el médico|le médecin|der Arzt|医者|isha|طبيب|ṭabīb|ڈاکٹر|noun
Health|Hospital|el hospital|l'hôpital|das Krankenhaus|病院|byōin|مستشفى|mustashfā|ہسپتال|noun
Health|Medicine|la medicina|le médicament|das Medikament|薬|kusuri|دواء|dawā'|دوا|noun
Health|Pain|el dolor|la douleur|der Schmerz|痛み|itami|ألم|alam|درد|noun
Health|Healthy|sano|en bonne santé|gesund|健康な|kenkōna|صحي|ṣiḥḥī|صحت مند|adjective
Health|To rest|descansar|se reposer|sich ausruhen|休む|yasumu|استراح|istirāḥa|آرام کرنا|verb
Health|Drinking water|el agua potable|l'eau potable|das Trinkwasser|飲み水|nomimizu|مياه الشرب|miyāh ash-shurb|پینے کا پانی|noun
Nature|Tree|el árbol|l'arbre|der Baum|木|ki|شجرة|shajara|درخت|noun
Nature|Flower|la flor|la fleur|die Blume|花|hana|زهرة|zahra|پھول|noun
Nature|Mountain|la montaña|la montagne|der Berg|山|yama|جبل|jabal|پہاڑ|noun
Nature|River|el río|la rivière|der Fluss|川|kawa|نهر|nahr|دریا|noun
Nature|Sea|el mar|la mer|das Meer|海|umi|بحر|baḥr|سمندر|noun
Nature|Forest|el bosque|la forêt|der Wald|森|mori|غابة|ghāba|جنگل|noun
Technology|Phone|el teléfono|le téléphone|das Telefon|電話|denwa|هاتف|hātif|فون|noun
Technology|Internet|internet|Internet|das Internet|インターネット|intānetto|إنترنت|intarnit|انٹرنیٹ|noun
Technology|Message|el mensaje|le message|die Nachricht|メッセージ|messēji|رسالة|risāla|پیغام|noun
Technology|Photo|la foto|la photo|das Foto|写真|shashin|صورة|ṣūra|تصویر|noun
Technology|To search|buscar|chercher|suchen|探す|sagasu|بحث|baḥatha|تلاش کرنا|verb
Technology|To send|enviar|envoyer|senden|送る|okuru|أرسل|arsala|بھیجنا|verb
Technology|Password|la contraseña|le mot de passe|das Passwort|パスワード|pasuwādo|كلمة المرور|kalimat al-murūr|پاس ورڈ|noun
''';

  static List<VocabularyModel> forLanguage(String languageCode, int idOffset) {
    final words =
        _entries.trim().split('\n').map((line) => line.split('|')).toList();

    return [
      for (var index = 0; index < words.length; index++)
        _createWord(words[index], languageCode, idOffset + index + 1),
    ];
  }

  static VocabularyModel _createWord(
    List<String> entry,
    String languageCode,
    int id,
  ) {
    final category = entry[0];
    final english = entry[1];
    final word = switch (languageCode) {
      'es' => entry[2],
      'fr' => entry[3],
      'de' => entry[4],
      'ja' => entry[5],
      'ar' => entry[7],
      'en' => english,
      _ => throw ArgumentError.value(languageCode, 'languageCode'),
    };
    final partOfSpeech = _partOfSpeech(entry[10], languageCode, word);
    final example = _exampleFor(entry[1], entry[9], word, languageCode);

    return VocabularyModel(
      id: '${languageCode}_vocab_$id',
      languageCode: languageCode,
      word: word,
      phonetic: _phoneticFor(languageCode, word, entry),
      translation: english,
      urduTranslation: entry[9],
      localizedMeanings: {
        'en': english,
        'es': entry[2],
        'fr': entry[3],
        'de': entry[4],
        'ja': entry[5],
        'ar': entry[7],
        'ur': entry[9],
      },
      partOfSpeech: partOfSpeech,
      exampleSentence: example.targetSentence,
      exampleTranslation: example.englishTranslation,
      exampleUrduTranslation: example.urduTranslation,
      category: category,
    );
  }

  static String _phoneticFor(
    String languageCode,
    String word,
    List<String> entry,
  ) {
    return switch (languageCode) {
      'es' => '/${_spanishIpa(word)}/',
      'fr' => '/${_frenchIpa(word)}/',
      'de' => '/${_germanIpa(word)}/',
      'en' => '/${_englishIpa(word)}/',
      'ja' => entry[6],
      'ar' => entry[8],
      _ => throw ArgumentError.value(languageCode, 'languageCode'),
    };
  }

  static String _spanishIpa(String word) {
    var value = word.toLowerCase();
    const accents = {'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u'};
    for (final entry in accents.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value
        .replaceAll('ch', 'tʃ')
        .replaceAll('rr', 'R')
        .replaceAll('ll', 'ʝ')
        .replaceAll('qu', 'k')
        .replaceAll(RegExp(r'gu(?=[ei])'), 'g')
        .replaceAll('ñ', 'ɲ')
        .replaceAll('j', 'x')
        .replaceAll(RegExp(r'g(?=[ei])'), 'x')
        .replaceAll(RegExp(r'c(?=[ei])'), 's')
        .replaceAll('c', 'k')
        .replaceAll('z', 's')
        .replaceAll('v', 'b')
        .replaceAll('y', 'ʝ')
        .replaceAll('h', '')
        .replaceAll('r', 'ɾ')
        .replaceAll('R', 'r');
  }

  static String _frenchIpa(String word) {
    var value = word.toLowerCase();
    const accents = {'é': 'e', 'è': 'ɛ', 'ê': 'ɛ', 'à': 'a', 'ù': 'u'};
    for (final entry in accents.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value
        .replaceAll('eau', 'o')
        .replaceAll('au', 'o')
        .replaceAll('oi', 'wa')
        .replaceAll('ou', 'u')
        .replaceAll('ain', 'ɛ̃')
        .replaceAll('ein', 'ɛ̃')
        .replaceAll('in', 'ɛ̃')
        .replaceAll('on', 'ɔ̃')
        .replaceAll('an', 'ɑ̃')
        .replaceAll('en', 'ɑ̃')
        .replaceAll('ch', 'ʃ')
        .replaceAll('gn', 'ɲ')
        .replaceAll('ph', 'f')
        .replaceAll('qu', 'k')
        .replaceAll(RegExp(r'c(?=[ei])'), 's')
        .replaceAll('c', 'k')
        .replaceAll('j', 'ʒ')
        .replaceAll('r', 'ʁ')
        .replaceAll('u', 'y')
        .replaceAll(RegExp(r'\ble(?=\s)'), 'lə')
        .replaceAll(RegExp(r'[sxtdz]$'), '');
  }

  static String _germanIpa(String word) {
    return word
        .toLowerCase()
        .replaceAll('ä', 'ɛ')
        .replaceAll('ö', 'ø')
        .replaceAll('ü', 'y')
        .replaceAll('ß', 's')
        .replaceAll('tsch', 'tʃ')
        .replaceAll('sch', 'ʃ')
        .replaceAll('ch', 'ç')
        .replaceAll('ei', 'aɪ')
        .replaceAll('ie', 'iː')
        .replaceAll('eu', 'ɔʏ')
        .replaceAll('äu', 'ɔʏ')
        .replaceAll('au', 'aʊ')
        .replaceAll('sp', 'ʃp')
        .replaceAll('st', 'ʃt')
        .replaceAll('z', 'ts')
        .replaceAll('w', 'v')
        .replaceAll('v', 'f')
        .replaceAll('j', 'j')
        .replaceAll('ng', 'ŋ')
        .replaceAll('r', 'ʁ')
        .replaceAll(RegExp(r's(?=[aeiouyɛø])'), 'z')
        .replaceAll(RegExp(r'(?<=[aeiouɛøy])h(?=[aeiou])'), '')
        .replaceAll('e', 'ə');
  }

  static String _englishIpa(String word) {
    final knownPronunciation = _englishPronunciations[word.toLowerCase()];
    if (knownPronunciation != null) return knownPronunciation;

    return word
        .toLowerCase()
        .replaceAll('tion', 'ʃən')
        .replaceAll('tch', 'tʃ')
        .replaceAll('sh', 'ʃ')
        .replaceAll('ch', 'tʃ')
        .replaceAll('th', 'θ')
        .replaceAll('ph', 'f')
        .replaceAll('igh', 'aɪ')
        .replaceAll('ee', 'iː')
        .replaceAll('ea', 'iː')
        .replaceAll('oo', 'uː')
        .replaceAll('ou', 'aʊ')
        .replaceAll('ow', 'aʊ')
        .replaceAll('ai', 'eɪ')
        .replaceAll('ay', 'eɪ')
        .replaceAll('oi', 'ɔɪ')
        .replaceAll('er', 'ər')
        .replaceAll('ar', 'ɑːr')
        .replaceAll('or', 'ɔːr')
        .replaceAll('ng', 'ŋ')
        .replaceAll('a', 'æ')
        .replaceAll('e', 'ɛ')
        .replaceAll('i', 'ɪ')
        .replaceAll('o', 'ɒ')
        .replaceAll('u', 'ʌ')
        .replaceAll('y', 'i');
  }

  static const _englishPronunciations = {
    'goodbye': 'ɡʊdˈbaɪ',
    'sorry': 'ˈsɑːri',
    'excuse me': 'ɪkˈskjuːz miː',
    'welcome': 'ˈwɛlkəm',
    'good evening': 'ɡʊd ˈiːvnɪŋ',
    'see you later': 'ˌsiː juː ˈleɪtər',
    'good night': 'ɡʊd ˈnaɪt',
    'how are you?': 'haʊ ɑːr juː',
    'bread': 'brɛd',
    'rice': 'raɪs',
    'milk': 'mɪlk',
    'tea': 'tiː',
    'coffee': 'ˈkɔːfi',
    'apple': 'ˈæpəl',
    'banana': 'bəˈnænə',
    'egg': 'ɛɡ',
    'cheese': 'tʃiːz',
    'soup': 'suːp',
    'vegetables': 'ˈvɛdʒtəbəlz',
    'chicken': 'ˈtʃɪkɪn',
    'fish': 'fɪʃ',
    'train': 'treɪn',
    'bus': 'bʌs',
    'airport': 'ˈɛrˌpɔːrt',
    'hotel': 'hoʊˈtɛl',
    'map': 'mæp',
    'street': 'striːt',
    'left': 'lɛft',
    'right': 'raɪt',
    'near': 'nɪr',
    'far': 'fɑːr',
    'four': 'fɔːr',
    'five': 'faɪv',
    'six': 'sɪks',
    'seven': 'ˈsɛvən',
    'eight': 'eɪt',
    'nine': 'naɪn',
    'ten': 'tɛn',
    'eleven': 'ɪˈlɛvən',
    'twelve': 'twɛlv',
    'twenty': 'ˈtwɛnti',
    'mother': 'ˈmʌðər',
    'father': 'ˈfɑːðər',
    'sister': 'ˈsɪstər',
    'brother': 'ˈbrʌðər',
    'son': 'sʌn',
    'daughter': 'ˈdɔːtər',
    'grandmother': 'ˈɡrænˌmʌðər',
    'friend': 'frɛnd',
    'house': 'haʊs',
    'room': 'ruːm',
    'kitchen': 'ˈkɪtʃən',
    'door': 'dɔːr',
    'window': 'ˈwɪndoʊ',
    'table': 'ˈteɪbəl',
    'chair': 'tʃɛr',
    'bed': 'bɛd',
    'book': 'bʊk',
    'school': 'skuːl',
    'teacher': 'ˈtiːtʃər',
    'student': 'ˈstuːdənt',
    'question': 'ˈkwɛstʃən',
    'answer': 'ˈænsər',
    'to read': 'tuː riːd',
    'to write': 'tuː raɪt',
    'dog': 'dɔːɡ',
    'cat': 'kæt',
    'bird': 'bɜːrd',
    'horse': 'hɔːrs',
    'cow': 'kaʊ',
    'rabbit': 'ˈræbɪt',
    'elephant': 'ˈɛləfənt',
    'sun': 'sʌn',
    'rain': 'reɪn',
    'wind': 'wɪnd',
    'snow': 'snoʊ',
    'cloud': 'klaʊd',
    'hot': 'hɑːt',
    'cold': 'koʊld',
    'market': 'ˈmɑːrkɪt',
    'money': 'ˈmʌni',
    'price': 'praɪs',
    'cheap': 'tʃiːp',
    'expensive': 'ɪkˈspɛnsɪv',
    'size': 'saɪz',
    'receipt': 'rɪˈsiːt',
    'office': 'ˈɔːfɪs',
    'meeting': 'ˈmiːtɪŋ',
    'computer': 'kəmˈpjuːtər',
    'colleague': 'ˈkɑːliːɡ',
    'to work': 'tuː wɜːrk',
    'busy': 'ˈbɪzi',
    'help': 'hɛlp',
    'to eat': 'tuː iːt',
    'to drink': 'tuː drɪŋk',
    'to sleep': 'tuː sliːp',
    'to walk': 'tuː wɔːk',
    'to open': 'tuː ˈoʊpən',
    'to close': 'tuː kloʊz',
    'morning': 'ˈmɔːrnɪŋ',
    'doctor': 'ˈdɑːktər',
    'hospital': 'ˈhɑːspɪtəl',
    'medicine': 'ˈmɛdɪsən',
    'pain': 'peɪn',
    'healthy': 'ˈhɛlθi',
    'to rest': 'tuː rɛst',
    'drinking water': 'ˈdrɪŋkɪŋ ˈwɔːtər',
    'tree': 'triː',
    'flower': 'ˈflaʊər',
    'mountain': 'ˈmaʊntən',
    'river': 'ˈrɪvər',
    'sea': 'siː',
    'forest': 'ˈfɔːrɪst',
    'phone': 'foʊn',
    'internet': 'ˈɪntərnɛt',
    'message': 'ˈmɛsɪdʒ',
    'photo': 'ˈfoʊtoʊ',
    'to search': 'tuː sɜːrtʃ',
    'to send': 'tuː sɛnd',
    'password': 'ˈpæsˌwɜːrd',
  };

  static _VocabularyExample _exampleFor(
    String english,
    String urdu,
    String word,
    String languageCode,
  ) {
    final exact = _examples[english];
    if (exact != null) {
      return _VocabularyExample(
        targetSentence: exact.target(languageCode),
        englishTranslation: exact.english,
        urduTranslation: exact.urdu,
      );
    }

    final isNumber = _numberWords.contains(english);
    if (isNumber) {
      final target = switch (languageCode) {
        'es' => 'Tengo $word manzanas.',
        'fr' => "J'ai $word pommes.",
        'de' => 'Ich habe $word Äpfel.',
        'ja' => 'りんごを$word個持っています。',
        'ar' => 'لدي $word تفاحات.',
        'en' => 'I have $english apples.',
        _ => throw ArgumentError.value(languageCode, 'languageCode'),
      };
      return _VocabularyExample(
        targetSentence: target,
        englishTranslation: 'I have ${english.toLowerCase()} apples.',
        urduTranslation: 'میرے پاس $urdu سیب ہیں۔',
      );
    }

    final isAdjective = _adjectiveExamples[english];
    if (isAdjective != null) {
      return _VocabularyExample(
        targetSentence: isAdjective.target(languageCode),
        englishTranslation: isAdjective.english,
        urduTranslation: isAdjective.urdu,
      );
    }

    if (_verbExamples.containsKey(english)) {
      final example = _verbExamples[english]!;
      return _VocabularyExample(
        targetSentence: example.target(languageCode),
        englishTranslation: example.english,
        urduTranslation: example.urdu,
      );
    }

    throw StateError('Missing contextual example for "$english".');
  }

  static const _numberWords = {
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Twenty',
  };

  static const Map<String, _VocabularyExampleSeed> _examples = {
    'Goodbye': _VocabularyExampleSeed(
      english: 'We said goodbye before leaving.',
      urdu: 'ہم نے جانے سے پہلے الوداع کہا۔',
      spanish: 'Nos despedimos antes de irnos.',
      french: 'Nous nous sommes dit au revoir avant de partir.',
      german: 'Wir verabschiedeten uns, bevor wir gingen.',
      japanese: '出発する前に「さようなら」と言いました。',
      arabic: 'ودعنا بعضنا قبل المغادرة.',
    ),
    'Sorry': _VocabularyExampleSeed(
      english: 'He said sorry for arriving late.',
      urdu: 'دیر سے پہنچنے پر اس نے معذرت کی۔',
      spanish: 'Dijo «Lo siento» por llegar tarde.',
      french: 'Il a dit « Je suis désolé » d’être arrivé en retard.',
      german: 'Er sagte „Es tut mir leid“, weil er zu spät kam.',
      japanese: '遅れて来たことを謝りました。',
      arabic: 'قال «أنا آسف» لأنه وصل متأخرًا.',
    ),
    'Excuse me': _VocabularyExampleSeed(
      english: 'She said “Excuse me” to get past.',
      urdu: 'راستہ لینے کے لیے اس نے کہا، "معاف کیجیے۔"',
      spanish: 'Dijo «Disculpe» para poder pasar.',
      french: 'Elle a dit « Excusez-moi » pour passer.',
      german: 'Sie sagte „Entschuldigung“, um vorbeizugehen.',
      japanese: '通るために「すみません」と言いました。',
      arabic: 'قالت «عذرًا» لكي تمر.',
    ),
    'Welcome': _VocabularyExampleSeed(
      english: 'A welcome sign stood by the front door.',
      urdu: 'سامنے کے دروازے کے پاس خوش آمدید کا بورڈ تھا۔',
      spanish: 'El cartel decía «Bienvenido» en la puerta.',
      french: 'Le panneau disait « Bienvenue » près de la porte.',
      german: 'Auf dem Schild an der Tür stand „Willkommen“.',
      japanese: '玄関の看板に「ようこそ」と書いてありました。',
      arabic: 'كانت اللافتة عند الباب تقول «أهلًا وسهلًا».',
    ),
    'Good evening': _VocabularyExampleSeed(
      english: 'We greeted our neighbors with “Good evening.”',
      urdu: 'ہم نے اپنے پڑوسیوں کو شام بخیر کہا۔',
      spanish: 'Saludamos a nuestros vecinos con «Buenas tardes».',
      french: 'Nous avons salué nos voisins en disant « Bonsoir ».',
      german: 'Wir begrüßten unsere Nachbarn mit „Guten Abend“.',
      japanese: '近所の人に「こんばんは」と挨拶しました。',
      arabic: 'حيينا جيراننا بقول «مساء الخير».',
    ),
    'See you later': _VocabularyExampleSeed(
      english: 'She said “See you later” after class.',
      urdu: 'کلاس کے بعد اس نے کہا، "پھر ملیں گے۔"',
      spanish: 'Dijo «Hasta luego» después de clase.',
      french: 'Elle a dit « À plus tard » après le cours.',
      german: 'Nach dem Unterricht sagte sie „Bis später“.',
      japanese: '授業の後で「またあとで」と言いました。',
      arabic: 'قالت «أراك لاحقًا» بعد الدرس.',
    ),
    'Good night': _VocabularyExampleSeed(
      english: 'I said “Good night” before going to bed.',
      urdu: 'سونے سے پہلے میں نے شب بخیر کہا۔',
      spanish: 'Dije «Buenas noches» antes de acostarme.',
      french: 'J’ai dit « Bonne nuit » avant de me coucher.',
      german: 'Vor dem Schlafengehen sagte ich „Gute Nacht“.',
      japanese: '寝る前に「おやすみなさい」と言いました。',
      arabic: 'قلت «تصبح على خير» قبل أن أنام.',
    ),
    'How are you?': _VocabularyExampleSeed(
      english: 'He asked his friend, “How are you?”',
      urdu: 'اس نے اپنے دوست سے پوچھا، "آپ کیسے ہیں؟"',
      spanish: 'Le preguntó a su amigo: «¿Cómo estás?».',
      french: 'Il a demandé à son ami : « Comment ça va ? »',
      german: 'Er fragte seinen Freund: „Wie geht es dir?“',
      japanese: '友達に「お元気ですか」と尋ねました。',
      arabic: 'سأل صديقه: «كيف حالك؟».',
    ),
    'Train': _VocabularyExampleSeed(
      english: 'The train leaves at eight.',
      urdu: 'ٹرین آٹھ بجے روانہ ہوتی ہے۔',
      spanish: 'El tren sale a las ocho.',
      french: 'Le train part à huit heures.',
      german: 'Der Zug fährt um acht Uhr ab.',
      japanese: '電車は八時に出発します。',
      arabic: 'يغادر القطار في الساعة الثامنة.',
    ),
    'Bus': _VocabularyExampleSeed(
      english: 'We take the bus to the city center.',
      urdu: 'ہم شہر کے مرکز تک بس لیتے ہیں۔',
      spanish: 'Tomamos el autobús hasta el centro.',
      french: 'Nous prenons le bus jusqu’au centre-ville.',
      german: 'Wir fahren mit dem Bus ins Stadtzentrum.',
      japanese: '市の中心部までバスに乗ります。',
      arabic: 'نستقل الحافلة إلى وسط المدينة.',
    ),
    'Airport': _VocabularyExampleSeed(
      english: 'Our plane landed at the airport early.',
      urdu: 'ہمارا طیارہ ہوائی اڈے پر جلدی اتر گیا۔',
      spanish: 'Nuestro avión aterrizó temprano en el aeropuerto.',
      french: 'Notre avion a atterri tôt à l’aéroport.',
      german: 'Unser Flugzeug landete früh am Flughafen.',
      japanese: '飛行機は早く空港に着陸しました。',
      arabic: 'هبطت طائرتنا في المطار مبكرًا.',
    ),
    'Hotel': _VocabularyExampleSeed(
      english: 'We checked into the hotel after our trip.',
      urdu: 'سفر کے بعد ہم نے ہوٹل میں کمرہ لیا۔',
      spanish: 'Nos registramos en el hotel después del viaje.',
      french: 'Nous sommes arrivés à l’hôtel après le voyage.',
      german: 'Nach der Reise checkten wir im Hotel ein.',
      japanese: '旅行の後、ホテルにチェックインしました。',
      arabic: 'سجلنا في الفندق بعد الرحلة.',
    ),
    'Map': _VocabularyExampleSeed(
      english: 'We used a map to find the station.',
      urdu: 'ہم نے اسٹیشن تلاش کرنے کے لیے نقشہ استعمال کیا۔',
      spanish: 'Usamos un mapa para encontrar la estación.',
      french: 'Nous avons utilisé une carte pour trouver la gare.',
      german: 'Mit einer Karte fanden wir den Bahnhof.',
      japanese: '地図を使って駅を見つけました。',
      arabic: 'استخدمنا خريطة للعثور على المحطة.',
    ),
    'Street': _VocabularyExampleSeed(
      english: 'The street is quiet in the morning.',
      urdu: 'صبح کے وقت سڑک پرسکون ہوتی ہے۔',
      spanish: 'La calle está tranquila por la mañana.',
      french: 'La rue est calme le matin.',
      german: 'Die Straße ist am Morgen ruhig.',
      japanese: '朝、この通りは静かです。',
      arabic: 'الشارع هادئ في الصباح.',
    ),
    'Left': _VocabularyExampleSeed(
      english: 'Turn left at the next street.',
      urdu: 'اگلی سڑک پر بائیں مڑیں۔',
      spanish: 'Gira a la izquierda en la próxima calle.',
      french: 'Tournez à gauche à la prochaine rue.',
      german: 'Biegen Sie an der nächsten Straße links ab.',
      japanese: '次の通りを左に曲がってください。',
      arabic: 'انعطف يسارًا عند الشارع التالي.',
    ),
    'Right': _VocabularyExampleSeed(
      english: 'Turn right at the traffic light.',
      urdu: 'ٹریفک سگنل پر دائیں مڑیں۔',
      spanish: 'Gira a la derecha en el semáforo.',
      french: 'Tournez à droite au feu.',
      german: 'Biegen Sie an der Ampel rechts ab.',
      japanese: '信号で右に曲がってください。',
      arabic: 'انعطف يمينًا عند إشارة المرور.',
    ),
    'Mother': _VocabularyExampleSeed(
      english: 'My mother calls me every morning.',
      urdu: 'میری والدہ ہر صبح مجھے فون کرتی ہیں۔',
      spanish: 'Mi madre me llama cada mañana.',
      french: 'Ma mère m’appelle chaque matin.',
      german: 'Meine Mutter ruft mich jeden Morgen an.',
      japanese: '母は毎朝私に電話します。',
      arabic: 'تتصل بي أمي كل صباح.',
    ),
    'Father': _VocabularyExampleSeed(
      english: 'My father works in the city.',
      urdu: 'میرے والد شہر میں کام کرتے ہیں۔',
      spanish: 'Mi padre trabaja en la ciudad.',
      french: 'Mon père travaille en ville.',
      german: 'Mein Vater arbeitet in der Stadt.',
      japanese: '父は町で働いています。',
      arabic: 'يعمل أبي في المدينة.',
    ),
    'Sister': _VocabularyExampleSeed(
      english: 'My sister studies at the university.',
      urdu: 'میری بہن یونیورسٹی میں پڑھتی ہے۔',
      spanish: 'Mi hermana estudia en la universidad.',
      french: 'Ma sœur étudie à l’université.',
      german: 'Meine Schwester studiert an der Universität.',
      japanese: '姉は大学で勉強しています。',
      arabic: 'تدرس أختي في الجامعة.',
    ),
    'Brother': _VocabularyExampleSeed(
      english: 'My brother plays football after school.',
      urdu: 'میرا بھائی اسکول کے بعد فٹ بال کھیلتا ہے۔',
      spanish: 'Mi hermano juega al fútbol después de la escuela.',
      french: 'Mon frère joue au football après l’école.',
      german: 'Mein Bruder spielt nach der Schule Fußball.',
      japanese: '兄は学校の後でサッカーをします。',
      arabic: 'يلعب أخي كرة القدم بعد المدرسة.',
    ),
    'Son': _VocabularyExampleSeed(
      english: 'Their son is learning to read.',
      urdu: 'ان کا بیٹا پڑھنا سیکھ رہا ہے۔',
      spanish: 'Su hijo está aprendiendo a leer.',
      french: 'Leur fils apprend à lire.',
      german: 'Ihr Sohn lernt lesen.',
      japanese: '彼らの息子は読むことを学んでいます。',
      arabic: 'يتعلم ابنهما القراءة.',
    ),
    'Daughter': _VocabularyExampleSeed(
      english: 'Their daughter walks to school.',
      urdu: 'ان کی بیٹی پیدل اسکول جاتی ہے۔',
      spanish: 'Su hija va caminando a la escuela.',
      french: 'Leur fille va à l’école à pied.',
      german: 'Ihre Tochter geht zu Fuß zur Schule.',
      japanese: '彼らの娘は歩いて学校へ行きます。',
      arabic: 'تذهب ابنتهما إلى المدرسة سيرًا.',
    ),
    'Grandmother': _VocabularyExampleSeed(
      english: 'My grandmother tells us stories.',
      urdu: 'میری دادی ہمیں کہانیاں سناتی ہیں۔',
      spanish: 'Mi abuela nos cuenta historias.',
      french: 'Ma grand-mère nous raconte des histoires.',
      german: 'Meine Großmutter erzählt uns Geschichten.',
      japanese: '祖母は私たちに物語を話してくれます。',
      arabic: 'تحكي لنا جدتي القصص.',
    ),
    'Friend': _VocabularyExampleSeed(
      english: 'My friend is waiting outside.',
      urdu: 'میرا دوست باہر انتظار کر رہا ہے۔',
      spanish: 'Mi amigo está esperando afuera.',
      french: 'Mon ami attend dehors.',
      german: 'Mein Freund wartet draußen.',
      japanese: '友達が外で待っています。',
      arabic: 'صديقي ينتظر في الخارج.',
    ),
    'House': _VocabularyExampleSeed(
      english: 'Our house has a small garden.',
      urdu: 'ہمارے گھر میں ایک چھوٹا سا باغ ہے۔',
      spanish: 'Nuestra casa tiene un jardín pequeño.',
      french: 'Notre maison a un petit jardin.',
      german: 'Unser Haus hat einen kleinen Garten.',
      japanese: '私たちの家には小さな庭があります。',
      arabic: 'لمنزلنا حديقة صغيرة.',
    ),
    'Room': _VocabularyExampleSeed(
      english: 'I keep my room tidy.',
      urdu: 'میں اپنا کمرہ صاف ستھرا رکھتا ہوں۔',
      spanish: 'Mantengo mi habitación ordenada.',
      french: 'Je garde ma chambre rangée.',
      german: 'Ich halte mein Zimmer ordentlich.',
      japanese: '部屋をきれいに保っています。',
      arabic: 'أحافظ على ترتيب غرفتي.',
    ),
    'Kitchen': _VocabularyExampleSeed(
      english: 'We cook dinner together in the kitchen.',
      urdu: 'ہم باورچی خانے میں مل کر رات کا کھانا پکاتے ہیں۔',
      spanish: 'Preparamos la cena juntos en la cocina.',
      french: 'Nous préparons le dîner ensemble dans la cuisine.',
      german: 'Wir kochen zusammen das Abendessen in der Küche.',
      japanese: '台所で一緒に夕食を作ります。',
      arabic: 'نعد العشاء معًا في المطبخ.',
    ),
    'Door': _VocabularyExampleSeed(
      english: 'Please close the door when you leave.',
      urdu: 'جاتے وقت براہ کرم دروازہ بند کر دیں۔',
      spanish: 'Cierra la puerta al salir, por favor.',
      french: 'Ferme la porte en partant, s’il te plaît.',
      german: 'Bitte schließ die Tür, wenn du gehst.',
      japanese: '出るときにドアを閉めてください。',
      arabic: 'أغلق الباب من فضلك عندما تغادر.',
    ),
    'Window': _VocabularyExampleSeed(
      english: 'Open the window to let in fresh air.',
      urdu: 'تازہ ہوا اندر آنے دینے کے لیے کھڑکی کھولیں۔',
      spanish: 'Abre la ventana para que entre aire fresco.',
      french: 'Ouvre la fenêtre pour laisser entrer l’air frais.',
      german: 'Öffne das Fenster, damit frische Luft hereinkommt.',
      japanese: '新鮮な空気を入れるために窓を開けてください。',
      arabic: 'افتح النافذة ليدخل الهواء النقي.',
    ),
    'Table': _VocabularyExampleSeed(
      english: 'The book is on the table.',
      urdu: 'کتاب میز پر ہے۔',
      spanish: 'El libro está sobre la mesa.',
      french: 'Le livre est sur la table.',
      german: 'Das Buch liegt auf dem Tisch.',
      japanese: '本はテーブルの上にあります。',
      arabic: 'الكتاب على الطاولة.',
    ),
    'Chair': _VocabularyExampleSeed(
      english: 'Please sit on this chair.',
      urdu: 'براہ کرم اس کرسی پر بیٹھیں۔',
      spanish: 'Siéntate en esta silla, por favor.',
      french: 'Assieds-toi sur cette chaise, s’il te plaît.',
      german: 'Setz dich bitte auf diesen Stuhl.',
      japanese: 'この椅子に座ってください。',
      arabic: 'اجلس على هذا الكرسي من فضلك.',
    ),
    'Bed': _VocabularyExampleSeed(
      english: 'The child sleeps in a comfortable bed.',
      urdu: 'بچہ آرام دہ بستر پر سوتا ہے۔',
      spanish: 'El niño duerme en una cama cómoda.',
      french: 'L’enfant dort dans un lit confortable.',
      german: 'Das Kind schläft in einem bequemen Bett.',
      japanese: '子どもは快適なベッドで眠ります。',
      arabic: 'ينام الطفل في سرير مريح.',
    ),
    'Book': _VocabularyExampleSeed(
      english: 'I read a book before going to sleep.',
      urdu: 'میں سونے سے پہلے ایک کتاب پڑھتا ہوں۔',
      spanish: 'Leo un libro antes de dormir.',
      french: 'Je lis un livre avant de dormir.',
      german: 'Vor dem Schlafengehen lese ich ein Buch.',
      japanese: '寝る前に本を読みます。',
      arabic: 'أقرأ كتابًا قبل النوم.',
    ),
    'School': _VocabularyExampleSeed(
      english: 'The children walk to school together.',
      urdu: 'بچے مل کر پیدل اسکول جاتے ہیں۔',
      spanish: 'Los niños caminan juntos a la escuela.',
      french: 'Les enfants vont à l’école ensemble à pied.',
      german: 'Die Kinder gehen gemeinsam zu Fuß zur Schule.',
      japanese: '子どもたちは一緒に歩いて学校へ行きます。',
      arabic: 'يمشي الأطفال إلى المدرسة معًا.',
    ),
    'Teacher': _VocabularyExampleSeed(
      english: 'The teacher explains the new lesson.',
      urdu: 'استاد نیا سبق سمجھاتے ہیں۔',
      spanish: 'El maestro explica la lección nueva.',
      french: 'Le professeur explique la nouvelle leçon.',
      german: 'Der Lehrer erklärt die neue Lektion.',
      japanese: '先生は新しい授業を説明します。',
      arabic: 'يشرح المعلم الدرس الجديد.',
    ),
    'Student': _VocabularyExampleSeed(
      english: 'The student asks a question in class.',
      urdu: 'طالب علم کلاس میں ایک سوال پوچھتا ہے۔',
      spanish: 'El estudiante hace una pregunta en clase.',
      french: 'L’étudiant pose une question en classe.',
      german: 'Der Schüler stellt im Unterricht eine Frage.',
      japanese: '学生は授業で質問をします。',
      arabic: 'يطرح الطالب سؤالًا في الصف.',
    ),
    'Question': _VocabularyExampleSeed(
      english: 'I have a question about this exercise.',
      urdu: 'مجھے اس مشق کے بارے میں ایک سوال ہے۔',
      spanish: 'Tengo una pregunta sobre este ejercicio.',
      french: 'J’ai une question sur cet exercice.',
      german: 'Ich habe eine Frage zu dieser Übung.',
      japanese: 'この練習について質問があります。',
      arabic: 'لدي سؤال عن هذا التمرين.',
    ),
    'Answer': _VocabularyExampleSeed(
      english: 'She knows the answer to the question.',
      urdu: 'وہ سوال کا جواب جانتی ہے۔',
      spanish: 'Ella sabe la respuesta a la pregunta.',
      french: 'Elle connaît la réponse à la question.',
      german: 'Sie kennt die Antwort auf die Frage.',
      japanese: '彼女は質問の答えを知っています。',
      arabic: 'تعرف إجابة السؤال.',
    ),
    'Dog': _VocabularyExampleSeed(
      english: 'The dog runs in the park every morning.',
      urdu: 'کتا ہر صبح پارک میں دوڑتا ہے۔',
      spanish: 'El perro corre por el parque cada mañana.',
      french: 'Le chien court dans le parc chaque matin.',
      german: 'Der Hund läuft jeden Morgen im Park.',
      japanese: '犬は毎朝公園を走ります。',
      arabic: 'يركض الكلب في الحديقة كل صباح.',
    ),
    'Cat': _VocabularyExampleSeed(
      english: 'The cat is sleeping on the chair.',
      urdu: 'بلی کرسی پر سو رہی ہے۔',
      spanish: 'El gato duerme en la silla.',
      french: 'Le chat dort sur la chaise.',
      german: 'Die Katze schläft auf dem Stuhl.',
      japanese: '猫は椅子の上で眠っています。',
      arabic: 'تنام القطة على الكرسي.',
    ),
    'Bird': _VocabularyExampleSeed(
      english: 'A bird is singing in the tree.',
      urdu: 'ایک پرندہ درخت پر گا رہا ہے۔',
      spanish: 'Un pájaro canta en el árbol.',
      french: 'Un oiseau chante dans l’arbre.',
      german: 'Ein Vogel singt im Baum.',
      japanese: '鳥が木の上で鳴いています。',
      arabic: 'يغرد طائر على الشجرة.',
    ),
    'Horse': _VocabularyExampleSeed(
      english: 'The horse runs across the field.',
      urdu: 'گھوڑا میدان میں دوڑتا ہے۔',
      spanish: 'El caballo corre por el campo.',
      french: 'Le cheval court dans le champ.',
      german: 'Das Pferd läuft über das Feld.',
      japanese: '馬が野原を走ります。',
      arabic: 'يركض الحصان في الحقل.',
    ),
    'Cow': _VocabularyExampleSeed(
      english: 'The cow gives milk every morning.',
      urdu: 'گائے ہر صبح دودھ دیتی ہے۔',
      spanish: 'La vaca da leche cada mañana.',
      french: 'La vache donne du lait chaque matin.',
      german: 'Die Kuh gibt jeden Morgen Milch.',
      japanese: '牛は毎朝牛乳を出します。',
      arabic: 'تعطي البقرة الحليب كل صباح.',
    ),
    'Rabbit': _VocabularyExampleSeed(
      english: 'The rabbit eats a carrot in the garden.',
      urdu: 'خرگوش باغ میں گاجر کھاتا ہے۔',
      spanish: 'El conejo come una zanahoria en el jardín.',
      french: 'Le lapin mange une carotte dans le jardin.',
      german: 'Das Kaninchen frisst eine Karotte im Garten.',
      japanese: 'うさぎは庭でにんじんを食べます。',
      arabic: 'يأكل الأرنب جزرة في الحديقة.',
    ),
    'Elephant': _VocabularyExampleSeed(
      english: 'The elephant has a long trunk.',
      urdu: 'ہاتھی کی سونڈ لمبی ہوتی ہے۔',
      spanish: 'El elefante tiene una trompa larga.',
      french: 'L’éléphant a une longue trompe.',
      german: 'Der Elefant hat einen langen Rüssel.',
      japanese: '象は長い鼻を持っています。',
      arabic: 'للفيل خرطوم طويل.',
    ),
    'Sun': _VocabularyExampleSeed(
      english: 'The sun is bright this morning.',
      urdu: 'آج صبح سورج روشن ہے۔',
      spanish: 'El sol brilla esta mañana.',
      french: 'Le soleil brille ce matin.',
      german: 'Die Sonne scheint heute Morgen.',
      japanese: '今朝は太陽が輝いています。',
      arabic: 'الشمس ساطعة هذا الصباح.',
    ),
    'Rain': _VocabularyExampleSeed(
      english: 'The rain stopped before noon.',
      urdu: 'دوپہر سے پہلے بارش رک گئی۔',
      spanish: 'La lluvia paró antes del mediodía.',
      french: 'La pluie s’est arrêtée avant midi.',
      german: 'Der Regen hörte vor Mittag auf.',
      japanese: '昼前に雨がやみました。',
      arabic: 'توقف المطر قبل الظهر.',
    ),
    'Wind': _VocabularyExampleSeed(
      english: 'The wind is strong near the sea.',
      urdu: 'سمندر کے قریب ہوا تیز ہے۔',
      spanish: 'El viento es fuerte cerca del mar.',
      french: 'Le vent souffle fort près de la mer.',
      german: 'Der Wind ist in Meeresnähe stark.',
      japanese: '海の近くでは風が強いです。',
      arabic: 'الرياح قوية بالقرب من البحر.',
    ),
    'Snow': _VocabularyExampleSeed(
      english: 'Snow covered the road during the night.',
      urdu: 'رات کے دوران برف نے سڑک ڈھانپ دی۔',
      spanish: 'La nieve cubrió la carretera durante la noche.',
      french: 'La neige a couvert la route pendant la nuit.',
      german: 'In der Nacht bedeckte Schnee die Straße.',
      japanese: '夜の間に雪が道路を覆いました。',
      arabic: 'غطى الثلج الطريق أثناء الليل.',
    ),
    'Cloud': _VocabularyExampleSeed(
      english: 'A dark cloud moved across the sky.',
      urdu: 'ایک گہرا بادل آسمان پر چھا گیا۔',
      spanish: 'Una nube oscura cruzó el cielo.',
      french: 'Un nuage sombre a traversé le ciel.',
      german: 'Eine dunkle Wolke zog über den Himmel.',
      japanese: '暗い雲が空を横切りました。',
      arabic: 'مرت سحابة داكنة عبر السماء.',
    ),
    'Market': _VocabularyExampleSeed(
      english: 'We buy fresh vegetables at the market.',
      urdu: 'ہم بازار سے تازہ سبزیاں خریدتے ہیں۔',
      spanish: 'Compramos verduras frescas en el mercado.',
      french: 'Nous achetons des légumes frais au marché.',
      german: 'Wir kaufen frisches Gemüse auf dem Markt.',
      japanese: '市場で新鮮な野菜を買います。',
      arabic: 'نشتري الخضروات الطازجة من السوق.',
    ),
    'Money': _VocabularyExampleSeed(
      english: 'I need money to pay for the ticket.',
      urdu: 'مجھے ٹکٹ کی ادائیگی کے لیے پیسوں کی ضرورت ہے۔',
      spanish: 'Necesito dinero para pagar el billete.',
      french: 'J’ai besoin d’argent pour payer le billet.',
      german: 'Ich brauche Geld, um das Ticket zu bezahlen.',
      japanese: '切符の代金を払うのにお金が必要です。',
      arabic: 'أحتاج إلى المال لدفع ثمن التذكرة.',
    ),
    'Price': _VocabularyExampleSeed(
      english: 'The price is written on the label.',
      urdu: 'قیمت لیبل پر لکھی ہوئی ہے۔',
      spanish: 'El precio está escrito en la etiqueta.',
      french: 'Le prix est écrit sur l’étiquette.',
      german: 'Der Preis steht auf dem Etikett.',
      japanese: '値段はラベルに書いてあります。',
      arabic: 'السعر مكتوب على الملصق.',
    ),
    'Size': _VocabularyExampleSeed(
      english: 'What size do you need?',
      urdu: 'آپ کو کون سا سائز چاہیے؟',
      spanish: '¿Qué talla necesitas?',
      french: 'Quelle taille vous faut-il ?',
      german: 'Welche Größe brauchst du?',
      japanese: 'どのサイズが必要ですか。',
      arabic: 'ما المقاس الذي تحتاجه؟',
    ),
    'Receipt': _VocabularyExampleSeed(
      english: 'Keep the receipt in case you return the item.',
      urdu: 'چیز واپس کرنے کی صورت میں رسید اپنے پاس رکھیں۔',
      spanish: 'Guarda el recibo por si devuelves el artículo.',
      french: 'Gardez le reçu si vous devez rendre l’article.',
      german: 'Bewahren Sie den Kassenbon für eine Rückgabe auf.',
      japanese: '返品に備えてレシートを保管してください。',
      arabic: 'احتفظ بالإيصال إذا أردت إرجاع السلعة.',
    ),
    'Phone': _VocabularyExampleSeed(
      english: 'I use my phone to call my family.',
      urdu: 'میں اپنے خاندان کو فون کرنے کے لیے اپنا موبائل استعمال کرتا ہوں۔',
      spanish: 'Uso el teléfono para llamar a mi familia.',
      french: 'J’utilise le téléphone pour appeler ma famille.',
      german: 'Ich benutze das Telefon, um meine Familie anzurufen.',
      japanese: '家族に電話するために携帯電話を使います。',
      arabic: 'أستخدم الهاتف للاتصال بعائلتي.',
    ),
    'Internet': _VocabularyExampleSeed(
      english: 'I use the internet to study at home.',
      urdu: 'میں گھر پر پڑھائی کے لیے انٹرنیٹ استعمال کرتا ہوں۔',
      spanish: 'Uso internet para estudiar en casa.',
      french: 'J’utilise Internet pour étudier à la maison.',
      german: 'Ich nutze das Internet, um zu Hause zu lernen.',
      japanese: '家で勉強するためにインターネットを使います。',
      arabic: 'أستخدم الإنترنت للدراسة في المنزل.',
    ),
    'Message': _VocabularyExampleSeed(
      english: 'She sent a message to her friend.',
      urdu: 'اس نے اپنے دوست کو پیغام بھیجا۔',
      spanish: 'Ella envió un mensaje a su amiga.',
      french: 'Elle a envoyé un message à son amie.',
      german: 'Sie schickte ihrer Freundin eine Nachricht.',
      japanese: '彼女は友達にメッセージを送りました。',
      arabic: 'أرسلت رسالة إلى صديقتها.',
    ),
    'Photo': _VocabularyExampleSeed(
      english: 'We took a photo in front of the museum.',
      urdu: 'ہم نے عجائب گھر کے سامنے ایک تصویر کھینچی۔',
      spanish: 'Nos hicimos una foto delante del museo.',
      french: 'Nous avons pris une photo devant le musée.',
      german: 'Wir machten vor dem Museum ein Foto.',
      japanese: '博物館の前で写真を撮りました。',
      arabic: 'التقطنا صورة أمام المتحف.',
    ),
    'Password': _VocabularyExampleSeed(
      english: 'Choose a strong password for your account.',
      urdu: 'اپنے اکاؤنٹ کے لیے ایک مضبوط پاس ورڈ منتخب کریں۔',
      spanish: 'Elige una contraseña segura para tu cuenta.',
      french: 'Choisis un mot de passe solide pour ton compte.',
      german: 'Wähle ein sicheres Passwort für dein Konto.',
      japanese: 'アカウントには強力なパスワードを設定してください。',
      arabic: 'اختر كلمة مرور قوية لحسابك.',
    ),
    'Bread': _VocabularyExampleSeed(
      english: 'I eat bread with soup.',
      urdu: 'میں سوپ کے ساتھ روٹی کھاتا ہوں۔',
      spanish: 'Como pan con sopa.',
      french: 'Je mange du pain avec de la soupe.',
      german: 'Ich esse Brot zur Suppe.',
      japanese: 'スープと一緒にパンを食べます。',
      arabic: 'آكل الخبز مع الحساء.',
    ),
    'Rice': _VocabularyExampleSeed(
      english: 'We serve rice with dinner.',
      urdu: 'ہم رات کے کھانے کے ساتھ چاول پیش کرتے ہیں۔',
      spanish: 'Servimos arroz con la cena.',
      french: 'Nous servons du riz avec le dîner.',
      german: 'Zum Abendessen servieren wir Reis.',
      japanese: '夕食にご飯を出します。',
      arabic: 'نقدم الأرز مع العشاء.',
    ),
    'Milk': _VocabularyExampleSeed(
      english: 'She drinks a glass of milk before bed.',
      urdu: 'وہ سونے سے پہلے ایک گلاس دودھ پیتی ہے۔',
      spanish: 'Ella bebe un vaso de leche antes de dormir.',
      french: 'Elle boit un verre de lait avant de dormir.',
      german: 'Vor dem Schlafengehen trinkt sie ein Glas Milch.',
      japanese: '彼女は寝る前に牛乳を一杯飲みます。',
      arabic: 'تشرب كوبًا من الحليب قبل النوم.',
    ),
    'Tea': _VocabularyExampleSeed(
      english: 'He makes tea for his guests.',
      urdu: 'وہ اپنے مہمانوں کے لیے چائے بناتا ہے۔',
      spanish: 'Prepara té para sus invitados.',
      french: 'Il prépare du thé pour ses invités.',
      german: 'Er macht Tee für seine Gäste.',
      japanese: '彼はお客さんにお茶を入れます。',
      arabic: 'يعد الشاي لضيوفه.',
    ),
    'Coffee': _VocabularyExampleSeed(
      english: 'I drink coffee every morning.',
      urdu: 'میں ہر صبح کافی پیتا ہوں۔',
      spanish: 'Tomo café todas las mañanas.',
      french: 'Je bois du café tous les matins.',
      german: 'Jeden Morgen trinke ich Kaffee.',
      japanese: '毎朝コーヒーを飲みます。',
      arabic: 'أشرب القهوة كل صباح.',
    ),
    'Apple': _VocabularyExampleSeed(
      english: 'She packed an apple for lunch.',
      urdu: 'اس نے دوپہر کے کھانے کے لیے ایک سیب رکھا۔',
      spanish: 'Ella guardó una manzana para el almuerzo.',
      french: 'Elle a mis une pomme dans son déjeuner.',
      german: 'Sie packte einen Apfel für das Mittagessen ein.',
      japanese: '彼女は昼食にりんごを持っていきました。',
      arabic: 'وضعت تفاحة في وجبة غدائها.',
    ),
    'Banana': _VocabularyExampleSeed(
      english: 'He ate a banana after his walk.',
      urdu: 'اس نے چہل قدمی کے بعد ایک کیلا کھایا۔',
      spanish: 'Comió un plátano después de caminar.',
      french: 'Il a mangé une banane après sa promenade.',
      german: 'Nach seinem Spaziergang aß er eine Banane.',
      japanese: '散歩の後でバナナを食べました。',
      arabic: 'أكل موزة بعد المشي.',
    ),
    'Egg': _VocabularyExampleSeed(
      english: 'I boiled an egg for breakfast.',
      urdu: 'میں نے ناشتے کے لیے ایک انڈا ابالا۔',
      spanish: 'Herví un huevo para el desayuno.',
      french: 'J’ai fait cuire un œuf pour le petit-déjeuner.',
      german: 'Zum Frühstück habe ich ein Ei gekocht.',
      japanese: '朝食に卵をゆでました。',
      arabic: 'سَلَقْتُ بيضة للفطور.',
    ),
    'Cheese': _VocabularyExampleSeed(
      english: 'This sandwich has cheese and tomatoes.',
      urdu: 'اس سینڈوچ میں پنیر اور ٹماٹر ہیں۔',
      spanish: 'Este sándwich lleva queso y tomates.',
      french: 'Ce sandwich contient du fromage et des tomates.',
      german: 'Dieses Sandwich enthält Käse und Tomaten.',
      japanese: 'このサンドイッチにはチーズとトマトが入っています。',
      arabic: 'تحتوي هذه الشطيرة على الجبن والطماطم.',
    ),
    'Soup': _VocabularyExampleSeed(
      english: 'The soup is hot and ready to eat.',
      urdu: 'سوپ گرم ہے اور کھانے کے لیے تیار ہے۔',
      spanish: 'La sopa está caliente y lista para comer.',
      french: 'La soupe est chaude et prête à être mangée.',
      german: 'Die Suppe ist heiß und kann gegessen werden.',
      japanese: 'スープは熱くて、すぐに食べられます。',
      arabic: 'الحساء ساخن وجاهز للأكل.',
    ),
    'Vegetables': _VocabularyExampleSeed(
      english: 'We cook fresh vegetables for dinner.',
      urdu: 'ہم رات کے کھانے کے لیے تازہ سبزیاں پکاتے ہیں۔',
      spanish: 'Cocinamos verduras frescas para la cena.',
      french: 'Nous cuisinons des légumes frais pour le dîner.',
      german: 'Zum Abendessen kochen wir frisches Gemüse.',
      japanese: '夕食に新鮮な野菜を料理します。',
      arabic: 'نطهو خضروات طازجة للعشاء.',
    ),
    'Chicken': _VocabularyExampleSeed(
      english: 'They grilled chicken for lunch.',
      urdu: 'انہوں نے دوپہر کے کھانے کے لیے مرغی بھونی۔',
      spanish: 'Asaron pollo para el almuerzo.',
      french: 'Ils ont grillé du poulet pour le déjeuner.',
      german: 'Sie haben Hähnchen zum Mittagessen gegrillt.',
      japanese: '昼食に鶏肉を焼きました。',
      arabic: 'شووا الدجاج للغداء.',
    ),
    'Fish': _VocabularyExampleSeed(
      english: 'We ate fish by the sea.',
      urdu: 'ہم نے سمندر کے کنارے مچھلی کھائی۔',
      spanish: 'Comimos pescado junto al mar.',
      french: 'Nous avons mangé du poisson au bord de la mer.',
      german: 'Wir aßen Fisch am Meer.',
      japanese: '海辺で魚を食べました。',
      arabic: 'أكلنا السمك بجانب البحر.',
    ),
    'Office': _VocabularyExampleSeed(
      english: 'She works in an office near the station.',
      urdu: 'وہ اسٹیشن کے قریب ایک دفتر میں کام کرتی ہے۔',
      spanish: 'Ella trabaja en una oficina cerca de la estación.',
      french: 'Elle travaille dans un bureau près de la gare.',
      german: 'Sie arbeitet in einem Büro in der Nähe des Bahnhofs.',
      japanese: '彼女は駅の近くの事務所で働いています。',
      arabic: 'تعمل في مكتب بالقرب من المحطة.',
    ),
    'Meeting': _VocabularyExampleSeed(
      english: 'Our meeting starts at nine o’clock.',
      urdu: 'ہماری میٹنگ نو بجے شروع ہوتی ہے۔',
      spanish: 'Nuestra reunión empieza a las nueve.',
      french: 'Notre réunion commence à neuf heures.',
      german: 'Unser Treffen beginnt um neun Uhr.',
      japanese: '会議は九時に始まります。',
      arabic: 'يبدأ اجتماعنا في الساعة التاسعة.',
    ),
    'Computer': _VocabularyExampleSeed(
      english: 'I use my computer to study English.',
      urdu: 'میں انگریزی پڑھنے کے لیے اپنا کمپیوٹر استعمال کرتا ہوں۔',
      spanish: 'Uso el ordenador para estudiar inglés.',
      french: 'J’utilise mon ordinateur pour étudier l’anglais.',
      german: 'Ich benutze meinen Computer, um Englisch zu lernen.',
      japanese: '英語を勉強するためにコンピューターを使います。',
      arabic: 'أستخدم الحاسوب لدراسة الإنجليزية.',
    ),
    'Colleague': _VocabularyExampleSeed(
      english: 'My colleague helped me finish the report.',
      urdu: 'میرے ساتھی نے رپورٹ مکمل کرنے میں میری مدد کی۔',
      spanish: 'Mi compañero me ayudó a terminar el informe.',
      french: 'Mon collègue m’a aidé à terminer le rapport.',
      german: 'Mein Kollege half mir, den Bericht fertigzustellen.',
      japanese: '同僚が報告書を仕上げるのを手伝ってくれました。',
      arabic: 'ساعدني زميلي في إنهاء التقرير.',
    ),
    'Help': _VocabularyExampleSeed(
      english: 'Thank you for your help with my homework.',
      urdu: 'میرے گھر کے کام میں مدد کرنے کا شکریہ۔',
      spanish: 'Gracias por ayudarme con los deberes.',
      french: 'Merci de m’avoir aidé avec mes devoirs.',
      german: 'Danke für deine Hilfe bei meinen Hausaufgaben.',
      japanese: '宿題を手伝ってくれてありがとう。',
      arabic: 'شكرًا لمساعدتك في واجبي.',
    ),
    'Morning': _VocabularyExampleSeed(
      english: 'I wake up early in the morning.',
      urdu: 'میں صبح سویرے اٹھتا ہوں۔',
      spanish: 'Me despierto temprano por la mañana.',
      french: 'Je me réveille tôt le matin.',
      german: 'Ich wache morgens früh auf.',
      japanese: '朝早く起きます。',
      arabic: 'أستيقظ مبكرًا في الصباح.',
    ),
    'Doctor': _VocabularyExampleSeed(
      english: 'The doctor checked my temperature.',
      urdu: 'ڈاکٹر نے میرا درجہ حرارت چیک کیا۔',
      spanish: 'El médico me tomó la temperatura.',
      french: 'Le médecin a pris ma température.',
      german: 'Der Arzt maß meine Temperatur.',
      japanese: '医者は私の体温を測りました。',
      arabic: 'قاس الطبيب درجة حرارتي.',
    ),
    'Hospital': _VocabularyExampleSeed(
      english: 'The hospital is next to the pharmacy.',
      urdu: 'ہسپتال دواخانے کے ساتھ ہے۔',
      spanish: 'El hospital está junto a la farmacia.',
      french: 'L’hôpital se trouve à côté de la pharmacie.',
      german: 'Das Krankenhaus liegt neben der Apotheke.',
      japanese: '病院は薬局の隣にあります。',
      arabic: 'المستشفى بجانب الصيدلية.',
    ),
    'Medicine': _VocabularyExampleSeed(
      english: 'Take this medicine after your meal.',
      urdu: 'یہ دوا کھانے کے بعد لیں۔',
      spanish: 'Toma este medicamento después de comer.',
      french: 'Prends ce médicament après le repas.',
      german: 'Nimm dieses Medikament nach dem Essen.',
      japanese: '食後にこの薬を飲んでください。',
      arabic: 'تناول هذا الدواء بعد الطعام.',
    ),
    'Pain': _VocabularyExampleSeed(
      english: 'My arm hurts, so I have some pain.',
      urdu: 'میرا بازو دکھ رہا ہے، اس لیے مجھے درد ہے۔',
      spanish: 'Me duele el brazo y siento dolor.',
      french: 'J’ai mal au bras et je ressens une douleur.',
      german: 'Mein Arm tut weh und ich habe Schmerzen.',
      japanese: '腕が痛くて、痛みがあります。',
      arabic: 'ذراعي تؤلمني وأشعر بالألم.',
    ),
    'Drinking water': _VocabularyExampleSeed(
      english: 'Drinking water is important on a hot day.',
      urdu: 'گرم دن میں پینے کا پانی پینا ضروری ہے۔',
      spanish: 'Beber agua es importante en un día caluroso.',
      french: 'Boire de l’eau est important quand il fait chaud.',
      german: 'An einem heißen Tag ist es wichtig, Wasser zu trinken.',
      japanese: '暑い日は水を飲むことが大切です。',
      arabic: 'شرب الماء مهم في يوم حار.',
    ),
    'Tree': _VocabularyExampleSeed(
      english: 'The tree gives us shade in summer.',
      urdu: 'درخت گرمیوں میں ہمیں سایہ دیتا ہے۔',
      spanish: 'El árbol nos da sombra en verano.',
      french: 'L’arbre nous donne de l’ombre en été.',
      german: 'Der Baum spendet uns im Sommer Schatten.',
      japanese: '木は夏に日陰を作ってくれます。',
      arabic: 'تعطينا الشجرة ظلًا في الصيف.',
    ),
    'Flower': _VocabularyExampleSeed(
      english: 'This flower smells sweet.',
      urdu: 'اس پھول کی خوشبو میٹھی ہے۔',
      spanish: 'Esta flor huele muy bien.',
      french: 'Cette fleur sent bon.',
      german: 'Diese Blume duftet süß.',
      japanese: 'この花は甘い香りがします。',
      arabic: 'رائحة هذه الزهرة عطرة.',
    ),
    'Mountain': _VocabularyExampleSeed(
      english: 'We can see the mountain from our village.',
      urdu: 'ہم اپنے گاؤں سے پہاڑ دیکھ سکتے ہیں۔',
      spanish: 'Podemos ver la montaña desde nuestro pueblo.',
      french: 'Nous pouvons voir la montagne depuis notre village.',
      german: 'Von unserem Dorf aus können wir den Berg sehen.',
      japanese: '村から山が見えます。',
      arabic: 'يمكننا رؤية الجبل من قريتنا.',
    ),
    'River': _VocabularyExampleSeed(
      english: 'The river flows behind the village.',
      urdu: 'دریا گاؤں کے پیچھے بہتا ہے۔',
      spanish: 'El río pasa detrás del pueblo.',
      french: 'La rivière coule derrière le village.',
      german: 'Der Fluss fließt hinter dem Dorf.',
      japanese: '川は村の後ろを流れています。',
      arabic: 'يجري النهر خلف القرية.',
    ),
    'Sea': _VocabularyExampleSeed(
      english: 'The children swim in the sea in summer.',
      urdu: 'بچے گرمیوں میں سمندر میں تیراکی کرتے ہیں۔',
      spanish: 'Los niños nadan en el mar en verano.',
      french: 'Les enfants nagent dans la mer en été.',
      german: 'Im Sommer schwimmen die Kinder im Meer.',
      japanese: '夏に子どもたちは海で泳ぎます。',
      arabic: 'يسبح الأطفال في البحر في الصيف.',
    ),
    'Forest': _VocabularyExampleSeed(
      english: 'We walked through the forest in the morning.',
      urdu: 'ہم صبح جنگل میں سے گزرے۔',
      spanish: 'Caminamos por el bosque por la mañana.',
      french: 'Nous avons marché dans la forêt le matin.',
      german: 'Am Morgen gingen wir durch den Wald.',
      japanese: '朝、森の中を歩きました。',
      arabic: 'مشينا في الغابة صباحًا.',
    ),
  };

  static const Map<String, _VocabularyExampleSeed> _verbExamples = {
    'To read': _VocabularyExampleSeed(
      english: 'I read a book every evening.',
      urdu: 'میں ہر شام ایک کتاب پڑھتا ہوں۔',
      spanish: 'Leo un libro cada tarde.',
      french: 'Je lis un livre chaque soir.',
      german: 'Ich lese jeden Abend ein Buch.',
      japanese: '毎晩、本を読みます。',
      arabic: 'أقرأ كتابًا كل مساء.',
    ),
    'To write': _VocabularyExampleSeed(
      english: 'She writes a note to her friend.',
      urdu: 'وہ اپنے دوست کو ایک نوٹ لکھتی ہے۔',
      spanish: 'Ella escribe una nota a su amiga.',
      french: 'Elle écrit un mot à son amie.',
      german: 'Sie schreibt ihrer Freundin eine Notiz.',
      japanese: '彼女は友達にメモを書きます。',
      arabic: 'تكتب ملاحظة لصديقتها.',
    ),
    'To work': _VocabularyExampleSeed(
      english: 'My father works in an office.',
      urdu: 'میرے والد ایک دفتر میں کام کرتے ہیں۔',
      spanish: 'Mi padre trabaja en una oficina.',
      french: 'Mon père travaille dans un bureau.',
      german: 'Mein Vater arbeitet in einem Büro.',
      japanese: '父は事務所で働いています。',
      arabic: 'يعمل أبي في مكتب.',
    ),
    'To eat': _VocabularyExampleSeed(
      english: 'We eat dinner together at home.',
      urdu: 'ہم گھر پر مل کر رات کا کھانا کھاتے ہیں۔',
      spanish: 'Cenamos juntos en casa.',
      french: 'Nous dînons ensemble à la maison.',
      german: 'Wir essen zu Hause gemeinsam zu Abend.',
      japanese: '家で一緒に夕食を食べます。',
      arabic: 'نتناول العشاء معًا في المنزل.',
    ),
    'To drink': _VocabularyExampleSeed(
      english: 'I drink a glass of water after walking.',
      urdu: 'میں چلنے کے بعد ایک گلاس پانی پیتا ہوں۔',
      spanish: 'Bebo un vaso de agua después de caminar.',
      french: 'Je bois un verre d’eau après avoir marché.',
      german: 'Nach dem Spaziergang trinke ich ein Glas Wasser.',
      japanese: '歩いた後で水を一杯飲みます。',
      arabic: 'أشرب كوبًا من الماء بعد المشي.',
    ),
    'To sleep': _VocabularyExampleSeed(
      english: 'The baby sleeps for eight hours.',
      urdu: 'بچہ آٹھ گھنٹے سوتا ہے۔',
      spanish: 'El bebé duerme ocho horas.',
      french: 'Le bébé dort huit heures.',
      german: 'Das Baby schläft acht Stunden.',
      japanese: '赤ちゃんは八時間眠ります。',
      arabic: 'ينام الطفل ثماني ساعات.',
    ),
    'To walk': _VocabularyExampleSeed(
      english: 'We walk to school every morning.',
      urdu: 'ہم ہر صبح پیدل اسکول جاتے ہیں۔',
      spanish: 'Caminamos a la escuela cada mañana.',
      french: 'Nous allons à l’école à pied chaque matin.',
      german: 'Wir gehen jeden Morgen zu Fuß zur Schule.',
      japanese: '毎朝歩いて学校へ行きます。',
      arabic: 'نمشي إلى المدرسة كل صباح.',
    ),
    'To open': _VocabularyExampleSeed(
      english: 'Please open your book to page five.',
      urdu: 'براہ کرم اپنی کتاب کا پانچواں صفحہ کھولیں۔',
      spanish: 'Abre el libro por la página cinco, por favor.',
      french: 'Ouvre ton livre à la page cinq, s’il te plaît.',
      german: 'Öffne dein Buch bitte auf Seite fünf.',
      japanese: '本を開いて五ページを見てください。',
      arabic: 'افتح كتابك على الصفحة الخامسة من فضلك.',
    ),
    'To close': _VocabularyExampleSeed(
      english: 'The shop closes at nine tonight.',
      urdu: 'دکان آج رات نو بجے بند ہوتی ہے۔',
      spanish: 'La tienda cierra a las nueve esta noche.',
      french: 'Le magasin ferme à neuf heures ce soir.',
      german: 'Das Geschäft schließt heute Abend um neun.',
      japanese: '店は今夜九時に閉まります。',
      arabic: 'يغلق المتجر في الساعة التاسعة الليلة.',
    ),
    'To rest': _VocabularyExampleSeed(
      english: 'You should rest after a long day.',
      urdu: 'ایک طویل دن کے بعد آپ کو آرام کرنا چاہیے۔',
      spanish: 'Debes descansar después de un día largo.',
      french: 'Tu devrais te reposer après une longue journée.',
      german: 'Nach einem langen Tag solltest du dich ausruhen.',
      japanese: '長い一日の後は休んだほうがいいです。',
      arabic: 'ينبغي أن تستريح بعد يوم طويل.',
    ),
    'To search': _VocabularyExampleSeed(
      english: 'I search the internet for a train time.',
      urdu: 'میں ٹرین کے وقت کے لیے انٹرنیٹ پر تلاش کرتا ہوں۔',
      spanish: 'Busco en internet el horario del tren.',
      french: 'Je cherche l’horaire du train sur Internet.',
      german: 'Ich suche im Internet nach der Zugzeit.',
      japanese: '電車の時間をインターネットで調べます。',
      arabic: 'أبحث عن موعد القطار على الإنترنت.',
    ),
    'To send': _VocabularyExampleSeed(
      english: 'She sends a message to her brother.',
      urdu: 'وہ اپنے بھائی کو پیغام بھیجتی ہے۔',
      spanish: 'Ella envía un mensaje a su hermano.',
      french: 'Elle envoie un message à son frère.',
      german: 'Sie schickt ihrem Bruder eine Nachricht.',
      japanese: '彼女は兄にメッセージを送ります。',
      arabic: 'ترسل رسالة إلى أخيها.',
    ),
  };

  static const Map<String, _VocabularyExampleSeed> _adjectiveExamples = {
    'Near': _VocabularyExampleSeed(
      english: 'The station is near my home.',
      urdu: 'اسٹیشن میرے گھر کے قریب ہے۔',
      spanish: 'La estación está cerca de mi casa.',
      french: 'La gare est près de chez moi.',
      german: 'Der Bahnhof ist in der Nähe meines Hauses.',
      japanese: '駅は私の家の近くにあります。',
      arabic: 'المحطة قريبة من منزلي.',
    ),
    'Far': _VocabularyExampleSeed(
      english: 'The airport is far from the city.',
      urdu: 'ہوائی اڈہ شہر سے دور ہے۔',
      spanish: 'El aeropuerto está lejos de la ciudad.',
      french: 'L’aéroport est loin de la ville.',
      german: 'Der Flughafen ist weit von der Stadt entfernt.',
      japanese: '空港は町から遠いです。',
      arabic: 'المطار بعيد عن المدينة.',
    ),
    'Hot': _VocabularyExampleSeed(
      english: 'The tea is hot, so be careful.',
      urdu: 'چائے گرم ہے، اس لیے احتیاط کریں۔',
      spanish: 'El té está caliente, así que ten cuidado.',
      french: 'Le thé est chaud, alors fais attention.',
      german: 'Der Tee ist heiß, also sei vorsichtig.',
      japanese: 'お茶が熱いので、気をつけてください。',
      arabic: 'الشاي ساخن، لذا كن حذرًا.',
    ),
    'Cold': _VocabularyExampleSeed(
      english: 'The water is cold today.',
      urdu: 'آج پانی ٹھنڈا ہے۔',
      spanish: 'El agua está fría hoy.',
      french: 'L’eau est froide aujourd’hui.',
      german: 'Das Wasser ist heute kalt.',
      japanese: '今日は水が冷たいです。',
      arabic: 'الماء بارد اليوم.',
    ),
    'Cheap': _VocabularyExampleSeed(
      english: 'This shirt is cheap but comfortable.',
      urdu: 'یہ قمیص سستی مگر آرام دہ ہے۔',
      spanish: 'Esta camisa es barata pero cómoda.',
      french: 'Cette chemise est bon marché mais confortable.',
      german: 'Dieses Hemd ist günstig, aber bequem.',
      japanese: 'このシャツは安いですが、着心地がいいです。',
      arabic: 'هذا القميص رخيص لكنه مريح.',
    ),
    'Expensive': _VocabularyExampleSeed(
      english: 'That computer is too expensive for me.',
      urdu: 'وہ کمپیوٹر میرے لیے بہت مہنگا ہے۔',
      spanish: 'Ese ordenador es demasiado caro para mí.',
      french: 'Cet ordinateur est trop cher pour moi.',
      german: 'Dieser Computer ist mir zu teuer.',
      japanese: 'そのコンピューターは私には高すぎます。',
      arabic: 'ذلك الحاسوب غالٍ جدًا بالنسبة إلي.',
    ),
    'Busy': _VocabularyExampleSeed(
      english: 'I am busy at the office this morning.',
      urdu: 'میں آج صبح دفتر میں مصروف ہوں۔',
      spanish: 'Estoy ocupado en la oficina esta mañana.',
      french: 'Je suis occupé au bureau ce matin.',
      german: 'Ich bin heute Morgen im Büro beschäftigt.',
      japanese: '今朝は事務所で忙しいです。',
      arabic: 'أنا مشغول في المكتب هذا الصباح.',
    ),
    'Healthy': _VocabularyExampleSeed(
      english: 'Walking every day helps you stay healthy.',
      urdu: 'روزانہ پیدل چلنا صحت مند رہنے میں مدد دیتا ہے۔',
      spanish: 'Caminar cada día ayuda a mantenerse sano.',
      french: 'Marcher chaque jour aide à rester en bonne santé.',
      german: 'Tägliches Gehen hilft, gesund zu bleiben.',
      japanese: '毎日歩くと健康を保つのに役立ちます。',
      arabic: 'يساعد المشي يوميًا على البقاء بصحة جيدة.',
    ),
  };

  static String _partOfSpeech(
    String partOfSpeech,
    String languageCode,
    String word,
  ) {
    if (partOfSpeech != 'noun') return partOfSpeech;

    final gender = switch (languageCode) {
      'es' => word == 'el agua potable'
          ? 'f'
          : word.startsWith('el ') || word.startsWith('los ')
              ? 'm'
              : word.startsWith('la ') || word.startsWith('las ')
                  ? 'f'
                  : word == 'internet'
                      ? 'm'
                      : null,
      'fr' => word.startsWith('le ')
          ? 'm'
          : word.startsWith('la ')
              ? 'f'
              : word.startsWith("l'eau") || word == "l'école"
                  ? 'f'
                  : word == "l'ami" ||
                          word == "l'aéroport" ||
                          word == "l'arbre" ||
                          word == "l'argent" ||
                          word == "l'ordinateur" ||
                          word == "l'œuf" ||
                          word == "l'oiseau" ||
                          word == "l'éléphant" ||
                          word == "l'hôtel" ||
                          word == "l'étudiant" ||
                          word == "l'hôpital"
                      ? 'm'
                      : null,
      'de' => word.startsWith('der ')
          ? 'm'
          : word.startsWith('die ')
              ? 'f'
              : word.startsWith('das ')
                  ? 'n'
                  : null,
      'ar' => word.endsWith('ة') ||
              const {'أم', 'أخت', 'شمس', 'ريح', 'خضروات', 'مياه الشرب'}
                  .contains(word)
          ? 'f'
          : 'm',
      _ => null,
    };

    return gender == null ? partOfSpeech : '$partOfSpeech, $gender';
  }
}

class _VocabularyExample {
  final String targetSentence;
  final String englishTranslation;
  final String urduTranslation;

  const _VocabularyExample({
    required this.targetSentence,
    required this.englishTranslation,
    required this.urduTranslation,
  });
}

class _VocabularyExampleSeed {
  final String english;
  final String urdu;
  final String spanish;
  final String french;
  final String german;
  final String japanese;
  final String arabic;

  const _VocabularyExampleSeed({
    required this.english,
    required this.urdu,
    required this.spanish,
    required this.french,
    required this.german,
    required this.japanese,
    required this.arabic,
  });

  String target(String languageCode) => switch (languageCode) {
        'es' => spanish,
        'fr' => french,
        'de' => german,
        'ja' => japanese,
        'ar' => arabic,
        'en' => english,
        _ => throw ArgumentError.value(languageCode, 'languageCode'),
      };
}
