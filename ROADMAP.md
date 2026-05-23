# 🌌 Good Dream - Karta Rozwoju Aplikacji (Roadmap & Propozycje)

Ten dokument zawiera pomysły i propozycje rozwoju aplikacji **Good Dream** w celu przekształcenia jej w produkt klasy **Premium UX/UI** z zaawansowaną integracją sztucznej inteligencji.

---

## 🎨 1. Wizualne Efekty Premium (Visual WOW Factor)
Aby aplikacja wyglądała luksusowo i nowocześnie, możemy wzbogacić ją o dynamiczne elementy wizualne:

* **🌌 Interaktywny Wizualizator Galaktyki (Galaxy Visualizer):**
  * Dodanie na głównym ekranie animacji cząsteczkowej (np. wirującej mgławicy, gwiezdnego pyłu lub pulsującej zorzy).
  * Prędkość, intensywność i kolor animacji mogłyby płynnie reagować na to, jakie dźwięki są włączone i jak głośno grają.
* **✨ Płynne Animacje Przejść (Micro-interactions):**
  * Subtelne, przestrzenne przejścia (skalowanie, rozmycie tła) przy otwieraniu asystenta AI oraz suwaków głośności.
  * Animowany efekt pulsu wokół kafelka aktywnego miksu w ulubionych.

---

## 🔊 2. Zaawansowane Funkcje Audio (Premium Soundscapes)
Udoskonalenie samego odtwarzacza dźwięków, aby konkurować z wiodącymi aplikacjami relaksacyjnymi:

* **⏳ Płynne Wyciszanie na Koniec Timera (Fade-out):**
  * Zamiast nagłego wyłączenia odtwarzacza po upływie czasu, dźwięki będą stopniowo i płynnie cichnąć (np. w ciągu ostatnich 2-3 minut). Zapobiega to nagłemu wybudzeniu użytkownika.
* **🧠 Fale Binauralne (Binaural Beats):**
  * Wprowadzenie generatora czystych częstotliwości relaksacyjnych (np. fale Delta ułatwiające głęboki sen lub Theta pomagające w medytacji), które można zmiksować z dźwiękami lasu, deszczu czy jaskini.

---

## 🤖 3. Nowa Generacja Asystenta AI (Genkit & Personalizacja)
Przeniesienie funkcji AI na wyższy poziom zaawansowania architektury:

* **🚀 Migracja na Genkit Dart:**
  * Wdrożenie frameworka Firebase Genkit w języku Dart dla serwera backend.
  * Wykorzystanie **Genkit Developer UI** do monitorowania promptów, testowania modeli i optymalizacji czasu odpowiedzi.
* **💬 Pamięć Kontekstu Rozmowy (Chat Memory):**
  * Asystent AI będzie pamiętał poprzednie rozmowy i preferencje użytkownika (np. *"Pamiętam, że wczoraj pomogłem Ci zasnąć przy deszczu. Czy dzisiaj też chcesz coś podobnego, czy wolisz spróbować lasu?"*).
* **🧘 Medytacje Prowadzone przez AI (Guided Meditations):**
  * Asystent może generować spersonalizowane teksty medytacyjne/oddechowe na podstawie nastroju i odczytywać je na ekranie (lub w przyszłości za pomocą syntezatora mowy).

---

## 📴 4. Niezawodność i Działanie Offline (Offline First)
Zapewnienie pełnej niezawodności aplikacji niezależnie od połączenia sieciowego:

* **💾 Migracja na zaawansowaną bazę (Hive / Isar):**
  * Obecnie z powodzeniem używamy prostego, szybkiego magazynu **`GetStorage`** (klucz-wartość) do zapisywania ulubionych miksów, wybranego języka oraz motywu graficznego.
  * W przyszłości, przy rozbudowie aplikacji o historię czatów z AI lub zaawansowane wyszukiwanie i filtrowanie zapisanych miksów, możemy zmigrować na obiektową bazę **Hive** lub **Isar**. Pozwoli to na silne typowanie obiektów (Type Safety) oraz zaawansowane zapytania (Queries).
* **✈️ Pełny tryb Offline:**
  * Zapewnienie, że wszystkie podstawowe funkcje odtwarzacza i wczytywanie zapisanych lokalnie miksów działają całkowicie bez dostępu do sieci (np. w podróży samolotem).
