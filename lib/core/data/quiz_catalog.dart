import '../../models/quiz_model.dart';
import 'app_mock_data.dart';

class QuizCatalog {
  QuizCatalog._();

  static List<QuizModel> forLanguage(String languageCode) {
    return switch (languageCode) {
      'en' => englishQuizzes,
      'es' => AppMockData.allQuizzes,
      'fr' => frenchQuizzes,
      'de' => germanQuizzes,
      'ja' => japaneseQuizzes,
      'ar' => arabicQuizzes,
      _ => const [],
    };
  }

  static const List<QuizModel> englishQuizzes = [
    QuizModel(
      id: 'quiz_es_1',
      title: 'Breakfast, Café & Greetings',
      description:
          'Practice everyday greetings, breakfast vocabulary, and polite café requests.',
      questions: [
        QuizQuestionModel(
          id: 'q1',
          questionText: 'Which word names the first meal of the day?',
          options: ['Breakfast', 'Dinner', 'Lunch', 'Snack'],
          correctIndex: 0,
          explanation:
              'Breakfast is the first meal of the day, usually eaten in the morning.',
        ),
        QuizQuestionModel(
          id: 'q2',
          questionText: 'Which expression makes a request polite?',
          options: [
            'You are welcome',
            'Please',
            'Thank you',
            'Excuse me',
          ],
          correctIndex: 1,
          explanation: 'Please is used to make a request sound polite.',
        ),
        QuizQuestionModel(
          id: 'q3',
          questionText: 'Which greeting is commonly used in the morning?',
          options: [
            'Good afternoon',
            'Good night',
            'Good morning',
            'See you later',
          ],
          correctIndex: 2,
          explanation:
              'Good morning is the usual greeting when meeting someone in the morning.',
        ),
        QuizQuestionModel(
          id: 'q4',
          questionText:
              'What would you say to ask for the bill at a restaurant?',
          options: [
            'Where is the restroom?',
            'The bill, please.',
            'Nice to meet you.',
            'A ticket, please.',
          ],
          correctIndex: 1,
          explanation:
              'The bill, please is a polite way to ask for the check after a meal.',
        ),
        QuizQuestionModel(
          id: 'q5',
          questionText: 'What does the word “water” refer to?',
          options: ['Coffee', 'Milk', 'Bread', 'Water'],
          correctIndex: 3,
          explanation:
              'Water is the clear drink often ordered at a café or restaurant.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_2',
      title: 'Introductions & Everyday Conversation',
      description:
          'Practice polite introductions, asking about prices, and expressing thanks.',
      questions: [
        QuizQuestionModel(
          id: 'q2_1',
          questionText:
              'What is a polite reply when someone says, “Nice to meet you”?',
          options: [
            'Please',
            'Nice to meet you too.',
            'I do not understand.',
            'Good night',
          ],
          correctIndex: 1,
          explanation:
              'Nice to meet you too is a friendly response when you are introduced to someone.',
        ),
        QuizQuestionModel(
          id: 'q2_2',
          questionText: 'How do you ask about the price of an item?',
          options: [
            'What time is it?',
            'What is your name?',
            'How much does it cost?',
            'Where are you from?',
          ],
          correctIndex: 2,
          explanation:
              'How much does it cost? is a common question about a price.',
        ),
        QuizQuestionModel(
          id: 'q2_3',
          questionText: 'Which expression shows that you are very grateful?',
          options: [
            'Of course',
            'Thank you very much',
            'I am sorry',
            'See you soon',
          ],
          correctIndex: 1,
          explanation: 'Thank you very much expresses strong appreciation.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_3',
      title: 'Travel, Numbers & Directions',
      description:
          'Practice asking for directions, counting, and essential travel words.',
      questions: [
        QuizQuestionModel(
          id: 'q3_1',
          questionText: 'Which question asks where the subway station is?',
          options: [
            'When does the train arrive?',
            'Where is the subway station?',
            'How much is a bus ticket?',
            'Is the hotel open today?',
          ],
          correctIndex: 1,
          explanation:
              'Where is the subway station? asks someone to tell you the station’s location.',
        ),
        QuizQuestionModel(
          id: 'q3_2',
          questionText: 'Which sequence means “1, 2, 3”?',
          options: [
            'Ten, twenty, thirty',
            'One, two, three',
            'First, second, third',
            'Four, five, six',
          ],
          correctIndex: 1,
          explanation:
              'One, two, three is the sequence for the numbers 1, 2, and 3.',
        ),
        QuizQuestionModel(
          id: 'q3_3',
          questionText: 'What is a ticket used for when traveling?',
          options: ['A ticket', 'Luggage', 'An airplane', 'A passport'],
          correctIndex: 0,
          explanation:
              'A ticket gives you permission to travel on a train, bus, or other service.',
        ),
      ],
    ),
  ];

  static const List<QuizModel> frenchQuizzes = [
    QuizModel(
      id: 'quiz_es_1',
      title: 'Petit-déjeuner, café et salutations',
      description:
          'Révisez les salutations courantes, le petit-déjeuner et les demandes polies au café.',
      questions: [
        QuizQuestionModel(
          id: 'q1',
          questionText: 'Quel mot désigne le premier repas de la journée ?',
          options: [
            'Le petit-déjeuner',
            'Le dîner',
            'Le déjeuner',
            'Le goûter'
          ],
          correctIndex: 0,
          explanation:
              'Le petit-déjeuner est le premier repas de la journée, généralement pris le matin.',
        ),
        QuizQuestionModel(
          id: 'q2',
          questionText: 'Quelle expression rend une demande plus polie ?',
          options: [
            'De rien',
            'S’il vous plaît',
            'Merci',
            'Excusez-moi',
          ],
          correctIndex: 1,
          explanation:
              'On ajoute « s’il vous plaît » pour formuler une demande poliment.',
        ),
        QuizQuestionModel(
          id: 'q3',
          questionText:
              'Quelle salutation utilise-t-on généralement le matin ?',
          options: ['Bonsoir', 'Bonne nuit', 'Bonjour', 'À plus tard'],
          correctIndex: 2,
          explanation:
              '« Bonjour » est la salutation habituelle lorsqu’on rencontre quelqu’un le matin.',
        ),
        QuizQuestionModel(
          id: 'q4',
          questionText: 'Au restaurant, que dit-on pour demander l’addition ?',
          options: [
            'Où sont les toilettes ?',
            'L’addition, s’il vous plaît.',
            'Ravi(e) de vous rencontrer.',
            'Un billet, s’il vous plaît.',
          ],
          correctIndex: 1,
          explanation:
              '« L’addition, s’il vous plaît » est une formule polie pour demander à payer.',
        ),
        QuizQuestionModel(
          id: 'q5',
          questionText: 'Quelle boisson correspond au mot « eau » ?',
          options: ['Le café', 'Le lait', 'Le pain', 'L’eau'],
          correctIndex: 3,
          explanation:
              '« L’eau » est la boisson que l’on peut commander dans un café ou un restaurant.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_2',
      title: 'Présentations et conversations courantes',
      description:
          'Entraînez-vous aux présentations polies, aux questions sur les prix et aux remerciements.',
      questions: [
        QuizQuestionModel(
          id: 'q2_1',
          questionText: 'Que peut-on répondre poliment après « Enchanté(e) » ?',
          options: [
            'S’il vous plaît',
            'Enchanté(e), moi aussi.',
            'Je ne comprends pas',
            'Bonne nuit',
          ],
          correctIndex: 1,
          explanation:
              '« Enchanté(e), moi aussi » répond poliment à une présentation.',
        ),
        QuizQuestionModel(
          id: 'q2_2',
          questionText: 'Comment demander le prix d’un article ?',
          options: [
            'À quelle heure est-il ?',
            'Comment t’appelles-tu ?',
            'Combien ça coûte ?',
            'D’où viens-tu ?',
          ],
          correctIndex: 2,
          explanation:
              '« Combien ça coûte ? » est une question courante pour connaître un prix.',
        ),
        QuizQuestionModel(
          id: 'q2_3',
          questionText:
              'Quelle expression permet de remercier quelqu’un chaleureusement ?',
          options: [
            'Bien sûr',
            'Merci beaucoup',
            'Je suis désolé(e)',
            'À bientôt',
          ],
          correctIndex: 1,
          explanation: '« Merci beaucoup » exprime une grande reconnaissance.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_3',
      title: 'Voyage, nombres et directions',
      description:
          'Entraînez-vous à demander votre chemin, à compter et à utiliser le vocabulaire du voyage.',
      questions: [
        QuizQuestionModel(
          id: 'q3_1',
          questionText:
              'Quelle question permet de demander où se trouve la station de métro ?',
          options: [
            'Quand le train arrive-t-il ?',
            'Où est la station de métro ?',
            'Combien coûte un billet de bus ?',
            'L’hôtel est-il ouvert aujourd’hui ?',
          ],
          correctIndex: 1,
          explanation:
              '« Où est la station de métro ? » sert à demander l’emplacement de la station.',
        ),
        QuizQuestionModel(
          id: 'q3_2',
          questionText: 'Quelle suite correspond à « 1, 2, 3 » ?',
          options: [
            'Dix, vingt, trente',
            'Un, deux, trois',
            'Premier, deuxième, troisième',
            'Quatre, cinq, six',
          ],
          correctIndex: 1,
          explanation: '« Un, deux, trois » correspond aux nombres 1, 2 et 3.',
        ),
        QuizQuestionModel(
          id: 'q3_3',
          questionText: 'À quoi sert un billet pendant un voyage ?',
          options: ['Un billet', 'Des bagages', 'Un avion', 'Un passeport'],
          correctIndex: 0,
          explanation:
              'Un billet permet de voyager en train, en bus ou avec un autre moyen de transport.',
        ),
      ],
    ),
  ];

  static const List<QuizModel> germanQuizzes = [
    QuizModel(
      id: 'quiz_es_1',
      title: 'Frühstück, Café und Begrüßungen',
      description:
          'Übe alltägliche Begrüßungen, Wörter rund ums Frühstück und höfliche Bitten im Café.',
      questions: [
        QuizQuestionModel(
          id: 'q1',
          questionText: 'Welches Wort bezeichnet die erste Mahlzeit des Tages?',
          options: ['Frühstück', 'Abendessen', 'Mittagessen', 'Imbiss'],
          correctIndex: 0,
          explanation:
              'Das Frühstück ist die erste Mahlzeit des Tages und wird normalerweise morgens gegessen.',
        ),
        QuizQuestionModel(
          id: 'q2',
          questionText: 'Welche Formulierung macht eine Bitte höflich?',
          options: [
            'Gern geschehen',
            'Bitte',
            'Vielen Dank',
            'Entschuldigung',
          ],
          correctIndex: 1,
          explanation: 'Mit „Bitte“ klingt eine Bitte höflich.',
        ),
        QuizQuestionModel(
          id: 'q3',
          questionText:
              'Welche Begrüßung verwendet man normalerweise am Morgen?',
          options: [
            'Guten Tag',
            'Gute Nacht',
            'Guten Morgen',
            'Bis später',
          ],
          correctIndex: 2,
          explanation: '„Guten Morgen“ ist die übliche Begrüßung am Morgen.',
        ),
        QuizQuestionModel(
          id: 'q4',
          questionText: 'Was sagt man im Restaurant, wenn man bezahlen möchte?',
          options: [
            'Wo ist die Toilette?',
            'Die Rechnung, bitte.',
            'Freut mich, dich kennenzulernen.',
            'Eine Fahrkarte, bitte.',
          ],
          correctIndex: 1,
          explanation:
              '„Die Rechnung, bitte“ ist eine höfliche Bitte um die Rechnung.',
        ),
        QuizQuestionModel(
          id: 'q5',
          questionText: 'Welches Wort bezeichnet das Getränk Wasser?',
          options: ['Kaffee', 'Milch', 'Brot', 'Wasser'],
          correctIndex: 3,
          explanation:
              'Wasser ist ein Getränk, das man im Café oder Restaurant bestellen kann.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_2',
      title: 'Vorstellungen und Gespräche im Alltag',
      description:
          'Übe höfliche Vorstellungen, Fragen nach Preisen und passende Dankesformeln.',
      questions: [
        QuizQuestionModel(
          id: 'q2_1',
          questionText:
              'Was kann man höflich auf „Freut mich, dich kennenzulernen“ antworten?',
          options: [
            'Bitte',
            'Mich auch, freut mich.',
            'Ich verstehe nicht',
            'Gute Nacht',
          ],
          correctIndex: 1,
          explanation:
              '„Mich auch, freut mich“ ist eine freundliche Antwort bei einer Vorstellung.',
        ),
        QuizQuestionModel(
          id: 'q2_2',
          questionText: 'Wie fragt man nach dem Preis eines Artikels?',
          options: [
            'Wie spät ist es?',
            'Wie heißt du?',
            'Wie viel kostet das?',
            'Woher kommst du?',
          ],
          correctIndex: 2,
          explanation:
              '„Wie viel kostet das?“ ist eine übliche Frage nach einem Preis.',
        ),
        QuizQuestionModel(
          id: 'q2_3',
          questionText: 'Welche Formulierung drückt großen Dank aus?',
          options: [
            'Natürlich',
            'Vielen Dank',
            'Es tut mir leid',
            'Bis bald',
          ],
          correctIndex: 1,
          explanation: '„Vielen Dank“ drückt große Dankbarkeit aus.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_3',
      title: 'Reisen, Zahlen und Wegbeschreibungen',
      description:
          'Übe Fragen nach dem Weg, das Zählen und wichtigen Wortschatz für unterwegs.',
      questions: [
        QuizQuestionModel(
          id: 'q3_1',
          questionText:
              'Mit welcher Frage erkundigt man sich nach dem U-Bahnhof?',
          options: [
            'Wann kommt der Zug an?',
            'Wo ist der U-Bahnhof?',
            'Wie viel kostet eine Busfahrkarte?',
            'Ist das Hotel heute geöffnet?',
          ],
          correctIndex: 1,
          explanation:
              '„Wo ist der U-Bahnhof?“ fragt nach dem Standort des Bahnhofs.',
        ),
        QuizQuestionModel(
          id: 'q3_2',
          questionText: 'Welche Zahlenfolge bedeutet „1, 2, 3“?',
          options: [
            'Zehn, zwanzig, dreißig',
            'Eins, zwei, drei',
            'Erstens, zweitens, drittens',
            'Vier, fünf, sechs',
          ],
          correctIndex: 1,
          explanation: '„Eins, zwei, drei“ ist die Zahlenfolge für 1, 2 und 3.',
        ),
        QuizQuestionModel(
          id: 'q3_3',
          questionText: 'Wofür braucht man beim Reisen eine Fahrkarte?',
          options: ['Eine Fahrkarte', 'Gepäck', 'Ein Flugzeug', 'Einen Pass'],
          correctIndex: 0,
          explanation:
              'Mit einer Fahrkarte darf man zum Beispiel mit dem Zug oder Bus fahren.',
        ),
      ],
    ),
  ];

  static const List<QuizModel> japaneseQuizzes = [
    QuizModel(
      id: 'quiz_es_1',
      title: '朝食・カフェ・あいさつ',
      description: '日常のあいさつ、朝食の語彙、カフェでの丁寧な頼み方を練習します。',
      questions: [
        QuizQuestionModel(
          id: 'q1',
          questionText: '一日の最初の食事を表す言葉はどれですか。',
          options: ['朝食', '夕食', '昼食', 'おやつ'],
          correctIndex: 0,
          explanation: '朝食は、一日の最初にとる食事です。',
        ),
        QuizQuestionModel(
          id: 'q2',
          questionText: '丁寧にお願いするときに使う表現はどれですか。',
          options: ['どういたしまして', 'お願いします', 'ありがとうございます', '失礼します'],
          correctIndex: 1,
          explanation: '「お願いします」は、相手に丁寧に依頼するときに使う表現です。',
        ),
        QuizQuestionModel(
          id: 'q3',
          questionText: '朝に人に会ったときのあいさつはどれですか。',
          options: ['こんにちは', 'こんばんは', 'おはようございます', 'また後で'],
          correctIndex: 2,
          explanation: '「おはようございます」は、朝に使う丁寧なあいさつです。',
        ),
        QuizQuestionModel(
          id: 'q4',
          questionText: 'レストランで会計をお願いするとき、自然な表現はどれですか。',
          options: [
            'トイレはどこですか。',
            'お会計をお願いします。',
            'はじめまして。',
            '切符を一枚お願いします。',
          ],
          correctIndex: 1,
          explanation: '「お会計をお願いします」は、支払いをしたいときの丁寧な表現です。',
        ),
        QuizQuestionModel(
          id: 'q5',
          questionText: '飲み物の「水」を表す言葉はどれですか。',
          options: ['コーヒー', '牛乳', 'パン', '水'],
          correctIndex: 3,
          explanation: '水は、カフェやレストランで注文できる飲み物です。',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_2',
      title: '自己紹介と日常会話',
      description: '丁寧な自己紹介、値段の尋ね方、お礼の表現を練習します。',
      questions: [
        QuizQuestionModel(
          id: 'q2_1',
          questionText: '「はじめまして」と言われたとき、自然な返事はどれですか。',
          options: ['お願いします', 'こちらこそ、よろしくお願いします', 'わかりません', 'こんばんは'],
          correctIndex: 1,
          explanation: '「こちらこそ、よろしくお願いします」は、初対面のあいさつへの自然な返事です。',
        ),
        QuizQuestionModel(
          id: 'q2_2',
          questionText: '商品の値段を尋ねる表現はどれですか。',
          options: ['何時ですか。', 'お名前は何ですか。', 'いくらですか。', 'どちらのご出身ですか。'],
          correctIndex: 2,
          explanation: '「いくらですか」は、商品の値段を尋ねるときに使います。',
        ),
        QuizQuestionModel(
          id: 'q2_3',
          questionText: 'とても感謝していることを伝える表現はどれですか。',
          options: ['もちろんです', 'どうもありがとうございます', 'すみません', 'また近いうちに'],
          correctIndex: 1,
          explanation: '「どうもありがとうございます」は、深い感謝を伝える表現です。',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_3',
      title: '旅行・数字・道案内',
      description: '道を尋ねる表現、数の数え方、旅行に役立つ語彙を練習します。',
      questions: [
        QuizQuestionModel(
          id: 'q3_1',
          questionText: '地下鉄の駅の場所を尋ねる表現はどれですか。',
          options: [
            '電車は何時に着きますか。',
            '地下鉄の駅はどこですか。',
            'バスの切符はいくらですか。',
            'ホテルは今日営業していますか。',
          ],
          correctIndex: 1,
          explanation: '「地下鉄の駅はどこですか」は、駅の場所を尋ねる質問です。',
        ),
        QuizQuestionModel(
          id: 'q3_2',
          questionText: '「1、2、3」に当たる日本語の数え方はどれですか。',
          options: ['十、二十、三十', '一、二、三', '一番、二番、三番', '四、五、六'],
          correctIndex: 1,
          explanation: '「一、二、三」は、数字の1、2、3を表します。',
        ),
        QuizQuestionModel(
          id: 'q3_3',
          questionText: '旅行で使う乗車券を表す言葉はどれですか。',
          options: ['切符', '荷物', '飛行機', '旅券'],
          correctIndex: 0,
          explanation: '切符があれば、電車やバスなどに乗ることができます。',
        ),
      ],
    ),
  ];

  static const List<QuizModel> arabicQuizzes = [
    QuizModel(
      id: 'quiz_es_1',
      title: 'الإفطار والمقهى والتحيات',
      description:
          'تدرّب على التحيات اليومية ومفردات الإفطار والطلبات المهذبة في المقهى.',
      questions: [
        QuizQuestionModel(
          id: 'q1',
          questionText: 'ما الكلمة التي تدل على أول وجبة في اليوم؟',
          options: ['الفطور', 'العشاء', 'الغداء', 'وجبة خفيفة'],
          correctIndex: 0,
          explanation: 'الفطور هو أول وجبة يتناولها الشخص عادةً في الصباح.',
        ),
        QuizQuestionModel(
          id: 'q2',
          questionText: 'أي تعبير يُستخدم لجعل الطلب مهذباً؟',
          options: ['عفواً', 'من فضلك', 'شكراً جزيلاً', 'إلى اللقاء'],
          correctIndex: 1,
          explanation: 'يُستخدم تعبير «من فضلك» عند تقديم طلب بطريقة مهذبة.',
        ),
        QuizQuestionModel(
          id: 'q3',
          questionText: 'ما التحية المناسبة في الصباح؟',
          options: ['مساء الخير', 'تصبح على خير', 'صباح الخير', 'إلى اللقاء'],
          correctIndex: 2,
          explanation: 'تُقال «صباح الخير» عند تحية شخص في الصباح.',
        ),
        QuizQuestionModel(
          id: 'q4',
          questionText: 'ماذا تقول في المطعم لطلب الفاتورة؟',
          options: [
            'أين دورة المياه؟',
            'الفاتورة من فضلك.',
            'تشرفت بلقائك.',
            'تذكرة من فضلك.',
          ],
          correctIndex: 1,
          explanation: '«الفاتورة من فضلك» طلب مهذب لإحضار حساب الطعام.',
        ),
        QuizQuestionModel(
          id: 'q5',
          questionText: 'ما معنى كلمة «الماء»؟',
          options: ['القهوة', 'الحليب', 'الخبز', 'الماء'],
          correctIndex: 3,
          explanation: 'الماء مشروب يمكن طلبه في المقهى أو المطعم.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_2',
      title: 'التعارف والمحادثات اليومية',
      description:
          'تدرّب على التعارف بأدب والسؤال عن الأسعار والتعبير عن الشكر.',
      questions: [
        QuizQuestionModel(
          id: 'q2_1',
          questionText:
              'ما الرد المهذب المناسب بعد أن يقول لك شخص «تشرفت بلقائك»؟',
          options: [
            'من فضلك',
            'وأنا أيضاً تشرفت بلقائك',
            'لا أفهم',
            'تصبح على خير'
          ],
          correctIndex: 1,
          explanation: '«وأنا أيضاً تشرفت بلقائك» رد لطيف ومناسب عند التعارف.',
        ),
        QuizQuestionModel(
          id: 'q2_2',
          questionText: 'كيف تسأل عن ثمن سلعة؟',
          options: ['كم الساعة؟', 'ما اسمك؟', 'كم ثمن هذا؟', 'من أين أنت؟'],
          correctIndex: 2,
          explanation: 'يُستخدم سؤال «كم ثمن هذا؟» للاستفسار عن سعر شيء.',
        ),
        QuizQuestionModel(
          id: 'q2_3',
          questionText: 'أي عبارة تعبّر عن امتنان كبير؟',
          options: ['بالطبع', 'شكراً جزيلاً', 'أنا آسف', 'أراك قريباً'],
          correctIndex: 1,
          explanation: 'تعبّر عبارة «شكراً جزيلاً» عن امتنان كبير.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_3',
      title: 'السفر والأرقام والاتجاهات',
      description: 'تدرّب على السؤال عن الطريق والعدّ ومفردات السفر الأساسية.',
      questions: [
        QuizQuestionModel(
          id: 'q3_1',
          questionText: 'أي سؤال يستفسر عن مكان محطة المترو؟',
          options: [
            'متى يصل القطار؟',
            'أين محطة المترو؟',
            'كم سعر تذكرة الحافلة؟',
            'هل الفندق مفتوح اليوم؟',
          ],
          correctIndex: 1,
          explanation: 'يسأل تعبير «أين محطة المترو؟» عن موقع المحطة.',
        ),
        QuizQuestionModel(
          id: 'q3_2',
          questionText: 'أي تسلسل يمثل الأعداد 1، 2، 3 باللغة العربية؟',
          options: [
            'عشرة، عشرون، ثلاثون',
            'واحد، اثنان، ثلاثة',
            'الأول، الثاني، الثالث',
            'أربعة، خمسة، ستة',
          ],
          correctIndex: 1,
          explanation: '«واحد، اثنان، ثلاثة» هو تسلسل الأعداد 1 و2 و3.',
        ),
        QuizQuestionModel(
          id: 'q3_3',
          questionText: 'ما معنى كلمة «تذكرة» في سياق السفر؟',
          options: ['تذكرة', 'أمتعة', 'طائرة', 'جواز سفر'],
          correctIndex: 0,
          explanation:
              'تُستخدم التذكرة للسفر بالحافلة أو القطار أو وسيلة نقل أخرى.',
        ),
      ],
    ),
  ];
}
