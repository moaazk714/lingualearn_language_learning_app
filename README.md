# 🌐 LinguaLearn – Modern Language Learning Mobile Application

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![State Management](https://img.shields.io/badge/State_Management-Provider-blue)](https://pub.dev/packages/provider)
[![Design](https://img.shields.io/badge/UI%2FUX-Google_Stitch_AI-6366F1)](https://flutter.dev)
[![Internship](https://img.shields.io/badge/CodeAlpha-Project_4-success)](https://codealpha.tech)

**LinguaLearn** is a production-grade, offline-capable mobile language learning application engineered with **Flutter**, **Dart**, **Provider**, and **Material Design 3**.

Developed as **Project 4 of the CodeAlpha Flutter Development Internship**, the application translates modern UI/UX designs generated with **Google Stitch AI** into a 1:1 pixel-accurate, feature-rich interactive application suitable for developer portfolios, GitHub showcases, and mobile development demos.

---

## 📱 Stitch AI Design Implementation

| Screen | Stitch AI Design Reference | Implementation Details |
|---|---|---|
| **Splash Screen** | Luminous pastel gradient, dual-tone logo, orbiting satellite chips, 120+ Immersion Pathways trust pill | Animated logo, dual-tone typography, smooth progress bar, Flutter & Dart attribution, sync metadata |
| **Onboarding** | 3-step carousel, elevated white card, floating language chips (`¡Hola!`, `Bonjour!`, `Hello!`), AI Coach callout | Smooth PageView, interactive language speech chips, active elongated pill indicators, persistent completion |
| **Language & Level Selection** | 6 country flags, active learner counts, Popular tag, 3 starting levels (A1-A2, B1-B2, C1), 15-min daily habit card | Full interactive selection with active indigo borders, checkmarks, dynamic level switching, offline persistence |
| **Home Dashboard** | Stats row (Streak, Today's Goal, Mastered), Hero Current Unit gradient banner, Quick Practice, Word of the Day, 7-Day Pill Bar Chart | Real calculation engines, resume action, pronunciation playback, add to flashcards bookmarking, weekly activity |

---

## ✨ Core Features

### 1. 🚀 Splash & Multi-Step Onboarding
- Luminous ambient gradient background matching Stitch AI.
- Central layered brand disc with floating satellite translation badges (`文/A`, `✨`).
- 3-step carousel with floating flag pills and AI Coach voice feedback highlight.
- Local persistence so onboarding is presented only on initial launch.

### 2. 🌍 Multilingual Learning Pathways
- Supports **Spanish** (Español), **French** (Français), **German** (Deutsch), **Japanese** (日本語), **English** (UK/US), and **Arabic** (العربية).
- Level selection: **Beginner (A1-A2)**, **Intermediate (B1-B2)**, and **Advanced (C1)**.
- Live language switcher modal accessible from anywhere on the dashboard.

### 3. 📊 Interactive Home Dashboard
- **Personalized Header:** Dynamic greeting, language dropdown chip, user avatar with status ring.
- **Daily Stats Row:**
  - **Streak Card:** Flame badge, current streak days, freeze counts.
  - **Today's Goal Card:** Animated circular progress indicator showing target completion percentage.
  - **Mastered Words Card:** Trend metrics with weekly growth.
- **Hero Current Unit Banner:**
  - Recreates Unit 2: *"Ordering at a Café"* (`Lesson 4 of 8 • Basic Greetings`).
  - Bright lime-green progress bar, remaining time estimate, and white `▶ Resume` CTA button.
- **Quick Practice:** Fast shortcuts to Flashcards, Quick Quizzes, and Speech Pronunciation.
- **Word of the Day:** Features *"El Desayuno"* with phonetic spelling `[el de-sa-'ju-no]`, part of speech, contextual quote sentence, pronunciation playback, and direct bookmarking to flashcards.
- **Weekly Activity Chart:** 7-day pill bar chart (`M, T, W, T, F, S, S`) with completed day checkmarks and active day lightning gradient.

### 4. 📚 Structured Curriculum & Lesson Details
- Comprehensive units with sequential locked and unlocked lesson progression.
- Lesson overview cards with estimated duration, bulleted learning objectives, and vocabulary previews.
- Direct handoff into interactive lesson flashcards and quizzes.

### 5. 🃏 Interactive 3D Flip Flashcards
- Realistic 3D perspective flip animation between front (target word, phonetics, audio) and back (translation, part of speech, contextual sentence).
- Card counter progress bar (`Card X of Y`).
- Single-tap **"Mark as Learned"** action that updates your mastered word metrics.
- Instant favorite bookmark toggle.
- Previous / Next navigation controls.

### 6. 🎯 Dynamic Multiple-Choice Quizzes & Results
- Question bank with 4 randomized answer options.
- Immediate visual feedback on answer selection (success emerald vs error rose).
- Detailed answer explanations explaining grammatical rules and vocabulary distinctions.
- **Results Engine:** Dynamic score calculation, accuracy percentage, motivational feedback tiers, and question-by-question answer reviews.

### 7. 📖 Vocabulary Library
- Real-time search across target language words and English translations.
- Category filtering: **All**, **Food & Dining**, **Greetings**, **Travel**, **Numbers**.
- Filter chips for **Saved Favorites** and **Learned Words**.
- Pronunciation cues and contextual example sentences.

### 8. 📈 Comprehensive Progress Tracking
- Live metrics: Total words learned, completed lessons, learning minutes, and streak count.
- Daily habit target progress ring.
- Achievement badges system with unlocked and locked states.

### 9. ⚙️ Profile & Custom Settings
- Editable user profile name and avatar.
- Target language and proficiency level switching.
- Daily habit goal selector (10, 15, 20, 30, 45 mins).
- High-contrast **Dark Mode** toggle.
- Sound effects and daily practice notifications settings.
- Reset all learning data with safety confirmation dialog.

---

## 🏗️ Architecture & State Management

LinguaLearn follows a clean, layered architecture separating UI presentation, state management, and offline persistence:

```
lib/
├── main.dart                          # App entry point, MultiProvider initialization
├── app/
│   ├── app.dart                       # MaterialApp, ThemeMode, Route mapping
│   └── routes.dart                    # Centralized named routes
├── core/
│   ├── constants/
│   │   ├── app_colors.dart            # Stitch AI exact color tokens & gradients
│   │   ├── app_strings.dart           # UI labels, titles, and copy
│   │   └── app_dimensions.dart        # Responsive padding, border radii, shadows
│   ├── data/
│   │   └── app_mock_data.dart         # Multilingual courses, quizzes, and vocabulary
│   └── theme/
│       └── app_theme.dart             # Material 3 light & dark theme definitions
├── models/
│   ├── language_model.dart            # Language metadata & emojis
│   ├── course_model.dart              # Course & Unit models
│   ├── lesson_model.dart              # Lesson objectives & duration
│   ├── vocabulary_model.dart          # Words, phonetics & categories
│   ├── quiz_model.dart                # Questions, options & quiz results
│   └── user_progress_model.dart       # Daily activity & achievement badges
├── providers/
│   ├── language_provider.dart         # Active target language & level state
│   ├── course_provider.dart           # Lesson completion & unlocked units state
│   ├── vocabulary_provider.dart       # Flashcards queue & favorite bookmarks
│   ├── quiz_provider.dart             # Active quiz session & score computation
│   ├── progress_provider.dart         # Habit streaks & study time tracking
│   └── settings_provider.dart         # Dark mode, daily goal & profile settings
├── services/
│   └── storage_service.dart           # SharedPreferences offline persistence layer
├── screens/
│   ├── splash/                        # Animated brand launch screen
│   ├── onboarding/                    # 3-step carousel onboarding
│   ├── language_selection/            # Language & level picker
│   ├── main_navigation_screen.dart    # 5-tab persistent bottom navigation
│   ├── home/                          # Home dashboard screen
│   ├── learn/                         # Structured curriculum screen
│   ├── lesson_details/                # Objectives & lesson overview
│   ├── flashcards/                    # Interactive 3D flip card practice
│   ├── quiz/                          # Multiple-choice interactive quiz
│   ├── quiz_result/                   # Score results & answer review
│   ├── vocabulary/                    # Searchable vocabulary library
│   ├── progress/                      # Statistics & badge achievements
│   └── profile/                       # Settings, dark mode & user profile
└── widgets/
    ├── custom_button.dart             # Reusable capsule CTA buttons
    ├── stats_card.dart                # Streak & habit stats cards
    ├── unit_banner_card.dart          # Hero current unit gradient banner
    ├── quick_practice_card.dart       # Practice shortcut cards
    ├── word_of_the_day_card.dart      # Daily vocabulary drop card
    ├── weekly_activity_chart.dart     # 7-day pill bar chart
    ├── lingua_app_bar.dart            # Custom header with notification bell
    └── empty_state.dart               # Empty state placeholder
```

---

## 📦 Packages & Dependencies

| Dependency | Purpose |
|---|---|
| [`provider: ^6.1.2`](https://pub.dev/packages/provider) | Predictable, reactive state management using `ChangeNotifier` |
| [`shared_preferences: ^2.3.2`](https://pub.dev/packages/shared_preferences) | Fast local key-value storage for offline data persistence |
| [`google_fonts: ^6.2.1`](https://pub.dev/packages/google_fonts) | Clean Poppins typography matching Google Stitch AI designs |
| [`flutter_animate: ^4.5.0`](https://pub.dev/packages/flutter_animate) | Micro-interactions, splash animations, and badge entrance effects |
| [`percent_indicator: ^4.2.3`](https://pub.dev/packages/percent_indicator) | Circular and linear progress indicators for goal and quiz tracking |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.5.0` or later
- Dart SDK `^3.5.0` or later
- Android Studio / VS Code with Flutter extension
- Android Virtual Device (AVD) or physical device

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/lingualearn_app.git
   cd lingualearn_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify static analysis:**
   ```bash
   flutter analyze
   ```

4. **Run unit & widget test suite:**
   ```bash
   flutter test
   ```

5. **Launch the application:**
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Quality Assurance

LinguaLearn includes an automated test suite verifying provider logic, score calculations, habit tracking, and widget rendering:

```bash
flutter test
# Output: All 15 tests passed!
```

---

## 👨‍💻 Author & Acknowledgements

- **Developer:** Flutter Developer Intern
- **Program:** [CodeAlpha Flutter Development Internship](https://codealpha.tech) – Project 4
- **UI Design Reference:** Generated with **Google Stitch AI**
